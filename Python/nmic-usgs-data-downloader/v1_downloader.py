# v1_downloader.py

import os
from config import commodities_url
from downloader_core import (
    get_iso_version_folder,
    extract_excel_links,
    configure_logger,
    save_link_log,
    download_files_concurrently,
    move_log_files_to_subdir
)
import requests
import logging
logger = None


def scrape_commodity_links() -> list[tuple[str, str]]:
    links = []
    for commodity, url in commodities_url.items():
        try:
            response = requests.get(url, timeout=10)
            response.raise_for_status()
            for link in extract_excel_links(response.text):
                links.append((commodity, link))
        except Exception as e:
            logger.warning(f"Failed to fetch {commodity}: {e}")
    return links


def main(base_path: str, status_callback=None, progress_callback=None) -> None:
    global logger
    target_dir, timestamp = get_iso_version_folder(base_path, "v1_downloads")
    log_path = os.path.join(target_dir, f"v1_log_{timestamp}.txt")
    logger = configure_logger(log_path, "v1_downloader")

    links = scrape_commodity_links()
    save_link_log(links, target_dir, "nmic_commodity_url.csv", validate=False)
    download_files_concurrently(links, target_dir, status_callback, progress_callback, logger)
    move_log_files_to_subdir(target_dir)


def run_v1_download(download_path: str, status_callback=None, progress_callback=None):
    if download_path:
        main(download_path, status_callback, progress_callback)


if __name__ == "__main__":
    main(os.getcwd())
