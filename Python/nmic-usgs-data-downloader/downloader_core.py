# downloader_core.py

import os
import csv
import logging
import shutil
import requests
from datetime import datetime
from time import sleep
from concurrent.futures import ThreadPoolExecutor, as_completed
from bs4 import BeautifulSoup


def get_iso_version_folder(base_path: str, prefix: str) -> tuple[str, str]:
    timestamp = datetime.now().isoformat(timespec='minutes').replace(':', '-')
    folder_name = f"{prefix}_{timestamp}"
    full_path = os.path.join(base_path, folder_name)
    os.makedirs(full_path, exist_ok=True)
    return full_path, timestamp


def extract_excel_links(html: str) -> list[str]:
    soup = BeautifulSoup(html, "html.parser")
    return [a["href"] for a in soup.find_all("a", href=True) if a["href"].lower().endswith(('.xls', '.xlsx'))]


def configure_logger(log_path: str, logger_name: str) -> logging.Logger:
    logger = logging.getLogger(logger_name)
    logger.setLevel(logging.INFO)

    if not logger.handlers:
        file_handler = logging.FileHandler(log_path, mode='a', encoding='utf-8')
        formatter = logging.Formatter('%(asctime)s [%(levelname)s] %(message)s')
        file_handler.setFormatter(formatter)
        logger.addHandler(file_handler)

    return logger


def save_link_log(links: list[tuple[str, str]], target_dir: str, filename: str, validate: bool = False, status_callback=None) -> None:
    log_path = os.path.join(target_dir, filename)

    def check_link(name: str, url: str) -> tuple[str, str, str, str]:
        try:
            r = requests.get(url, timeout=10)
            r.raise_for_status()
            return (name, url, "success", "")
        except Exception as e:
            return (name, url, "failure", str(e))

    with open(log_path, mode="w", newline="", encoding="utf-8") as csvfile:
        writer = csv.writer(csvfile)
        if validate:
            with ThreadPoolExecutor(max_workers=10) as executor:
                futures = {executor.submit(check_link, name, url): (name, url) for name, url in links}
                for i, future in enumerate(as_completed(futures)):
                    name, url, status, message = future.result()
                    writer.writerow([name, url, status, message])
                    if status_callback:
                        status_callback(f"Validating {i + 1:,} of {len(links):,}:\n{name}")
        else:
            for name, url in links:
                writer.writerow([name, url])


def download_single_file(name: str, url: str, download_dir: str, status_callback=None, logger=None) -> str:
    filename = url.split("/")[-1].split("?")[0]
    filepath = os.path.join(download_dir, filename)
    if status_callback:
        status_callback(f"Downloading: {name} ...")

    for attempt in range(3):
        try:
            response = requests.get(url, timeout=(5, 30))
            response.raise_for_status()
            with open(filepath, "wb") as f:
                f.write(response.content)
            if logger:
                logger.info(f"Downloaded: {filepath}")
            return f"Downloaded: {filepath}"
        except (requests.ConnectionError, requests.Timeout) as net_err:
            if logger:
                logger.warning(f"Retry {attempt + 1} for {url} due to {net_err}")
            sleep(1.5)
        except Exception as e:
            if logger:
                if hasattr(e, "response") and e.response is not None:
                    status = e.response.status_code
                    logger.error(f"{status} Error: {url}")
                else:
                    logger.error(f"Download failed: {url} | {e}")
            break
    if logger:
        logger.error(f"Failed: {url}")
    return f"Failed: {url}"


def download_files_concurrently(links, target_dir, status_callback=None, progress_callback=None, logger=None):
    total = len(links)
    with ThreadPoolExecutor(max_workers=50) as executor:
        futures = [
            executor.submit(download_single_file, name, url, target_dir, status_callback, logger)
            for name, url in links
        ]
        for i, future in enumerate(as_completed(futures), start=1):
            result = future.result()
            if logger:
                logger.info(result)
            if progress_callback:
                percent = int((i / total) * 100)
                progress_callback(percent)


def move_log_files_to_subdir(target_path: str) -> None:
    log_dir = os.path.join(target_path, "log")
    os.makedirs(log_dir, exist_ok=True)
    for file in os.listdir(target_path):
        if file.endswith(".csv") or file.endswith(".txt"):
            src = os.path.join(target_path, file)
            dst = os.path.join(log_dir, file)
            try:
                shutil.move(src, dst)
            except PermissionError:
                logger = logging.getLogger("downloader_core")
                logger.warning(f"File in use and cannot be moved: {src}")
