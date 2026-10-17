# A/B Test: New Recommendation Algorithm

## Project Overview

A full A/B testing cycle for an entertainment app with an infinite short-video feed: from test design and sample size calculation to monitoring and the final decision.

The recommendation team built a new algorithm that should show users more interesting content. My task was to plan the experiment, check that it runs correctly, and decide whether the new algorithm should be rolled out.

📓 **Notebook:** [`ab_test_recommendations.ipynb`](ab_test_recommendations.ipynb) (in Russian)

---

## Business Context

The app makes money in two ways: a paid ad-free subscription and ads for users without a subscription. More engaged users are more likely to register and subscribe, so engagement is the key product lever.

**Target metric:** the share of *successful first sessions*, meaning first sessions in which a user viewed **4 or more pages**.

---

## Data

- Historical sessions (Aug–Sep 2025): ~436k sessions.
- First day of the test: used to monitor the group split.
- Full test period (Oct 14 – Nov 2, 2025).

> The original datasets are not included because they were provided by the educational platform.

---

## What I Did

### 1. Exploratory analysis of historical data

- Checked data quality: types, missing values, duplicates, anomalies.
- Analysed daily active and registered users.
- Studied pages viewed in first sessions: most users view **2–4 pages**, with a peak at 3.
- The share of successful first sessions was stable at **~31%** (29.7–33.2%) with no trend, which makes it a good target metric.

### 2. Test design

- Significance level α = 0.05, power 0.8, baseline ≈ 30%, **MDE = 3% relative** (30% → 30.9%).
- Required sample size: **41,040 users per group** (`statsmodels`, `NormalIndPower`).
- Minimum duration at current traffic: **9 days**. I recommended running it for at least 1–2 full weeks to cover weekday and weekend behaviour.

### 3. Monitoring the running test

- Group sizes: A = 1,477, B = 1,466 users, a **0.74%** difference.
- **No users** appear in both groups.
- Device and region distributions are almost identical across groups.
- Conclusion: the split is correct and the results can be trusted.

### 4. Results

**Hypotheses:**
- H₀: the share of successful first sessions is the same in A and B.
- H₁: the share is higher in B (one-sided test).

| Group | First sessions | Successful first sessions |
|-------|---------------:|--------------------------:|
| A (control) | 15,162 | 31.57% |
| B (test) | 15,416 | 31.47% |

- Difference: **−0.11 p.p.**
- Z-test for proportions: **p-value = 0.578**, so there is no statistically significant difference.

---

## Decision

**Do not roll out the new algorithm.** It did not increase the target metric; the observed difference is even slightly negative.

**Limitation:** the test collected about 15.2–15.4k new users per group instead of the planned 41k. The duration was calculated from total daily traffic (~9.9k users), while the metric is based only on first sessions of new users. As a result, the power to detect a +3% effect was about 50% instead of 80%. Since the observed effect is negative, this does not change the decision, but in future tests the duration should be calculated from the number of new users per day.

**Next steps:**
- check the effect in separate segments (devices, regions);
- improve the algorithm and re-test with a properly sized sample;
- track proxy metrics (pages per session, session length, D1 retention) and guardrail metrics (ad revenue, subscription conversion, load time, crash rate).

---

## Tools

- Python
- pandas
- statsmodels (`NormalIndPower`, `proportion_effectsize`, `proportions_ztest`)
- Matplotlib
- Jupyter Notebook
