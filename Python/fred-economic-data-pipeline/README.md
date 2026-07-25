# FRED Economic Data Pipeline

A modular Python project that automates the retrieval, processing, and reporting of economic data from the Federal Reserve Economic Data (FRED) database.

The project was developed to support the creation of composite economic indices by implementing a repeatable data pipeline consisting of automated data acquisition, data processing, configuration management, and Excel report generation.

---

## Project Overview

This project automates the collection of multiple economic time series from FRED and prepares them for downstream analysis and reporting.

The pipeline is designed to be modular, making it easy to maintain, extend, and adapt to new economic indicators without modifying the core application.

---

## Features

- Automated FRED data downloads
- Configurable economic series
- Date-stamped data storage
- Data validation and preprocessing
- Excel table generation
- JSON-driven configuration
- Modular project architecture

---

## Project Structure

```text
fred-economic-data-pipeline/
│
├── README.md
├── requirements.txt
├── config/
│   ├── series_config.json
│   ├── dictionary.json
│   └── ...
├── data/
│   ├── raw/
│   └── processed/
├── pipeline/
│   ├── download_fred_data.py
│   ├── process_data.py
│   └── generate_excel_tables.py
├── utils/
│   └── helper_functions.py
└── output/
```

---

## Workflow

### 1. Data Acquisition

The pipeline downloads multiple economic indicators from the Federal Reserve Economic Data (FRED) database and stores the data in organized, date-stamped directories.

Examples include:

- Treasury rates
- Federal Funds Rate
- Building permits
- Industrial production
- Producer Price Index (PPI)
- Employment and labor statistics

---

### 2. Data Processing

Downloaded datasets are cleaned, validated, standardized, and prepared for downstream analysis.

Processing tasks include:

- Data transformation
- Date alignment
- Missing value handling
- Dataset merging
- Preparation for reporting

---

### 3. Report Generation

Processed datasets are converted into structured Excel reports for analysis and business use.

The reporting module generates formatted tables suitable for publication and internal reporting.

---

### 4. Configuration

The project uses JSON configuration files to define:

- Economic series
- Metadata
- Variable mappings
- Project settings

Separating configuration from application logic improves maintainability and simplifies future enhancements.

---

## Technologies Used

- Python
- Pandas
- pandas_datareader
- JSON
- Microsoft Excel

---

## Skills Demonstrated

- Python programming
- ETL pipeline development
- Data acquisition
- Data preprocessing
- Configuration management
- Automation
- Modular software design
- File management
- Economic data analysis

---

## Future Enhancements

Potential improvements include:

- Logging
- Configuration validation
- Command-line interface (CLI)
- Unit testing
- Scheduled pipeline execution
- Cloud storage integration

---

## Author

**Mahbod Mahdavi**

Senior Data Analyst Portfolio

- LinkedIn: https://www.linkedin.com/in/mahbodmahdavi
- GitHub: https://github.com/mahbodmahdavi
