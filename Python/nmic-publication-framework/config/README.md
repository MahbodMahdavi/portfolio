# Configuration

## Overview

The `config` directory contains the metadata that defines each publication.

Rather than embedding publication layouts, formatting, calculations, and business rules directly into application code, the NMIC Publication Framework externalizes those behaviors into JSON configuration files. This design allows publication layouts to evolve independently of the publication engine.

Each commodity maintains its own configuration, making the framework reusable across multiple mineral commodity publications.

---

## Directory Structure

```text
config/
├── chromium/
├── copper/
├── lithium/
└── ...
```

Each commodity directory contains the metadata required to generate its publications.

Example:

```text
chromium/
├── table_1_human.json
├── table_1_machine.json
├── calculations.json
├── field_mappings.json
└── publication.json
```

---

## Configuration Philosophy

The publication engine is intentionally generic.

It does not contain commodity-specific logic or hard-coded spreadsheet layouts.

Instead, configuration files describe:

- Publication titles
- Table layouts
- Section organization
- Field labels
- Column definitions
- Formatting rules
- Calculation metadata
- Citation placement
- Output behavior

The publication engine interprets this metadata to generate consistent publication outputs.

---

## Human-Facing Configuration

Human-facing configuration files define how publication tables are presented to readers.

Examples include:

- Multi-line table headers
- Column widths
- Row heights
- Fonts
- Colors
- Borders
- Row banding
- Section headers
- Cell alignment
- Number formatting
- Citation columns

These files describe the visual structure of published tables without embedding presentation logic into the application.

---

## Machine-Facing Configuration

Machine-facing configuration files define structured outputs intended for data analysis and automated processing.

These configurations prioritize:

- Native numeric data types
- Consistent field names
- Standardized metadata
- Structured datasets
- Interoperability with analytical tools

Unlike the human-facing publication, machine-facing outputs avoid presentation-specific formatting.

---

## Benefits

Separating publication metadata from application code provides several advantages:

- Easier maintenance
- Consistent publication formatting
- Reusable publication templates
- Reduced manual editing
- Simplified onboarding for new commodities
- Improved accessibility
- Better separation of concerns
- Easier testing and validation

---

## Design Principle

The configuration files describe **what** should be published.

The publication engine determines **how** to generate the final output.

This separation allows publication layouts, formatting, and business rules to evolve without requiring changes to the underlying software.
