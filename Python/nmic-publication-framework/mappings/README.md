# Mappings

## Overview

The `mappings` directory contains the transformation rules that connect source data to the publication framework.

Mappings translate incoming datasets into the standardized structures expected by the publication engine. By separating mapping logic from application code, the framework can accommodate changes in source systems without requiring changes to publication generation.

---

## Purpose

Mappings provide a consistent translation between source data and publication-ready structures.

Typical responsibilities include:

- Source field translation
- Canonical field mapping
- Column alignment
- Lookup relationships
- Data normalization support
- Commodity-specific field mappings

---

## Directory Structure

```text
mappings/
├── field_mappings.json
├── source_to_canonical.json
└── README.md
```

Additional mapping definitions can be added as new commodities or data sources are introduced.

---

## Design Principles

Mappings should remain:

- Independent of presentation
- Independent of business metadata
- Independent of workbook layouts
- Human-readable
- Machine-readable
- Version controlled

---

## Relationship to the Framework

```text
Source Data
      │
      ▼
Mappings
      │
      ▼
Standardized Data
      │
      ▼
Publication Engine
```

Mappings define **how source data becomes standardized data**.
