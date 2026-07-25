# Economic Index Modernization

A Python reimplementation of a legacy Fortran application used to generate composite economic indices from Federal Reserve Economic Data (FRED).

This project modernizes a decades-old analytical system by replacing procedural code and interactive workflows with a modular, configuration-driven Python implementation while preserving the original statistical methodology.

---

## Project Overview

The original application was written in Fortran and used internally to construct composite economic indices from multiple time series. The program performed a series of statistical transformations, standardized each component, combined weighted indicators, and produced composite indices for economic analysis. :contentReference[oaicite:0]{index=0}

This project recreates that analytical workflow in Python using modern data science libraries and software engineering practices.

Rather than serving as a direct line-by-line translation, the project redesigns the application into a maintainable, extensible architecture with configuration-driven processing.

---

## Modernization Objectives

- Replace legacy procedural code with modular Python functions
- Eliminate interactive console input through JSON configuration
- Improve readability and maintainability
- Preserve the original analytical methodology
- Simplify future enhancements
- Produce reproducible analytical outputs

---

## Features

- Multi-series economic data processing
- JSON-driven configuration
- Configurable moving averages
- Symmetric percentage change calculations
- Multiple standardization methods
- Trend adjustment
- Weighted composite index generation
- Component contribution calculations
- CSV output generation
- Modular processing pipeline

---

## Processing Workflow

### 1. Load Configuration

Project settings are read from JSON configuration files, including:

- Economic indicators
- Series weights
- Transformation parameters
- Output settings

---

### 2. Import Economic Data

Economic indicators are downloaded and aligned into a unified dataset.

---

### 3. Statistical Processing

Each series is independently processed using configurable transformations, including:

- Moving average smoothing
- Symmetric percentage difference calculations
- Standardization
- Trend adjustment
- Weighting

---

### 4. Composite Index Construction

Processed indicators are aggregated into a weighted composite index.

The project also computes the contribution of each component to the final index.

---

### 5. Output Generation

Outputs include:

- Composite Index
- Composite Growth Rate
- Individual Component Contributions
- Processed CSV datasets

---

## Modernization Highlights

Compared to the original implementation, this project introduces several improvements:

| Legacy Fortran | Python Modernization |
|---------------|----------------------|
| Procedural architecture | Modular functions |
| Interactive console input | JSON configuration |
| Global COMMON blocks | Localized function design |
| Fixed-size arrays | Pandas DataFrames and NumPy arrays |
| Monolithic application | Reusable processing modules |
| Manual execution | Automated workflow |

---

## Technologies Used

- Python
- Pandas
- NumPy
- pandas_datareader
- JSON

---

## Skills Demonstrated

- Legacy system modernization
- Python development
- Time-series analysis
- Statistical programming
- Data standardization
- Composite index construction
- Economic data analysis
- Configuration-driven architecture
- Software refactoring
- Modular software design
- Data processing automation

---

## Project Structure

```text
economic-index-modernization/
│
├── README.md
├── build_composite_index.py
├── requirements.txt
├── config/
│   └── primary_metals_config.json
├── sample_output/
│   ├── composite_index.csv
│   └── contribution_report.csv
└── docs/
    └── modernization_notes.md
```

---

## Results

This project demonstrates how a legacy analytical application can be successfully modernized using contemporary Python tools while preserving established statistical methods.

The resulting implementation is easier to maintain, extend, test, and integrate into modern analytical workflows.

---

## Future Enhancements

Potential improvements include:

- Automated testing
- Visualization dashboards
- Additional composite indices
- Batch processing
- Database integration
- Performance optimization
- Interactive reporting

---

## Author

**Mahbod Mahdavi**

Senior Data Analyst Portfolio

- LinkedIn: https://www.linkedin.com/in/mahbodmahdavi
- GitHub: https://github.com/mahbodmahdavi
