CREATE or alter VIEW dbo.Inflation_Estimates_Statistical_Analysis
AS
WITH Stats AS
(
    SELECT
        --Mean
        AVG(CAST(pfe.[Open] AS DECIMAL(18,4))) OVER () AS Mean_Open,
        AVG(CAST(pfe.[High] AS DECIMAL(18,4))) OVER () AS Mean_High,
        AVG(CAST(pfe.[Low] AS DECIMAL(18,4))) OVER () AS Mean_Low,
        AVG(CAST(pfe.[Close] AS DECIMAL(18,4))) OVER () AS Mean_Close,
        AVG(CAST(pfe.Inflation AS DECIMAL (18,4))) OVER () AS Mean_Inflation,

        --Discrete_Median
        PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY pfe.[Open]) OVER () AS Discrete_Median_Open,
        PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY pfe.[High]) OVER () AS Discrete_Median_High,
        PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY pfe.[Low]) OVER () AS Discrete_Median_Low,
        PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY pfe.[Close]) OVER () AS Discrete_Median_Close,
        PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY pfe.[Inflation]) OVER () AS Discrete_Inflation_Close,

        --Continuous_Median
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY pfe.[Open]) OVER () AS Continuous_Median_Open,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY pfe.[High]) OVER () AS Continuous_Median_High,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY pfe.[Low]) OVER () AS Continuous_Median_Low,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY pfe.[Close]) OVER () AS Continuous_Median_Close,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY pfe.[Inflation]) OVER () AS Continuous_Inflation_Close
    FROM dbo.PriceInflationEstimates pfe
)
SELECT DISTINCT
    Mean_Open,
    Mean_High,
    Mean_Low,
    Mean_Close,

    Discrete_Median_Open,
    Discrete_Median_High,
    Discrete_Median_Low,
    Discrete_Median_Close,

    Continuous_Median_Open,
    Continuous_Median_High,
    Continuous_Median_Low,
    Continuous_Median_Close,

    (
        SELECT TOP 1 [Open]
        FROM dbo.PriceInflationEstimates
        GROUP BY [Open]
        ORDER BY COUNT(*) DESC, [Open]
    ) AS Mode_Open,

    (
        SELECT TOP 1 [High]
        FROM dbo.PriceInflationEstimates
        GROUP BY [High]
        ORDER BY COUNT(*) DESC, [High]
    ) AS Mode_High,

    (
        SELECT TOP 1 [Low]
        FROM dbo.PriceInflationEstimates
        GROUP BY [Low]
        ORDER BY COUNT(*) DESC, [Low]
    ) AS Mode_Low,

    (
        SELECT TOP 1 [Close]
        FROM dbo.PriceInflationEstimates
        GROUP BY [Close]
        ORDER BY COUNT(*) DESC, [Close]
    ) AS Mode_Close,
    (
        Select top 1 [Inflation]
        from dbo.PriceInflationEstimates pfe
        group by [Inflation]
        Order by COUNT(*) desc, [Inflation]
    ) as Mode_Inflation
FROM Stats;