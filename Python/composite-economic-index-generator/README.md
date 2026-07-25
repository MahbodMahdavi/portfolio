# Composite Economic Index Generator

A Python project for generating composite economic indices from multiple Federal Reserve Economic Data (FRED) time series.

The project processes economic indicators through configurable statistical transformations, weighting schemes, and index calculations to produce standardized composite indices suitable for economic analysis and reporting.

---

## Project Overview

This project combines multiple economic indicators into a single composite index using a configurable processing pipeline.

Each economic series is independently transformed, standardized, weighted, and aggregated before being combined into a composite index.

The project was designed to support repeatable economic analysis through a configuration-driven architecture.

---

## Features

- Multi-series economic data processing
- Configurable weighting system
- Moving average calculations
- Symmetric percentage change calculations
- Multiple standardization methods
- Trend adjustment
- Composite index generation
- Individual component contribution analysis
- CSV output generation
- JSON-driven configuration

---

## Project Workflow

### 1. Load Configuration

Project settings are loaded from JSON configuration files, including:

- Economic series
- Indicator weights
- Transformation parameters
- Output settings

---

### 2. Import Economic Data

Economic time series are imported and aligned into a single dataset for analysis.

Examples include:

- Interest rates
- Industrial production
- Producer Price Index (PPI)
- Employment statistics
- Building permits

---

### 3. Data Processing

Each indicator undergoes several processing steps, including:

- Moving average smoothing
- Symmetric percentage difference calculations
- Standardization
- Trend adjustment
- Weighting

---

### 4. Composite Index Generation

Processed indicators are combined into a weighted composite index.

The project also calculates the contribution of each indicator to the final index.

---

### 5. Output

The final outputs include:

- Composite Index
- Composite Growth Rate
- Individual Indicator Contributions
- Processed CSV files

---

## Technologies Used

- Python
- Pandas
- NumPy
- pandas_datareader
- JSON

---

## Skills Demonstrated

- Python programming
- Time-series analysis
- Statistical transformations
- Data standardization
- Moving average calculations
- Weighted index construction
- Economic data analysis
- Configuration-driven development
- JSON configuration
- Data processing
- Automation
- Modular software design

---

## Project Structure

```text
composite-economic-index-generator/
│
├── README.md
├── requirements.txt
├── generate_composite_index.py
├── config/
│   ├── primary_metals_config.json
│   └── ...
├── sample_output/
│   ├── composite_index.csv
│   └── contribution_report.csv
└── docs/
    └── methodology.md
```

---

## Future Enhancements

Potential improvements include:

- Additional economic indices
- Visualization dashboards
- Automated validation
- Unit testing
- Performance optimization
- Interactive reporting

---

## Author

**Mahbod Mahdavi**

Senior Data Analyst Portfolio

- LinkedIn: https://www.linkedin.com/in/mahbodmahdavi
- GitHub: https://github.com/mahbodmahdavi
