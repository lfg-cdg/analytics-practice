-- Выясним какие факторы приводят к поломке из за перегрева.
-- Для этого рассчитаем avg, min, max, std для колонки temp_diff

SELECT failure_type, round(avg(temp_diff)::numeric, 2) AS avg_temp_diff,
round(min(temp_diff)::numeric, 2) AS min_temp_diff,
round(max(temp_diff)::numeric, 2) AS max_temp_diff,
round(stddev(temp_diff)::numeric, 2) AS temp_diff_std
FROM predictive_maintenance_features
GROUP BY failure_type
ORDER BY failure_type;

--       failure_type       | avg_temp_diff | min_temp_diff | max_temp_diff | temp_diff_std
----------------------------+---------------+---------------+---------------+---------------
-- Heat Dissipation Failure |          8.23 |          7.60 |          8.60 |          0.28
-- No Failure               |         10.02 |          7.60 |         12.10 |          0.99
-- Overstrain Failure       |         10.18 |          8.40 |         12.00 |          0.89
-- Power Failure            |          9.88 |          7.60 |         11.90 |          1.00
-- Random Failures          |          9.99 |          8.90 |         11.50 |          0.83
-- Tool Wear Failure        |          9.88 |          7.80 |         11.50 |          1.07

-- При нормальной работе avg_temp_diff лежит в диапазоне ~ от 9 до 11, когда при поломке ~ от 8 до 8.51.
-- Максимальное же значение при поломке - 8.60, а деталей без поломок при таком же и ниже значение - 676
-- Т.к. стандартное отклонение мало - поломка возникает при узких условиях. Надо понять при каких.

-- Посчитаем общее кол-во поломок по каждой причине

SELECT failure_type, count(*) AS count_failures FROM predictive_maintenance_clean
GROUP BY failure_type
ORDER BY failure_type;

--       failure_type       | count_failures
----------------------------+----------------
-- Heat Dissipation Failure |            112
-- No Failure               |           9643
-- Overstrain Failure       |             78
-- Power Failure            |             95
-- Random Failures          |             18
-- Tool Wear Failure        |             45

-- 112 поломок из за перегрева. Перегрев не зависит только от низкой разницы температур temp_diff <= 8.60 т.к. имеется 676 успешных деталей,
-- высеченных при таком же условии.
-- Проверим скорость.
