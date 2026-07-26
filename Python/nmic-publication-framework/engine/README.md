# Engine

## Overview

The `engine` directory contains the core publication generation logic for the NMIC Publication Framework.

The engine transforms validated, standardized data into accessible publication outputs by combining publication configuration, business metadata, and mapped data. It is intentionally metadata-driven, allowing new commodities and publication layouts to be supported through configuration rather than application code.

The engine does not contain commodity-specific business rules. Instead, it interprets metadata and configuration files to produce consistent, reproducible publications.

---

## Responsibilities

The publication engine is responsible for:

- Loading publication configuration
- Reading business metadata
- Loading standardized data
- Applying publication rules
- Constructing workbook layouts
- Applying formatting and accessibility rules
- Generating publication-ready Excel workbooks
- Producing machine-readable outputs

---

## Inputs

The engine consumes several independent inputs.

### Publication Configuration

Defines how a publication should be generated.

Examples include:

- table layout
- row structure
- column definitions
- formatting
- styles
- placeholders
- publication options

Located in:

```text
config/
```

---

### Business Metadata

Provides reusable reference information.

Examples include:

- material code definitions
- end-use classifications
- controlled vocabularies
- lookup tables

Located in:

```text
metadata/
```

---

### Standardized Data

The engine expects incoming data to have already been normalized into a consistent structure.

Data preparation, mapping, and validation occur before publication generation.

---

## Publication Workflow

```text
Publication Configuration
            │
            ▼
      Business Metadata
            │
            ▼
    Standardized Source Data
            │
            ▼
      Publication Engine
            │
            ▼
Workbook Construction
            │
            ▼
Formatting & Validation
            │
            ▼
Published Outputs
```

---

## Design Principles

### Metadata-driven

Publication behavior is defined through metadata and configuration rather than hard-coded business logic.

---

### Commodity-independent

The engine is designed to generate publications for multiple commodities without requiring changes to the underlying application.

Supporting a new commodity should primarily involve adding new configuration and metadata.

---

### Separation of Concerns

The engine focuses only on publication generation.

Other responsibilities belong elsewhere in the framework.

| Component | Responsibility |
|-----------|----------------|
| Metadata | Business definitions |
| Configuration | Publication layout and formatting |
| Mappings | Data transformation |
| Validation | Data quality |
| Engine | Publication generation |

---

## Outputs

The engine produces publication artifacts such as:

- Accessible Excel workbooks
- Machine-readable datasets
- Publication tables
- Supporting metadata (when applicable)

Generated outputs should be deterministic, meaning identical inputs produce identical publications.

---

## Benefits

Separating the publication engine from business rules provides several advantages:

- Reusable across commodities
- Consistent publication generation
- Reduced code duplication
- Simplified maintenance
- Easier testing
- Improved scalability
- Better long-term maintainability

---

## Future Enhancements

The engine architecture supports future capabilities such as:

- Multiple publication templates
- Additional output formats
- Automated publication pipelines
- Expanded validation
- Versioned publication schemas
- Enhanced accessibility features

These enhancements can be introduced without fundamentally changing the engine architecture due to the framework's metadata-driven design.
