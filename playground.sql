select * from fun.animals a where a.WeightKg >= 500 order by a.WeightKg desc;

select 
    count(a.AnimalId) as [Total], 
    avg(a.WeightKg) as [Average Weight], 
    avg(a.HeightCm) as [Average Height], 
    c.Continent
from fun.animals a join fun.country c on a.CountryOfOriginId = c.CountryId
where c.Continent is NOT NULL
group by c.Continent
order by count(a.AnimalId);