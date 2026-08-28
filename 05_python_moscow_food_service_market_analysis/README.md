# Moscow Food Service Market Analysis

## Project Overview

This project explores the Moscow food service market to identify promising opportunities for launching a new food service business.

The analysis was conducted for a company entering the food service industry for the first time. The objective was to examine the market structure, evaluate competition, analyze pricing segments, and identify the most attractive business formats and locations based on real market data.

The study combines two datasets: one describing food establishments and another containing pricing information.

---

## Business Task

Conduct an exploratory data analysis of the Moscow food service market to support management in selecting the optimal concept for a new establishment.

The analysis answers the following business questions:

- Which food service formats dominate the market?
- Which administrative districts have the highest concentration of establishments?
- How are prices distributed across the city?
- How does seating capacity vary by establishment type?
- Does chain affiliation influence market structure?
- What recommendations can be made for opening a new business?

---

## Dataset

The analysis is based on two datasets.

### Dataset 1 — Food Establishments (`rest_info`)

Contains information about each establishment, including:

- unique establishment identifier (`id`);
- establishment name;
- address;
- administrative district;
- establishment category (café, restaurant, coffee shop, etc.);
- opening hours;
- Yandex Maps rating;
- chain affiliation;
- seating capacity.

### Dataset 2 — Pricing Information (`rest_price`)

Contains pricing characteristics, including:

- unique establishment identifier (`id`);
- price category;
- average bill (text representation);
- numerical estimate of the average bill;
- numerical estimate of the average price of a cappuccino.

The datasets were merged using a unique establishment identifier (`id`).

> **Note:** The original datasets are not included in this repository because they were provided by the educational platform and cannot be publicly distributed.

---

## Data Preparation

The following preprocessing steps were performed:

- inspected the dataset structure;
- verified data types;
- converted data types where necessary;
- checked for missing values;
- searched for duplicate records;
- merged the datasets;
- analyzed missing values separately for each feature.

Special attention was given to the **seating capacity** variable.

More than **43%** of observations contained missing values. Filling them with median values was tested but ultimately rejected because it artificially smoothed the distribution and distorted the market structure.

To preserve data quality, missing values were left unchanged, and analyses involving seating capacity were performed using only available observations.

---

## Exploratory Data Analysis

The following analyses were performed:

- distribution of establishments by category;
- distribution across Moscow administrative districts;
- chain vs. non-chain establishments;
- seating capacity analysis;
- rating distribution;
- relationship between ratings and other establishment characteristics;
- Top-15 restaurant chains;
- average bill by district;
- correlation analysis between key variables.

The project includes the following visualizations:

- bar charts;
- histograms;
- boxplots;
- pie charts;
- correlation heatmaps.

---

## Key Findings

The analysis revealed several important market characteristics:

- Cafés and restaurants are the dominant establishment types.
- Approximately **62%** of all establishments are independent (non-chain) businesses.
- The average customer bill in Moscow is approximately **750–800 RUB**.
- The Central Administrative District has the highest concentration of food establishments.
- Competition is significantly higher in the city center than in other districts.

---

## Business Recommendations

For a company entering the market for the first time, the analysis suggests:

- opening a café in the mid-price segment;
- considering districts outside the Central Administrative District to reduce competitive pressure;
- conducting a detailed competitor analysis before selecting a location;
- analyzing the target audience before making the final location decision.

If the objective is to build a premium brand with higher margins, opening a restaurant in the city center may be justified despite the higher competition and investment costs.

---

## Potential Risks

- High market competition.
- Longer investment payback period.
- High marketing and promotion costs.
- Incorrect location selection.

---

## Technologies

- Python
- Pandas
- Matplotlib
- Seaborn
- Phik
- Jupyter Notebook
