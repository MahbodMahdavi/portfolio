"""
automate_download_step.py
Automates downloading all required FRED series for USGS-style composite indices.

This script ensures all necessary series for:
- Metallic Composite Index
- Nonmetallic Composite Index
- Primary Metals Index
- Copper and Steel Indices (optional extension)

are retrieved and saved to a dated folder.

Dependencies:
- pandas
- pandas_datareader
"""

import os
import pandas as pd
from datetime import datetime
from pandas_datareader import data as pdr

# Unified list of all required FRED series
series_config = {
    # Common and primary metals
    "AWHAEMAN": {"name": "avg_weekly_hours", "start": "1939-01-01"},
    "PERMIT": {"name": "building_permits", "start": "1960-01-01"},
    "GS10": {"name": "treasury_10yr", "start": "1962-01-01"},
    "FEDFUNDS": {"name": "fed_funds_rate", "start": "1954-07-01"},
    "IPG327S": {"name": "nonmetallic_industrial_production", "start": "1972-01-01"},
    "WPUSI012011": {"name": "construction_ppi", "start": "1947-01-01"},
    "IPUEN327L200000000": {"name": "hours_nonmetallic", "start": "1987-01-01"},
    "IPUEN327T301000000": {"name": "real_output_nonmetallic", "start": "1987-01-01"},
    "IPG3311A2N": {"name": "steel_industrial_production", "start": "1972-01-01"},
    "IPUEN331L200000000": {"name": "hours_primary_metals", "start": "1987-01-01"},
    "WPU101703": {"name": "metal_price_index", "start": "1947-01-01"},
    "WPU102501": {"name": "copper_price_index", "start": "1947-01-01"},

    # Nonmetallic-specific
    "CEU3232700003": {"name": "avg_weekly_hours_nonmetallic", "start": "2000-01-01"},
    "PERMITUSA": {"name": "new_housing_permits", "start": "1960-01-01"},
    "S&PBP": {"name": "sp_building_products", "start": "2000-01-01"}  # Placeholder for custom/private data
}

end_date = datetime.today().strftime("%Y-%m-%d")
folder_name = datetime.today().strftime("%Y%m%d") + "_fred_files"
os.makedirs(folder_name, exist_ok=True)

# Download each series
for code, cfg in series_config.items():
    try:
        print(f"Downloading {code} ({cfg['name']}) from {cfg['start']} to {end_date}")
        df = pdr.DataReader(code, "fred", start=cfg["start"], end=end_date)
        df.to_csv(os.path.join(folder_name, f"{cfg['name']}.csv"))
    except Exception as e:
        print(f"Failed to download {code}: {e}")

print(f"\n All available data saved in: {folder_name}")
