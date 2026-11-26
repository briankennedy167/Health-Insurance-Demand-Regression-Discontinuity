# Health Insurance Demand: Regression Discontinuity Analysis

## Project Overview

This project examines the relationship between income, health insurance premiums, insurance enrollment, and insurer costs using regression discontinuity (RD) analysis.

The analysis was completed as part of my graduate studies in Applied Economics at Lehigh University in Fall 2025.

## Research Objectives

- Examine average health insurance premiums across income groups.
- Estimate discontinuities in health insurance enrollment at income thresholds.
- Evaluate changes in insurer costs at those same thresholds.

## Econometric Methodology

The analysis uses a piecewise linear regression discontinuity specification at three Federal Poverty Level (FPL) thresholds:

- 150% FPL
- 200% FPL
- 250% FPL

The regression models incorporate income, threshold indicator variables, and interaction terms to allow for changes in both intercepts and slopes across income thresholds.

Discontinuity estimates are calculated for two dependent variables:

- Total monthly insurance enrollment
- Insurer costs

## Data

The analysis uses the `fhs.csv` dataset and restricts the sample to income levels at or above 135% of the Federal Poverty Level.

## Tools and Technologies

- R
- readr
- dplyr
- ggplot2
- broom

## Skills Demonstrated

- Applied econometrics
- Regression discontinuity design
- Ordinary least squares (OLS)
- Data cleaning and manipulation
- Statistical modeling
- Health economics
- Public policy analysis

## Project Files

| File | Description |
|---|---|
| Problem Set Two.R | Original R analysis and regression models |
| fhs.csv | Dataset used in the analysis |
| README.md | Project documentation |

## Author

Brian Kennedy  
M.S. in Applied Economics  
Lehigh University