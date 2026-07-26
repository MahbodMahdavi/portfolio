# NMIC USGS Data Downloader

A desktop application built with **Python** and **PySide6** that automates downloading publicly available mineral commodity and regional datasets from the **U.S. Geological Survey (USGS) National Minerals Information Center (NMIC)**.

The application provides an intuitive graphical interface for selecting a download location, retrieving available Excel datasets directly from the USGS website, downloading files concurrently, and organizing them into timestamped folders with detailed logs.

---

## Features

- Desktop application built with PySide6
- Download Commodity Statistics (Volume I) datasets
- Download Regional Data (Volume III) datasets
- Automatically discover downloadable Excel files
- Concurrent downloads for improved performance
- Real-time progress updates
- Status messages during downloads
- Timestamped download folders
- Automatic download logging
- Persistent download location using application settings
- Standalone Windows executable

---

## Technologies

- Python
- PySide6
- Requests
- BeautifulSoup4
- concurrent.futures
- PyInstaller

---

## Project Structure

```text
nmic-usgs-data-downloader/
│
├── assets/
│   ├── usgs_logo_blue.png
│   ├── usgs_logo_blue.ico
│   └── usgs_logo_blue_download.ico
│
├── screenshots/
│   └── application-home.png
│
├── main.py
├── gui.py
├── downloader_core.py
├── v1_downloader.py
├── v3_downloader.py
├── config.py
├── custom_rounded_progressbar.py
├── main.spec
├── requirements.txt
├── LICENSE
├── .gitignore
└── README.md
```

---

## Application Overview

The application supports two download modes:

### Commodity Statistics (Volume I)

Downloads Excel datasets for available mineral commodities published by the USGS National Minerals Information Center.

Examples include:

- Copper
- Gold
- Iron Ore
- Lithium
- Nickel
- Rare Earths
- Zinc

---

### Regional Data (Volume III)

Downloads regional mineral information for major geographic regions, including:

- Africa and the Middle East
- Asia and the Pacific
- Europe and Central Eurasia
- Latin America and Canada
- South America

---

## How It Works

1. Launch the application.
2. Select a publication type.
3. Choose a destination folder.
4. Click **Start**.
5. The application retrieves available download links from the USGS website.
6. Files are downloaded concurrently.
7. Download logs are generated automatically.
8. Files are organized into timestamped folders.

---

## Screenshot

### Main Application

![NMIC Web Scraper Tool](screenshots/application-home.png)

---

## Skills Demonstrated

- Desktop application development
- GUI development with PySide6
- Web scraping
- HTTP requests
- Concurrent programming
- Multithreading
- File management
- Logging
- Software architecture
- Application packaging
- Process automation

---

## Future Improvements

- Retry failed downloads
- Download filtering by publication
- Automatic update checking
- Download history
- Search functionality
- Scheduled downloads

---

## Requirements

Install the required packages:

```bash
pip install -r requirements.txt
```

---

## Building the Executable

To create the standalone Windows executable:

```bash
pyinstaller main.spec
```

The executable will be generated in the `dist` folder.

---

## Data Source

**U.S. Geological Survey (USGS)**

National Minerals Information Center (NMIC)

https://www.usgs.gov/centers/national-minerals-information-center

---

## Disclaimer

This application is an independent utility that automates downloads from publicly available resources provided by the U.S. Geological Survey (USGS) National Minerals Information Center (NMIC). It is not affiliated with, endorsed by, or maintained by the U.S. Geological Survey.

---

## License

This project is licensed under the MIT License. See the **LICENSE** file for details.
