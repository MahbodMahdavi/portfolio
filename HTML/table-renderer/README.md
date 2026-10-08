# Table Renderer

A single-file browser app that combines a per-table **config JSON** with a **CSV exported from the trade pipeline** and produces a styled publication table as an Excel `.xlsx` file.

It is the companion to [trade-pipeline](https://github.com/MahbodMahdavi/trade-pipeline).

## Quick start

1. Download `table_renderer.html` and open it in a web browser (double-click the file). It needs an internet connection to load its libraries.
2. Drop in your **Config JSON** (box 1).
3. Drop in your **Pipeline CSV** (box 2).
4. Click **Generate table** and check the preview.
5. Click **Download .xlsx**.

No install or build step is required. Your files are processed in the browser and are not uploaded anywhere.

## Pipeline CSV

Export the CSV from the trade pipeline. The renderer looks for these columns (case-insensitive, partial names work):

| Needed | Matches columns named like |
| --- | --- |
| Year | `Year` |
| Country | `Country Name`, `Country` |
| Commodity code | `HTS Code`, `HTS`, `Schedule B`, `Code` |
| Quantity | `Quantity (annual)`, `Metric Tons`, `Quantity` |
| Value | `Value (Year) ($000)`, `Value (Year)`, `Value` |

Subtotal rows and "Total for all countries" rows are ignored. The renderer builds its own subtotals. Years are read from the CSV.

## Config JSON

One config describes one sheet. The fields the renderer reads:

| Field | Purpose |
| --- | --- |
| `identity.table_number`, `identity.sheet_name` | Table number and Excel sheet name |
| `header_section.title`, `description`, `unit_declaration` | Heading text. `{table_number}` is replaced in the title |
| `categories` | List of `{ "label": "...", "codes": ["..."] }`; each becomes a block of rows |
| `year_axis.per_year_columns` | Sub-labels and unit labels for the quantity and value columns |
| `value_handling` | `quantity_scale` and `value_scale` multipliers applied for display |
| `placeholders` | Text for empty/zero cells (default `--`) and sub-half values (default `½`) |
| `category_rules.inclusion_threshold.value` | A country gets its own row if its quantity exceeds this in any year (default 100); the rest are combined into an "Other" row |
| `category_rules.other_row.label_template`, `total_row.label` | Labels for the "Other" and "Total" rows |
| `label_column.header`, `code_header` | Column headings for the first two columns |
| `code_display.format` | How commodity codes are displayed (default `####.##.####`) |

All fields are optional and have defaults, except `categories`.

## Notes

- The preview approximates the styling. The downloaded `.xlsx` is the authoritative result.
- Output uses Times New Roman 8 pt with hairline and thin rules for a print-style table.
