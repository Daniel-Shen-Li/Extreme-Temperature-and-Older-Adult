# Extreme Temperature and Older Adults

This repository contains the data, analytical code, and supplementary tables for the study of extreme temperature exposure and health outcomes among older adults.

## Files

- `Data S1.xlsx`: source data.
- `cold.xlsx`, `cold spell.xlsx`, `extreme cold.xlsx`, `extreme heat.xlsx`, `heat wave.xlsx`, and `hot.xlsx`: study-level datasets for each temperature exposure.
- `Table1_*.xlsx`: meta-analysis results for each exposure.
- `R.R`: R code for the three-level meta-analysis, heterogeneity assessment, Egger's regression, funnel plot, trim-and-fill analysis, and meta-regression.

## Reproducibility

The provided R code uses `cold spell.xlsx` and the `all-cause mortality` sheet as an example. To analyse other exposure–outcome combinations, change the input file name and sheet name accordingly.

Required R packages: `meta`, `metafor`, `readxl`, `dplyr`, and `metaviz`.
