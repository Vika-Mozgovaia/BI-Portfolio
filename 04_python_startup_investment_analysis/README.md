# Startup Investment Analysis

## Project Overview

An exploratory analysis of the global venture capital market based on historical startup funding data (Crunchbase).

The goal was to help an investor choose an investment strategy for 2015: which industries, funding types and project horizons look most promising, and where the risks are.

📓 **Notebook:** [`startup_investment_analysis.ipynb`](startup_investment_analysis.ipynb) (in Russian)

---

## Business Task

Identify promising directions for venture investment and explain how company characteristics relate to funding:

- industry and market segment;
- funding stage and type (venture, seed, angel, debt financing, private equity);
- funding duration and number of rounds;
- deal size and its change over time;
- share of invested money returned to investors.

---

## Data

- `cb_investments` — startups: market, status, country, founding date, total funding, funding by round type.
- `cb_returns` — yearly returns by funding type.

> The original datasets are not included because they were provided by the educational platform.

---

## What I Did

**Data preparation**
- cleaned column names, fixed data types, removed empty rows and duplicates;
- processed text categories and filled missing values.

**Feature engineering**
- grouped companies by funding duration;
- classified market segments by the number of companies: `mass` (over 120 companies), `mid` (35–120) and `niche` (under 35).

**Outliers**
- detected abnormally large deals with the IQR method for each segment;
- limited the analysis to a reliable time period.

**Analysis**
- compared funding types by total volume and number of deals;
- analysed yearly dynamics of deal count and median round size;
- found mass segments whose funding grew in 2014;
- calculated the yearly share of returned funds by funding type and visualised it with a heatmap.

---

## Key Findings

### The market became mass-market

- From 2005 to 2013 the number of funding rounds grew from **948 to 12,880**.
- The median round size fell about **8×**, from **$4.5M to $0.56M**. Venture funding became available to many more startups, with smaller typical checks.
- In 2014 there were 7,124 rounds. The data for the year was checked and is complete, so the drop looks like a market correction while the median check stayed stable (~$0.56M).

### Capital is highly concentrated

- **59%** of companies received funding only once.
- Projects funded for more than a year attract **62%** of all investment.
- Most segments are `niche` (289 segments), but the few `mass` segments concentrate most of the capital and investor activity.

### Growing industries

- **Technology** and **Internet** show the most stable funding growth since 2008–2009.
- **Medical** has grown noticeably since 2011.
- **Real estate** grew sharply in 2013–2014.

### Funding types: volume vs. return

- **Venture** is the main instrument by investment volume and number of deals, but its share of returned funds is relatively low (about **0.17–0.78**).
- **Seed** is the most volatile and stays well below break-even, which reflects early-stage risk.
- **Debt financing** and **private equity** have the highest return share, reaching about **1.24** and **1.11** in 2014.

---

## Recommendations for 2015

1. **Industries:** focus on Technology, Internet and Medical, the mass segments with stable funding growth.
2. **Funding type:** use venture funding as a growth bet on long-term projects, and add debt financing or private equity for mature companies, where returns are higher and more stable.
3. **Seed / angel:** keep a limited share for early ideas, given the higher risk.
4. **Evaluation:** use median values to estimate a typical check, so that rare mega-deals don't distort the picture.

---

## Tools

- Python
- pandas
- Matplotlib, Seaborn
- Jupyter Notebook
