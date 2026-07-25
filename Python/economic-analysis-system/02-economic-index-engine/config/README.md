# Configuration Files

## Overview

This directory contains the configuration files used by the Economic Index Engine.

Each configuration file defines the methodology for generating a specific composite economic index. Rather than hard-coding calculations, the processing engine reads these JSON files to determine which economic series to use, how each series should be transformed, and how the final index should be constructed.

This design allows multiple indices to be generated using the same processing engine.

---

## Configuration Files

| File | Description |
|------|-------------|
| `config_copper.json` | Configuration for the Copper Index. |
| `config_steel.json` | Configuration for the Steel Index. |
| `config_primary_metals.json` | Configuration for the Primary Metals Index. |
| `config_non-metallic.json` | Configuration for the Non-Metallic Mineral Products Index. |

---

## Configuration Structure

Each configuration file typically defines:

- Index metadata
- Base year for normalization
- Component economic series
- Component weights
- Moving average parameters
- Change calculation method
- Standardization method
- Trend adjustment settings
- Output file names

---

## Advantages

Using configuration files instead of hard-coded logic provides several benefits:

- Supports multiple economic indices with one processing engine
- Simplifies maintenance
- Makes methodology transparent
- Allows new indices to be added without modifying application code
- Separates business rules from implementation

---

## Related Components

The configuration files are used directly by the processing engine located in:

```
engine/
```

They also reference economic series documented in:

```
mappings/
```

and produce outputs that are used by the publication pipeline.
