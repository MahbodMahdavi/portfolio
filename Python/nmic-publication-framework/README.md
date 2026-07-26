# NMIC Publication Framework

## Overview

The NMIC Publication Framework is a metadata-driven publication engine designed to modernize the National Minerals Information Center (NMIC) mineral commodity publication process.

The framework separates business logic, calculations, metadata, and presentation into reusable configuration files, allowing multiple mineral commodity publications to be generated from a common software platform.

The project was originally developed to address limitations in the legacy publication workflow, including manual spreadsheet construction, inconsistent data formatting, limited machine readability, and lack of Section 508 accessibility.

---

## Motivation

Historically, NMIC commodity publications are distributed in two formats:

- PDF publications for human consumption
- Excel workbooks containing statistical tables

Although both formats present the same information, they are manually maintained and optimized primarily for visual presentation.

This approach introduces several challenges:

- Manual table construction
- Repetitive formatting tasks
- Inconsistent data types
- Embedded citation markers within numeric cells
- Limited machine readability
- Non-accessible document structure
- Increased opportunity for human error

The goal of this project is to replace manual publication development with a metadata-driven publication framework capable of generating consistent, reusable, and accessible outputs.

---

## Project Goals

- Automate publication generation
- Separate data from presentation
- Preserve numeric data types
- Generate machine-readable datasets
- Generate human-readable publications
- Improve Section 508 accessibility
- Eliminate repetitive manual formatting
- Support multiple mineral commodities using reusable metadata

---

## Architecture

```
                Source Data
                     │
                     ▼
          Data Validation & Processing
                     │
                     ▼
          Commodity Metadata Layer
                     │
     ┌───────────────┼────────────────┐
     │               │                │
     ▼               ▼                ▼
 Field Metadata  Calculations   Layout Metadata
     │               │                │
     └───────────────┼────────────────┘
                     ▼
          Publication Generation Engine
                     │
        ┌────────────┴────────────┐
        ▼                         ▼
 Human-facing Publication   Machine-readable Dataset
        │
        ├── Accessible Excel
        └── Accessible PDF
```

---

## Metadata-Driven Design

Rather than embedding business rules directly into application code, the framework externalizes publication behavior into JSON configuration files.

Examples include:

- Field definitions
- Metadata labels
- Calculation rules
- Source mappings
- Table layouts
- Cell formatting
- Citation definitions
- Commodity-specific configuration

Adding support for a new commodity requires creating new metadata rather than modifying the publication engine.

---

## Key Features

- Commodity-specific publication configuration
- Metadata-driven report generation
- Configuration-based calculations
- Automatic table layout
- Human-facing publication output
- Machine-readable output
- Citation management
- Consistent formatting
- Reusable publication templates

---

## Repository Structure

```
nmic-publication-framework/
│
├── config/
├── commodity/
├── definitions/
├── engine/
├── mappings/
├── output/
├── templates/
├── validation/
└── README.md
```

---

## Future Enhancements

- Additional commodity support
- Expanded publication templates
- Automated PDF generation
- Automated accessibility validation
- Integration with automated data acquisition pipelines
- Improved metadata validation
- Continuous publication testing

---

## Technologies

- Python
- JSON
- Pandas
- OpenPyXL
- Metadata-driven application design
- Excel automation
- Government statistical reporting

---

## Lessons Learned

This project demonstrates how separating data, metadata, calculations, and presentation creates a maintainable publication framework that can support multiple commodities while improving data quality, reducing manual effort, and producing more accessible outputs.

The resulting architecture replaces document-centric workflows with reusable, metadata-driven publication generation.
