"""
generate_composite_index.py
Requires: pandas, numpy, pandas_datareader
"""

import os
import json
import pandas as pd
import numpy as np
from pandas_datareader import data as pdr
from datetime import datetime

# Load configuration
with open("primary_metals_config.json") as f:
    config = json.load(f)

def moving_average(series, weights):
    k = len(weights)
    ma = np.full_like(series, np.nan)
    norm = sum(weights)
    for i in range(k//2, len(series)-k//2):
        window = series[i-k//2:i+k//2+1]
        if not np.any(np.isnan(window)):
            ma[i] = np.dot(window, weights) / norm
    return ma

def symmetric_pct_diff(series, span, eos='E'):
    result = np.full_like(series, np.nan)
    for i in range(len(series) - span):
        base = series[i]
        term = series[i + span]
        if base + term == 0 or np.isnan(base) or np.isnan(term):
            continue
        pct = 200 * (term - base) / (term + base)
        idx = i + span if eos == 'E' else i + (span // 2)
        result[idx] = pct
    return result

def apply_standardization(series, method, scale_factor=None):
    if method == 1:
        sf = np.nanmean(np.abs(series))
    elif method == 2:
        sf = np.nanstd(series)
    elif method == 3:
        sf = scale_factor
    elif method == 4:
        sf = np.nanstd(series)  # Placeholder
    else:
        sf = 1
    return series / sf if sf else series, sf

def apply_trend(series, trend):
    return series + trend if trend else series

def cumulative_index(series, base_index):
    cum = np.zeros_like(series)
    cum[base_index] = 100.0
    for i in range(base_index + 1, len(series)):
        if 200 - series[i] == 0 or np.isnan(series[i]):
            continue
        cum[i] = cum[i - 1] * (200 + series[i]) / (200 - series[i])
    base_avg = np.nanmean(cum[base_index:base_index + 12])
    return cum / (base_avg / 100.0) if base_avg else cum

# Download and align all series
series_data = {}
start = "1939-01-01"
end = datetime.today().strftime("%Y-%m-%d")
dates = None

for s in config["series"]:
    code = s["code"]
    if code == "GS10_minus_FEDFUNDS":
        s1 = pdr.DataReader("GS10", "fred", start, end)
        s2 = pdr.DataReader("FEDFUNDS", "fred", start, end)
        df = s1.subtract(s2, fill_value=0).rename(columns={"GS10": code})
    else:
        df = pdr.DataReader(code, "fred", start, end).rename(columns={code: code})
    series_data[code] = df
    if dates is None:
        dates = df.index

# Build master DataFrame
df_all = pd.DataFrame(index=dates)
for code, df in series_data.items():
    df_all[code] = df[code]

# Process each series
contributions = []
total = np.zeros(len(df_all))
weight_sum = np.zeros(len(df_all))

for s in config["series"]:
    code = s["code"]
    weight = s["weight"]
    series = df_all[code].to_numpy(dtype=np.float64)
    if s["invert"]:
        series *= -1
    ma = moving_average(series, s["ma_weights"])
    diff = symmetric_pct_diff(ma, span=s["diff_span"], eos=s["eos"]) if s["change_method"] == 0 else np.diff(ma, prepend=np.nan)
    std, sf = apply_standardization(diff, method=s["std_method"], scale_factor=s["std_factor"])
    trended = apply_trend(std, config["trend"])
    weighted = trended * weight
    total += np.nan_to_num(weighted)
    weight_sum += (~np.isnan(weighted)) * weight
    contributions.append(weighted)

# Normalize aggregate
composite_rate = np.divide(total, weight_sum, out=np.zeros_like(total), where=weight_sum != 0)
index = cumulative_index(composite_rate, base_index=0)

# Save outputs
df_all["Composite Index"] = index
df_all["Composite Rate"] = composite_rate
for i, s in enumerate(config["series"]):
    df_all[f"{s['code']}_contrib"] = contributions[i]

df_all.to_csv(config["output"]["index_output"])
print(f"Composite index saved to: {config['output']['index_output']}")


'''
Place primary_metals_config.json in the same directory.
Ensure pandas_datareader is installed.
Outputs composite_index.csv and per-component contributions.
'''