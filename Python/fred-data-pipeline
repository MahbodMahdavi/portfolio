# FRED Data Pipeline

A Python desktop application for downloading economic time series from the Federal Reserve Economic Data (FRED) database.

The application provides a graphical interface that allows users to select datasets, download them with a single click, monitor progress in real time, and save the results as CSV files.

---

## Features

- Graphical user interface
- Select individual FRED datasets
- Download multiple datasets simultaneously
- Real-time progress updates
- Progress bar and status messages
- Automatic CSV export
- Selectable output directory
- Timestamped logging
- Error handling and retry reporting
- Easily expandable dataset configuration

---

## Current Datasets

| Series ID | Description |
|-----------|-------------|
| AWHAEMAN | Average Weekly Hours |
| PERMIT | New Private Housing Permits |
| GS10 | 10-Year Treasury Constant Maturity Rate |
| FEDFUNDS | Effective Federal Funds Rate |
| IPG327S | Industrial Production - Nonmetallic Mineral Products |
| WPUSI012011 | Producer Price Index - Construction Materials |

Additional FRED series can be added through the configuration file without modifying application code.

---

## Technologies

- Python 3.12+
- Tkinter
- pandas
- pandas_datareader
- pathlib
- threading
- logging

---

## Project Structure

```
fred-data-pipeline/
│
├── app.py
├── config.py
├── requirements.txt
├── README.md
│
├── pipeline/
│   ├── downloader.py
│   ├── fred_client.py
│   ├── file_manager.py
│   └── logger.py
│
├── ui/
│   └── main_window.py
│
├── data/
│
└── logs/
```

---

## Application Workflow

```
Select datasets
        │
        ▼
Choose output folder
        │
        ▼
Start Download
        │
        ▼
Retrieve data from FRED
        │
        ▼
Save CSV files
        │
        ▼
Update progress
        │
        ▼
Generate log file
        │
        ▼
Display completion summary
```

---

## Example Output

```
Starting download...

Downloading AWHAEMAN...
Saved avg_weekly_hours.csv

Downloading PERMIT...
Saved building_permits.csv

Downloading GS10...
Saved treasury_10yr.csv

Download complete.

6 of 6 datasets downloaded successfully.
```

---

## Skills Demonstrated

- Python application development
- API integration
- ETL pipeline design
- GUI development
- Configuration management
- File system operations
- Logging
- Exception handling
- Multithreading
- Modular software architecture

---

## Future Enhancements

- Configuration editor within the application
- Scheduled automatic downloads
- Incremental updates
- Export to Excel
- SQLite/PostgreSQL integration
- Interactive charts
- Metadata viewer
- Download history
- PyInstaller executable
- Unit testing with pytest
- GitHub Actions CI/CD

---

## Screenshot

*GUI screenshot to be added after implementation.*

---

## License

This project is released under the MIT License.
