# Inflation vs Fuel Price Vulnerability Analysis

## Project Goal

Build a small end-to-end data project that explores whether increases in fuel prices may be associated with stronger food inflation pressure across countries.

The project starts with two real-world datasets:

1. **Inflation / price index data** across countries and time, covering roughly **2007–2026**.
2. **Fuel price data** across countries and time, covering roughly **2015–2024**.

The fuel dataset is currently messier and not yet directly aligned with the inflation dataset.

The overall aim is to:

* normalize both datasets into a shared analytical structure,
* align them on comparable country and time dimensions,
* create SQL tables and views for reusable analysis,
* use Python and Jupyter for deeper statistical inspection and visual output,
* derive a coefficient or vulnerability score that estimates how strongly a country’s food inflation may have been affected by fuel price increases.

---

## Core Research Question

**Are some countries more vulnerable than others to food inflation when fuel prices rise?**

This is not quite the same as asking whether fuel prices and food inflation merely move together.

Instead, the deeper question is:

> When fuel prices increase in a country or region, does food inflation tend to increase more strongly there than elsewhere, and can that relationship be summarized as a comparable cross-country coefficient?

This matters because fuel prices can affect:

* transportation costs,
* agricultural production costs,
* fertilizer and energy-intensive inputs,
* import/export logistics,
* retail distribution costs.

So the project is trying to move from **raw time series** to a more meaningful idea of **economic vulnerability**.

---

## Important Constraint: Shared Time Window

Although the inflation dataset spans **2007–2026**, the fuel dataset spans only **2015–2024**.

That means the most meaningful directly comparable analysis will likely use the **overlapping period only**:

* **Start:** 2015
* **End:** 2024

Any combined fuel-vs-inflation analysis outside that window would either:

* require extrapolation,
* introduce null-heavy joins,
* or weaken interpretability.

So the project should treat **2015–2024** as the main joint analysis window.

---

## Data Normalization Goals

Before meaningful analysis can begin, both datasets need to be normalized so they can be compared fairly.

### 1. Country Standardization

Both datasets must use a common country identifier.

Preferred standard:

* **ISO 3166-1 alpha-3 country code** (for example: `GBR`, `FRA`, `KEN`)

Why this matters:

* country names vary between datasets,
* some sources use full names, others abbreviations,
* some may use regional naming differences,
* analysis becomes fragile without a shared key.

A country dimension table should hold:

* canonical country name,
* ISO2,
* ISO3,
* optional World Bank / IMF code if available,
* region / income group if added later.

---

### 2. Time Standardization

Both datasets must share a common time grain.

Possible grains:

* **yearly**
* **quarterly**
* **monthly**

The choice depends entirely on the most detailed reliable overlap between both datasets.

Recommended rule:

* if both datasets can support **monthly** comparison reliably, use monthly;
* otherwise aggregate both to **yearly**;
* avoid mixing monthly fuel data with annual inflation values unless explicitly aggregated.

For a first clean project, **yearly country-level analysis** is probably the most robust starting point.

That means each country/year would have:

* average fuel price,
* average annual food inflation or end-of-year food CPI change,
* optional lagged values.

---

### 3. Measure Standardization

The two datasets likely do not express values in directly comparable ways.

Examples:

* inflation may be a percentage change,
* fuel price may be a nominal local-currency price,
* one dataset may use indexes while the other uses raw prices,
* one may contain national averages while the other contains city-level values.

So each variable needs a clearly documented meaning.

For example:

* `food_inflation_pct` = annual percentage change in food consumer price index
* `fuel_price_avg_local` = annual average retail fuel price in local currency
* `fuel_price_avg_usd` = annual average retail fuel price converted to USD if available
* `fuel_price_yoy_pct` = year-over-year percentage change in fuel price

The most useful comparison may not be raw fuel prices, but rather:

* **fuel price change over time**, and
* **food inflation rate over time**.

This avoids comparing unlike units too directly.

---

### 4. Missing / Dirty Data Handling

The fuel dataset is described as messy, so the project should explicitly account for:

* inconsistent country names,
* missing dates,
* duplicate records,
* multiple fuel types,
* mixed currencies,
* missing units,
* partial-year observations.

Cleaning rules should be documented, for example:

* drop rows with no country or no date,
* map country names to canonical ISO3 values,
* standardize fuel type labels,
* aggregate duplicates using average or median,
* flag partial-year data,
* keep a data-quality status field when needed.

---

## Proposed Analytical Structure

A simple and strong structure is to separate the work into layers.

### Layer 1: Raw Tables

Keep the original imported data mostly untouched.

Examples:

* `raw_inflation_prices`
* `raw_fuel_prices`

These preserve source truth for debugging.

---

### Layer 2: Cleaned / Standardized Tables

Transform raw inputs into normalized forms.

Examples:

* `clean_inflation_country_period`
* `clean_fuel_country_period`

These should contain:

* normalized country code,
* normalized date or year,
* standardized measurement fields,
* source metadata,
* quality flags.

---

### Layer 3: Analytical Views

Create SQL views for reusable analysis.

Examples:

