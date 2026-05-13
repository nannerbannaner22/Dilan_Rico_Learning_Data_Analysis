# Social Media Demographics — Data Pipeline Overview

## Goal

Build a clean, queryable SQL dataset that captures **who uses which social media platforms and how**, broken down by age range and gender. The end goal is to make demographic comparisons easy — across platforms, parent companies, and age brackets — without requiring the reader to understand the raw source CSV.

---

## Schema Design

The dataset lives in the `[smd]` schema and is split into three normalized tables.

```
[smd]
 ├── Platform              — platform names + parent company ownership
 ├── Demographic_Ranges    — reusable age band definitions (lower / upper bound)
 └── Social_Media_Demographics — fact table linking a platform to an age range
                                  with MAU figures and gender breakdowns
```

### Why normalize?

- **Platform** is referenced many times across the fact table. Normalizing it avoids repeating "Facebook", "Meta" on every row and makes it trivial to group by parent company (Meta, ByteDance, Tencent, etc.).
- **Demographic_Ranges** exist because different sources report different age bands. Keeping them as rows instead of columns means new bands can be added without altering the schema.

---

## Cleaning Decisions

| Issue | Decision |
|---|---|
| Parent company unknown | Stored as `'None'` string — excluded from aggregation in the `Parent_Company_Grouping` view via `WHERE NOT ParentCompany = 'None'` |
| MAU figures sometimes projected | `Total_Monthly_Active_Users_Is_Projected` (`bit`) flags estimates; the view surfaces this as a human-readable `'True' / 'False' / 'None'` string |
| Age upper bound `125` | Used as a sentinel for open-ended ranges (e.g. *65+*, *50+*). Readers should interpret these as "this age and above" |
| Duplicate `Id = 29` in `Demographic_Ranges` | A data-entry error — two rows share the same surrogate key. This should be resolved before the table is used in production joins |
| Test row in fact table | The first `INSERT` into `Social_Media_Demographics` is a test record (Platform 1, `Total = 2`, notes `'test notes'`). It should be deleted before any analysis |
| Missing within-group percentages | Several rows record `0` for `Percentage_of_Female/Male_Users_within_age_group` where the source did not report a split. These are **not** true zeroes and should be treated as `NULL` in analysis |

---

## Key Views

### `[smd].[Parent_Company_Grouping]`
Counts how many platforms each parent company owns (excluding independent platforms). Useful for understanding market concentration.

```sql
SELECT * FROM [smd].Parent_Company_Grouping ORDER BY [count];
```

### `[smd].[Social_Media_Demographics_View]`
The main analytical view. Joins all three tables and converts raw IDs and bit flags into readable labels:

| Column | What it shows |
|---|---|
| `Platform` | `PlatformName-ParentCompany` combined label |
| `Range` | Age band as `'lower-upper'` string (e.g. `'18-34'`) |
| `Is_Projection` | Whether MAU figure is an estimate |
| `Percentage_of_Female/Male_Users_within_age_group` | Gender split within that specific age band |
| `Overall_Percentage_of_Female/Male_Users` | Platform-wide gender split |

---

## Analysis Queries

Two aggregations are pre-built on the view:

**By age range** — average overall gender split across all platforms that reported data for that band, ordered by female skew descending.
```sql
SELECT
    COUNT(dmv.Id)                                          AS [count],
    ROUND(AVG(dmv.Overall_Percentage_of_Female_Users), 2) AS [Avg_Female_%],
    ROUND(AVG(dmv.Overall_Percentage_of_Male_Users),   2) AS [Avg_Male_%],
    dmv.[Range]
FROM [smd].[Social_Media_Demographics_View] dmv
GROUP BY dmv.[Range]
ORDER BY [Avg_Female_%] DESC;
```

**By platform** — same averages grouped by platform, useful for ranking which platforms skew most heavily toward one gender.

---

## Platforms Covered

25 platforms across 10 parent companies, spanning Western, Chinese, Japanese, and Eastern European markets.

| Parent Company | Platforms |
|---|---|
| Meta | Facebook, Messenger, Instagram, WhatsApp, Threads |
| ByteDance | TikTok, Douyin |
| Tencent | WeChat/Weixin, QQ, Qzone |
| Alphabet | YouTube |
| Microsoft | LinkedIn |
| Amazon | Twitch |
| Snap Inc | Snapchat |
| X Corp | Twitter (X) |
| Rakuten | Viber |
| LY Corporation | LINE |
| Independent | Pinterest, Reddit, Telegram, Tumblr, Discord, Kuaishou, Sina Weibo, Quora |

---

## Known Gaps & Next Steps

- [ ] Resolve duplicate `Id = 29` in `Demographic_Ranges`
- [ ] Replace `0` within-group percentages with `NULL` for honest aggregation
- [ ] Remove or flag the test INSERT row
- [ ] Add `TikTok`, `QQ`, `Douyin`, `WeChat`, and other platforms present in the source CSV but missing from the fact table
- [ ] Source data citation — add a `Source` column or notes field that records where each MAU / gender figure came from
