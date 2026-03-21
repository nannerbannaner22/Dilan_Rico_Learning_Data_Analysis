create or alter view GroupedPriceInflationEstimates as
select 
    COUNT(p.Id) as 'Total Index',
    AVG(p.[OPEN]) as 'Open', 
    AVG(p.High) as 'High', 
    AVG(p.Low) as 'Low', 
    AVG(p.[Close]) as 'Close', 
    ROUND(SUM(p.Inflation), 2)  as 'Total',
    p.country,
    p.ISO3
from dbo.PriceInflationEstimates p
group by p.country, ISO3;