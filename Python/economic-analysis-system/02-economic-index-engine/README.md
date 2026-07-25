# Economic Index Engine

## Overview

The Economic Index Engine is the analytical core of the Economic Analysis System. It transforms merged economic datasets into composite industry indices using a configurable, data-driven architecture inspired by a legacy USGS Fortran application.

Rather than hard-coding calculations for each index, the engine reads JSON configuration files that define component series, weights, transformations, and output settings. This allows the same processing pipeline to generate multiple economic indices with minimal code changes.

---

## Objectives

- Modernize a legacy Fortran economic index system
- Create a reusable and configurable calculation engine
- Support multiple industry-specific composite indices
- Produce standardized index and contribution outputs
- Separate methodology from implementation through configuration files

---

## Features

- Configuration-driven processing
- Multiple composite index support
- Moving average smoothing
- Symmetric percent difference calculations
- Difference calculations
- Standardization methods
- Weighted aggregation
- Trend adjustments
- Index rebasing
- Component contribution calculations
- Legacy Fortran methodology translated to Python

---

## Supported Indices

- Copper
- Steel
- Primary Metals
- Non-Metallic Mineral Products

---

## Repository Structure

```
02-economic-index-engine/
│
├── config/
│   ├── config_copper.json
│   ├── config_steel.json
│   ├── config_primary_metals.json
│   └── config_non-metallic.json
│
├── engine/
│   ├── step_3_automated_index.py
│   ├── python_fortran_calculation_conversion.py
│   └── supporting modules
│
├── mappings/
│   ├── FRED Series Map.py
│   ├── fortran_to_python_mapping.json
│   └── fortran_to_python_calculations.json
│
├── documentation/
│   ├── data_file_dictionary.json
│   └── methodology documentation
│
├── publication/
│   ├── mii_pub.json
│   └── usgs_mii_table-2_generator.py
│
├── sample_output/
│
└── README.md
```

---

## Processing Workflow

1. Load merged economic dataset
2. Read selected index configuration
3. Create derived variables
4. Apply moving average smoothing
5. Calculate rate-of-change measures
6. Standardize each component
7. Apply component weights
8. Compute component contributions
9. Generate composite index
10. Export results

---

## Technologies

- Python
- Pandas
- NumPy
- JSON
- FRED Economic Data

---

## Legacy Modernization

This repository represents the modernization of a legacy USGS economic index system originally developed in Fortran. The project preserves the original analytical methodology while replacing procedural code with a modular, configuration-driven Python architecture.

The repository includes:

- Python implementations of legacy calculation routines
- Documentation mapping Fortran variables to Python components
- Configuration files replacing hard-coded parameters
- Supporting documentation describing data sources and methodology

---

## Future Enhancements

- Automated publication pipeline
- Excel report generation
- Additional industry index configurations
- Validation and regression testing
- Expanded documentation
