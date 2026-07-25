# Economic Index Modernization

A modernization of a legacy Fortran application used to construct composite economic indices.

This project replaces a procedural Fortran implementation with a modular Python architecture while preserving the underlying analytical methodology.

---

## Background

The original application was developed over several decades and implemented the statistical methodology used to generate composite economic indices.

Rather than performing a direct translation, this project redesigns the application using modern Python libraries, modular functions, and configuration-driven processing.

---

## Modernization Goals

- Preserve analytical methodology
- Improve maintainability
- Eliminate interactive execution
- Introduce configuration-driven processing
- Simplify future enhancements

---

## Processing Pipeline

The modernization performs:

- Moving average calculations
- Symmetric percentage differences
- Statistical standardization
- Trend adjustment
- Weighted aggregation
- Composite index construction
- Component contribution calculations

---

## Improvements

| Legacy System | Modernized System |
|---------------|-------------------|
| Fortran | Python |
| Interactive input | JSON configuration |
| COMMON blocks | Modular functions |
| Fixed arrays | Pandas & NumPy |
| Procedural design | Maintainable architecture |

---

## Technologies

- Python
- Pandas
- NumPy
- JSON

---

## Skills Demonstrated

- Legacy system modernization
- Software refactoring
- Time-series analysis
- Statistical programming
- Configuration-driven architecture
- Modular software development

---

## Repository Structure

```text
02-economic-index-modernization/
│
├── build_composite_index.py
├── legacy/
│   └── legacy_composite_index.f
├── config/
├── sample_output/
└── docs/
```

---

## Related Projects

This project is part of the Economic Index System.

- 01 FRED Economic Data Pipeline
- 03 Economic Report Generator
