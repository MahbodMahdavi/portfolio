# Architecture

## Overview

The `architecture` directory documents the design decisions behind the NMIC Publication Framework.

These documents describe how the framework separates business metadata, publication configuration, mappings, validation, and publication generation into independent components.

---

## Purpose

Architecture documentation explains:

- System organization
- Component responsibilities
- Data flow
- Design principles
- Long-term maintainability

---

## Typical Documents

```text
architecture/
├── publication_pipeline.md
├── metadata_architecture.md
├── configuration_model.md
└── README.md
```

---

## Core Architecture

```text
Metadata
      │
      ▼
Mappings
      │
      ▼
Validation
      │
      ▼
Configuration
      │
      ▼
Publication Engine
      │
      ▼
Published Outputs
```

---

## Design Goals

The framework emphasizes:

- Metadata-driven design
- Configuration over code
- Separation of concerns
- Reusability
- Accessibility
- Maintainability
