-- Получение доли поломок по классу детали 
-- L - 3.92
-- M - 2.77
-- H - 2.09
SELECT type, count(*) AS total,
    SUM(target) AS failures,
    ROUND(avg(target) * 100, 2) AS percent 
FROM predictive_maintenance
group by type
order by percent DESC;