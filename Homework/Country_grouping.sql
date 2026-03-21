CREATE OR ALTER VIEW dbo.Inflation_Estimates_Statistical_Analysis_Country_Grouping
AS
WITH Stats AS
(
    SELECT
        pfe.Country,

        AVG(CAST(pfe.[Open] AS DECIMAL(18,4))) OVER (PARTITION BY pfe.Country) AS Mean_Open,
        AVG(CAST(pfe.[High] AS DECIMAL(18,4))) OVER (PARTITION BY pfe.Country) AS Mean_High,
        AVG(CAST(pfe.[Low] AS DECIMAL(18,4))) OVER (PARTITION BY pfe.Country) AS Mean_Low,
        AVG(CAST(pfe.[Close] AS DECIMAL(18,4))) OVER (PARTITION BY pfe.Country) AS Mean_Close,
        AVG(CAST(pfe.[Inflation] AS DECIMAL(18,4))) OVER (PARTITION BY pfe.Country) AS Mean_Inflation,

        PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY pfe.[Open]) OVER (PARTITION BY pfe.Country) AS Discrete_Median_Open,
        PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY pfe.[High]) OVER (PARTITION BY pfe.Country) AS Discrete_Median_High,
        PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY pfe.[Low]) OVER (PARTITION BY pfe.Country) AS Discrete_Median_Low,
        PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY pfe.[Close]) OVER (PARTITION BY pfe.Country) AS Discrete_Median_Close,
        PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY pfe.[Inflation]) OVER (PARTITION BY pfe.Country) AS Discrete_Median_Inflation,

        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY pfe.[Open]) OVER (PARTITION BY pfe.Country) AS Continuous_Median_Open,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY pfe.[High]) OVER (PARTITION BY pfe.Country) AS Continuous_Median_High,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY pfe.[Low]) OVER (PARTITION BY pfe.Country) AS Continuous_Median_Low,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY pfe.[Close]) OVER (PARTITION BY pfe.Country) AS Continuous_Median_Close,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY pfe.[Inflation]) OVER (PARTITION BY pfe.Country) AS Continuous_Median_Inflation
    FROM dbo.PriceInflationEstimates pfe
),
ModeOpen AS
(
    SELECT Country, [Open] AS Mode_Open
    FROM
    (
        SELECT
            Country,
            [Open],
            DENSE_RANK() OVER (
                PARTITION BY Country
                ORDER BY COUNT(*) DESC, [Open]
            ) AS rn
        FROM dbo.PriceInflationEstimates
        GROUP BY Country, [Open]
    ) x
    WHERE rn = 1
),
ModeHigh AS
(
    SELECT Country, [High] AS Mode_High
    FROM
    (
        SELECT
            Country,
            [High],
            DENSE_RANK() OVER (
                PARTITION BY Country
                ORDER BY COUNT(*) DESC, [High]
            ) AS rn
        FROM dbo.PriceInflationEstimates
        GROUP BY Country, [High]
    ) x
    WHERE rn = 1
),
ModeLow AS
(
    SELECT Country, [Low] AS Mode_Low
    FROM
    (
        SELECT
            Country,
            [Low],
            DENSE_RANK() OVER (
                PARTITION BY Country
                ORDER BY COUNT(*) DESC, [Low]
            ) AS rn
        FROM dbo.PriceInflationEstimates
        GROUP BY Country, [Low]
    ) x
    WHERE rn = 1
),
ModeClose AS
(
    SELECT Country, [Close] AS Mode_Close
    FROM
    (
        SELECT
            Country,
            [Close],
            DENSE_RANK() OVER (
                PARTITION BY Country
                ORDER BY COUNT(*) DESC, [Close]
            ) AS rn
        FROM dbo.PriceInflationEstimates
        GROUP BY Country, [Close]
    ) x
    WHERE rn = 1
),
ModeInflation AS
(
    SELECT Country, [Inflation] AS Mode_Inflation
    FROM
    (
        SELECT
            Country,
            [Inflation],
            DENSE_RANK() OVER (
                PARTITION BY Country
                ORDER BY COUNT(*) DESC, [Inflation]
            ) AS rn
        FROM dbo.PriceInflationEstimates
        GROUP BY Country, [Inflation]
    ) x
    WHERE rn = 1
)
SELECT DISTINCT
    s.Country,

    s.Mean_Open,
    s.Mean_High,
    s.Mean_Low,
    s.Mean_Close,
    s.Mean_Inflation,

    s.Discrete_Median_Open,
    s.Discrete_Median_High,
    s.Discrete_Median_Low,
    s.Discrete_Median_Close,
    s.Discrete_Median_Inflation,

    s.Continuous_Median_Open,
    s.Continuous_Median_High,
    s.Continuous_Median_Low,
    s.Continuous_Median_Close,
    s.Continuous_Median_Inflation,

    mo.Mode_Open,
    mh.Mode_High,
    ml.Mode_Low,
    mc.Mode_Close,
    mi.Mode_Inflation
FROM Stats s
LEFT JOIN ModeOpen mo
    ON s.Country = mo.Country
LEFT JOIN ModeHigh mh
    ON s.Country = mh.Country
LEFT JOIN ModeLow ml
    ON s.Country = ml.Country
LEFT JOIN ModeClose mc
    ON s.Country = mc.Country
LEFT JOIN ModeInflation mi
    ON s.Country = mi.Country;