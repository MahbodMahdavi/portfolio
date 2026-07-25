# FRED Economic Data Pipeline

A Python module for acquiring economic time series from the Federal Reserve Economic Data (FRED) database.

This project serves as the data acquisition component of the Economic Index System by downloading, organizing, and preparing economic indicators for downstream processing.

---

## Project Overview

The pipeline automates retrieval of economic indicators used in composite economic index construction.

Data acquisition is configuration-driven, allowing new indicators to be added without modifying application logic.

---

## Features

- Automated FRED downloads
- Configuration-driven indicator selection
- Historical time-series retrieval
- Automated folder organization
- Repeatable data acquisition
- Batch processing

---

## Workflow

1. Load configuration
2. Download economic indicators
3. Validate retrieved data
4. Store datasets for downstream processing

---

## Technologies

- Python
- pandas
- pandas_datareader
- JSON

---

## Skills Demonstrated

- API integration
- ETL development
- Data acquisition
- Automation
- Configuration-driven programming

---

## Related Projects

This project is part of the Economic Index System.

- 02 Economic Index Modernization
- 03 Economic Report Generator
