# Metadata

## Overview

The `metadata` directory contains reference data used by the NMIC Publication Framework.

Unlike publication configuration files, which describe how reports are generated and formatted, metadata files describe the business domain. They provide standardized classifications, controlled vocabularies, lookup tables, and other reference information that can be shared across multiple publications and processing workflows.

These files contain no presentation logic and are independent of any specific publication layout.

---

## Purpose

The metadata layer serves as a centralized source of business definitions used throughout the publication framework.

Typical uses include:

- Standardizing terminology
- Defining controlled vocabularies
- Supporting data validation
- Mapping source data to standardized classifications
- Improving consistency across commodity publications
- Reducing duplication of business rules

---

## Directory Structure

```text
metadata/
├── end_use_taxonomy.json
├── material_code_mappings.json
└── README.md
```

Additional reference datasets can be added as the framework evolves.

---

## Metadata Files

### `end_use_taxonomy.json`

Defines the standardized hierarchy of end-use categories used throughout the publication framework.

Examples include:

- Carbon Steel
- High-Strength Low-Alloy Steel
- Stainless and Heat-Resisting Steel
- Tool Steel
- Cast Irons
- Superalloys
- Chemical and Ceramic Uses

Each category contains the associated material families used for classification and reporting.

---

### `material_code_mappings.json`

Maps commodity-specific material codes to standardized material families and end-use classifications.

Each material definition typically includes:

- Material code
- Material description
- Material family
- Associated end-use categories

This metadata provides a consistent interpretation of material codes across commodities and publication workflows.

---

## Relationship to the Framework

The metadata layer supports multiple components within the publication framework.

```text
Reference Metadata
        │
        ▼
Field Mapping
        │
        ▼
Validation
        │
        ▼
Publication Configuration
        │
        ▼
Publication Engine
        │
        ▼
Published Outputs
```

The publication engine consumes metadata but does not define it.

---

## Design Principles

Metadata files should remain:

- Independent of presentation
- Independent of spreadsheet layouts
- Independent of application code
- Reusable across commodities
- Human-readable
- Machine-readable
- Version controlled

Business definitions belong in metadata rather than application logic whenever practical.

---

## Benefits

Maintaining business metadata separately from application code provides several advantages:

- Consistent terminology across publications
- Centralized business definitions
- Simplified maintenance
- Reduced duplication
- Improved validation
- Easier onboarding for new commodities
- Reusable reference datasets
- Better separation of concerns

---

## Future Metadata

As the framework expands, additional reference datasets may be introduced, including:

- Commodity definitions
- Unit definitions
- Geographic reference data
- Classification hierarchies
- Lookup tables
- Validation rules
- Code dictionaries

The publication engine can consume these metadata files without requiring changes to the underlying application architecture.
