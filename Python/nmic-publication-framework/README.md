# NMIC Publication Framework

## Overview

The **NMIC Publication Framework** is a metadata-driven publication engine developed to modernize the National Minerals Information Center (NMIC) statistical publication process.

Rather than manually constructing Excel workbooks and PDF reports, the framework separates publication content, calculations, formatting, and presentation into reusable metadata. This architecture enables multiple mineral commodity publications to be generated from a common software platform while maintaining consistency, accessibility, and machine readability.

The project demonstrates how structured metadata can replace document-centric workflows with a scalable publication framework.

---

## Background

NMIC publishes annual and monthly mineral commodity statistics used by industry, government agencies, researchers, and the public.

Historically, these publications were produced through manually maintained spreadsheets that served as the source for both Excel and PDF publications.

Although visually effective, the legacy workflow presented several technical challenges:

- Extensive manual formatting
- Duplicate effort across publication formats
- Embedded citation markers within numeric cells
- Mixed data types
- Limited machine readability
- Difficult maintenance
- Increased opportunity for human error
- Limited accessibility for Section 508 compliance

The goal of this project was to modernize that workflow by separating data, metadata, calculations, and presentation into reusable software components.

---

# Problem Statement

Traditional publication workflows often treat spreadsheets as presentation documents rather than structured datasets.

As publication complexity grows, maintaining hundreds of formatted cells, formulas, notes, and citations becomes increasingly difficult.

Common issues include:

- Numeric values stored as text
- Citation markers appended directly to numbers
- Manual cell formatting
- Inconsistent layouts between publications
- Business logic embedded inside spreadsheets
- Difficult maintenance across multiple commodities
- Poor interoperability with analytical software

This framework replaces document editing with metadata-driven publication generation.

---

# Solution

The publication framework externalizes nearly every aspect of report generation into configuration files.

Instead of modifying application code, publication behavior is defined through structured JSON metadata.

Examples include:

- Publication titles
- Table layouts
- Column definitions
- Section headers
- Field labels
- Calculation rules
- Formatting rules
- Citation placement
- Number formatting
- Commodity-specific mappings

The publication engine simply interprets the metadata and produces the desired output.

---

# Project Goals

- Automate publication generation
- Improve maintainability
- Separate business logic from presentation
- Preserve machine-readable datasets
- Improve accessibility
- Reduce manual formatting
- Standardize publication layouts
- Support multiple mineral commodities
- Simplify long-term maintenance

---

# Architecture

```
                   Source Data
                        │
                        ▼
              Data Validation Layer
                        │
                        ▼
               Commodity Metadata
                        │
      ┌─────────────────┼─────────────────┐
      │                 │                 │
      ▼                 ▼                 ▼
 Field Definitions  Calculations   Presentation Rules
      │                 │                 │
      └─────────────────┼─────────────────┘
                        ▼
           Publication Generation Engine
                        │
         ┌──────────────┴──────────────┐
         ▼                             ▼
 Human-facing Publication     Machine-readable Dataset
         │                             │
         ├── Accessible Excel          ├── Structured Data
         └── Accessible PDF            └── Data Exchange
```

---

# Repository Structure

```
nmic-publication-framework/
│
├── config/
│   ├── chromium/
│   ├── copper/
│   ├── lithium/
│   └── ...
│
├── definitions/
│
├── engine/
│
├── mappings/
│
├── templates/
│
├── validation/
│
├── sample_output/
│
└── README.md
```

---

# Metadata-Driven Design

The framework is built around reusable metadata.

Each publication is defined through configuration files rather than application code.

Metadata controls:

- Publication titles
- Multi-line headers
- Table organization
- Column widths
- Cell formatting
- Section labels
- Border styles
- Row banding
- Number formatting
- Citation placement
- Accessibility settings
- Commodity-specific mappings

Because the publication engine is generic, supporting a new commodity typically requires creating new metadata rather than modifying Python code.

---

# Configuration Example

A publication configuration describes the appearance and structure of a table.

Examples include:

- Table titles
- Header hierarchy
- Metadata labels
- Formatting rules
- Border definitions
- Numeric precision
- Citation columns
- Currency formatting
- Row grouping

This approach separates publication design from implementation, making the system significantly easier to maintain and extend.

---

# Publication Workflow

```
Commodity Data
       │
       ▼
Validation
       │
       ▼
Field Mapping
       │
       ▼
Calculation Engine
       │
       ▼
Publication Metadata
       │
       ▼
Publication Engine
       │
       ├────────► Human-facing Publication
       │              (Excel / PDF)
       │
       └────────► Machine-readable Dataset
```

---

# Key Features

- Metadata-driven publication generation
- Commodity-specific configuration
- Reusable publication engine
- Automated table formatting
- Citation management
- Structured field definitions
- Calculation abstraction
- Consistent publication styling
- Machine-readable outputs
- Accessible publication generation

---

# Technologies

- Python
- JSON
- Pandas
- OpenPyXL
- Metadata-driven software architecture
- Excel automation
- Government statistical reporting

---

# Accessibility

Accessibility was a primary design objective.

The framework improves publication accessibility by:

- Separating numeric values from annotations
- Preserving native numeric data types
- Supporting machine-readable output
- Eliminating embedded formatting artifacts
- Producing cleaner spreadsheet structures
- Simplifying future Section 508 compliance efforts

---

# Scalability

The publication engine was designed to support multiple mineral commodities without requiring application changes.

Adding support for a new publication generally involves:

1. Creating commodity metadata
2. Defining field mappings
3. Configuring calculations
4. Specifying publication layout

The rendering engine remains unchanged.

This design greatly reduces maintenance costs while promoting consistency across publications.

---

# Lessons Learned

This project demonstrated the value of separating:

- Data
- Metadata
- Calculations
- Presentation
- Accessibility

Rather than treating spreadsheets as documents, the framework treats publications as structured metadata that can be rendered into multiple output formats.

The result is a more maintainable, reusable, and scalable publication process that reduces manual effort while improving data quality and accessibility.

---

# Future Enhancements

Potential future improvements include:

- Automated PDF generation
- Additional commodity templates
- Metadata validation tools
- Schema validation
- Automated accessibility testing
- Versioned publication metadata
- REST API integration
- Web-based publication generation
- Additional output formats (HTML, CSV, JSON)

---

# Portfolio Highlights

This project demonstrates experience with:

- Metadata-driven application design
- Data architecture
- Government statistical reporting
- Publication automation
- Software modernization
- Data quality
- Configuration-driven development
- Separation of concerns
- Reusable software architecture
- Accessibility-focused design
- Excel automation
- Python development
