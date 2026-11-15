# Environmental Kuznets Curve (EKC) Analysis: Chad (1970–2024)

**Student:** Şükrettin Efe Aydın  
**Student ID:** 137423018  
**Country:** Republic of Chad (`TCD`)  
**Period:** 1970–2024 ($N = 55$)

## Overview
This repository contains the raw datasets, cleaned dataset, and R replication script used to test the Environmental Kuznets Curve (EKC) hypothesis for the Republic of Chad over the period 1970–2024.

## Data Sources
All data are retrieved from the World Bank World Development Indicators (WDI) database:
- **CO2 emissions excluding LULUCF per capita (t CO2e/capita):** `EN.GHG.CO2.PC.CE.AR5` (`API_EN.GHG.CO2.PC.CE.AR5_DS2_en_csv_v2_62354.csv`)
- **GDP per capita (constant 2015 US$):** `NY.GDP.PCAP.KD` (`API_NY.GDP.PCAP.KD_DS2_en_csv_v2_71952.csv`)

## Methodology & Workflow Steps
1. **Data Filtering & Cleaning:** Extract observations for Chad (`Country Code == "TCD"`) covering 1970–2024 from the raw World Bank CSV files and merge them into `chad_data.csv` (55 complete annual observations, no missing values).
2. **Logarithmic Transformation:** Take natural logarithms of both variables (`ln_co2` and `ln_gdp`) and generate the quadratic term (`ln_gdp_sq = ln_gdp^2`).
3. **Visualization:** Plot scatter diagrams of `ln_co2` against `ln_gdp` with both a linear OLS trend line and a quadratic OLS fitted curve.
4. **Econometric Estimation:** Estimate the nonlinear quadratic OLS model:
   $$\ln(CO_{2t}) = eta_0 + eta_1 \ln(GDP_t) + eta_2 [\ln(GDP_t)]^2 + \epsilon_t$$
5. **Hypothesis Evaluation:** Test whether $eta_1 > 0$ and $eta_2 < 0$ with statistical significance (inverted-U shape).

## Summary of OLS Regression Results

| Variable | Coefficient | Std. Error | t-value | p-value |
| :--- | :---: | :---: | :---: | :---: |
| Intercept | 70.3679 | 63.5327 | 1.108 | 0.273 |
| `ln_gdp` | -24.2926 | 19.3602 | -1.255 | 0.215 |
| `ln_gdp_sq` | 1.9949 | 1.4734 | 1.354 | 0.182 |

- **Observations ($N$):** 55
- **Multiple R-squared:** 0.5156 (Adjusted R-squared: 0.4969)
- **F-statistic:** 27.67 on 2 and 52 DF ($p = 6.550 	imes 10^{-9}$)
- **Residual Standard Error:** 0.4469

**Finding:** Because the linear term is negative (-24.2926), the squared term is positive (1.9949), and neither coefficient is statistically significant at the 5% level, the EKC hypothesis **does not hold** for Chad during 1970–2024.

## Repository Contents
- `API_EN.GHG.CO2.PC.CE.AR5_DS2_en_csv_v2_62354.csv` — Raw World Bank CO2 emissions per capita dataset.
- `API_NY.GDP.PCAP.KD_DS2_en_csv_v2_71952.csv` — Raw World Bank GDP per capita dataset.
- `chad_data.csv` — Cleaned annual dataset for Chad (1970–2024) including natural logarithms.
- `chad_ekc.R` — Complete R replication script from raw data extraction to OLS estimation.
