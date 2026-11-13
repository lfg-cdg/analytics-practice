-- Рассчитаем avg, min, max, std для колонки rotational_speed

SELECT failure_type, round(avg(rotational_speed)::numeric, 2) AS avg_rotational_speed,
round(min(rotational_speed)::numeric, 2) AS min_rotational_speed,
round(max(rotational_speed)::numeric, 2) AS max_rotational_speed,
round(stddev(rotational_speed)::numeric, 2) AS rotational_speed_std
FROM predictive_maintenance_features
GROUP BY failure_type
ORDER BY failure_type;

--       failure_type       | avg_rotational_speed | min_rotational_speed | max_rotational_speed | rotational_speed_std
----------------------------+----------------------+----------------------+----------------------+----------------------
-- Heat Dissipation Failure |              1337.96 |              1212.00 |              1379.00 |                34.37
-- No Failure               |              1540.35 |              1168.00 |              2695.00 |               167.47
-- Overstrain Failure       |              1354.24 |              1181.00 |              1515.00 |                59.63
-- Power Failure            |              1763.97 |              1200.00 |              2886.00 |               620.83
-- Random Failures          |              1489.44 |              1306.00 |              1687.00 |               110.83
-- Tool Wear Failure        |              1570.67 |              1323.00 |              2271.00 |               205.80

-- Нормальная средняя скорость в диапазоне ~ от 1373 до 1707, при перегреве ~ от 1303 до 1371.
-- Деталей высеченных на скорости <=  1379 (максимальной) - 1139, что также означает, что низкая скорость 
-- не является единственной причиной перегрева.

-- Также как и с температурой, у значений скорости при перегреме маленькое стандартное отклонение, что также говорит,
-- что причина узкая.