* `vw_country_year_inflation`
* `vw_country_year_fuel`
* `vw_country_year_joined`
* `vw_country_year_lagged`
* `vw_country_vulnerability_metrics`

These views feed Python notebooks and charts.

---

## Suggested SQL Schema

Below is a conceptual schema, not final SQL syntax.

### `dim_country`

| Column            | Meaning                |
| ----------------- | ---------------------- |
| `country_id`      | Surrogate key          |
| `country_name`    | Canonical country name |
| `iso2_code`       | ISO alpha-2            |
| `iso3_code`       | ISO alpha-3            |
| `world_bank_code` | Optional source code   |
| `imf_code`        | Optional source code   |
| `region_name`     | Optional grouping      |
| `income_group`    | Optional grouping      |

---

### `raw_inflation_prices`

| Column                | Meaning                |
| --------------------- | ---------------------- |
| `raw_id`              | Raw row id             |
| `source_country_name` | Original country label |
| `source_country_code` | Original source code   |
| `source_period`       | Original time value    |
| `indicator_name`      | Source indicator       |
| `indicator_code`      | Source indicator code  |
| `value`               | Raw numeric value      |
| `unit`                | Raw unit               |
| `source_file`         | File provenance        |
| `loaded_at`           | Load timestamp         |

---

### `raw_fuel_prices`

| Column                | Meaning                  |
| --------------------- | ------------------------ |
| `raw_id`              | Raw row id               |
| `source_country_name` | Original country label   |
| `source_country_code` | Original source code     |
| `source_period`       | Original time value      |
| `fuel_type`           | Petrol / diesel / etc    |
| `price_value`         | Raw price                |
| `currency_code`       | Currency                 |
| `unit`                | Per litre / gallon / etc |
| `source_file`         | File provenance          |
| `loaded_at`           | Load timestamp           |

---

### `clean_inflation_country_period`

| Column                  | Meaning                         |
| ----------------------- | ------------------------------- |
| `country_id`            | FK to country                   |
| `iso3_code`             | Analytical country code         |
| `period_date`           | Normalized date                 |
| `year_num`              | Derived year                    |
| `month_num`             | Nullable                        |
| `food_inflation_pct`    | Target measure                  |
| `inflation_index_value` | Optional raw standardized value |
| `is_partial_period`     | Quality flag                    |
| `source_record_count`   | Traceability                    |

---

### `clean_fuel_country_period`

| Column                | Meaning                  |
| --------------------- | ------------------------ |
| `country_id`          | FK to country            |
| `iso3_code`           | Analytical country code  |
| `period_date`         | Normalized date          |
| `year_num`            | Derived year             |
| `month_num`           | Nullable                 |
| `fuel_type`           | Standardized fuel label  |
| `fuel_price_local`    | Price in local currency  |
| `fuel_price_usd`      | Optional converted value |
| `fuel_price_yoy_pct`  | Derived change           |
| `is_partial_period`   | Quality flag             |
| `source_record_count` | Traceability             |

---

## Joining Strategy

The most important join key is likely:

* `iso3_code`
* `year_num`
* optionally `month_num` if monthly analysis is chosen

The main analytical dataset could look like this:

### `vw_country_year_joined`

For each country-year:

* average annual fuel price
* annual fuel price % change
* annual food inflation %
* lagged fuel price % change
* rolling averages if useful

Example conceptual columns:

| Column                    | Meaning                      |
| ------------------------- | ---------------------------- |
| `iso3_code`               | Country                      |
| `year_num`                | Year                         |
| `food_inflation_pct`      | Food inflation               |
| `avg_fuel_price_local`    | Avg fuel price               |
| `avg_fuel_price_usd`      | Avg fuel price in USD        |
| `fuel_price_yoy_pct`      | Fuel YoY change              |
| `fuel_price_yoy_pct_lag1` | Previous year fuel change    |
| `food_inflation_pct_lag1` | Previous year food inflation |

---

## Possible Vulnerability Coefficients

The user’s intended output is a coefficient that reflects how vulnerable a country may be to food inflation when fuel prices rise.

There are several ways to define such a coefficient.

### Option A: Simple Correlation Coefficient

For each country, compute the correlation between:

* `fuel_price_yoy_pct`
* `food_inflation_pct`

This produces a value from `-1` to `1`.

Interpretation:

* near `1`: food inflation tends to rise when fuel prices rise
* near `0`: weak linear relationship
* near `-1`: inverse relationship

Pros:

* simple,
* intuitive,
* easy to explain.

Cons:

* correlation is not causation,
* sensitive to outliers,
* does not measure magnitude of pass-through directly.

---

### Option B: Regression Slope / Pass-Through Coefficient

For each country, fit a small model like:

```text
food_inflation_pct = a + b * fuel_price_yoy_pct
```

Then use `b` as the country’s **fuel-to-food inflation pass-through coefficient**.

Interpretation:

* larger positive `b` means food inflation reacts more strongly to fuel price increases,
* negative `b` may indicate unusual structure or poor fit,
* near zero suggests low pass-through.

This is likely the most meaningful first coefficient.

Pros:

* more interpretable than plain correlation,
* closer to the idea of vulnerability,
* directly measures expected inflation response per unit fuel i
