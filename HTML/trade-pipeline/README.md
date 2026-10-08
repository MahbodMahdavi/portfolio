# Trade Pipeline

A single-file browser app that pulls U.S. international trade data from the [Census Bureau API](https://www.census.gov/data/developers/data-sets/international-trade.html), processes it, and exports a clean CSV.

The app has three layers:

1. **Data Acquisition**: query the Census API by commodity code, country, district and date range.
2. **Data Processing**: group commodity codes into categories and add subtotal rows.
3. **Data Presentation**: choose and label the output columns with a template, then download a CSV.

## Quick start

1. Download `trade_pipeline.html`.
2. Open it in a web browser (double-click the file). It needs an internet connection to load its libraries and reach the Census API.
3. Paste your Census API key into the **API Key** field. You can get a free key at <https://api.census.gov/data/key_signup.html>.
4. Pick Export or Import, a date range and your commodity codes, then click **Fetch**.
5. Review the preview table and click **Download CSV**.

No install or build step is required.

## Features

- **Exports or imports**, with monthly or annual granularity.
- **Commodity codes** are comma-separated. A trailing `*` is a wildcard (prefix match).
- **Country and district filters** (blank means all).
- **Saved categories**: named groups of codes, organized into groups. Turn on **Aggregate** to add a subtotal row per category. Categories can be exported to and loaded from a JSON file.
- **Presentation templates**: choose which columns appear and how they are labeled. Templates can be exported and imported as JSON.
- **Unit conversion**: quantities reported as `KG`, `CKG` (content kilograms) or `CTN` (content metric tons) can be shown in kilograms, metric tons, short tons or pounds, including thousands. Rows reported in any other unit are left unconverted.
- **Value magnitude**: show values as Actual, Thousands or Millions.
- **Descriptor columns**: `Unit 1` / `Unit 2` and `Value Desc 1` / `Value Desc 2` write the selected unit and magnitude into the output, so the CSV is easy to filter by machine.

## Your settings are saved in the browser

The form, categories, groups and templates are stored in your browser's local storage and restored on reload. They stay on your computer. Use the category and template export buttons to back them up or move them to another browser.

## Related

[table-renderer](https://github.com/MahbodMahdavi/table-renderer) turns this app's CSV output into a styled publication table in Excel.

## Data source

Data comes from the U.S. Census Bureau International Trade API. This project is not affiliated with or endorsed by the Census Bureau.
