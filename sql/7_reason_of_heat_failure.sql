-- Посмтрим сколько поломок произошло при условии низкой разницы температур temp_diff <= 8.60,
-- а также низкой скорости вращения rotational_speed <= 1379

SELECT failure_type, count(*) AS count FROM predictive_maintenance_features
WHERE temp_diff <= 8.60 AND rotational_speed <= 1379
GROUP BY failure_type;

--       failure_type       | count
----------------------------+-------
-- Power Failure            |     4
-- No Failure               |    13
-- Heat Dissipation Failure |   112
-- Overstrain Failure       |     1

-- Все 112 поломок попали в это зону. Но также в нее попали 13 нормальных строк
-- Проверим лежат ли они на границе temp_diff

SELECT failure_type, count(*) AS count FROM predictive_maintenance_features
WHERE temp_diff < 8.60 AND rotational_speed <= 1379
GROUP BY failure_type;

--       failure_type       | count
----------------------------+-------
-- Power Failure            |     3
-- Heat Dissipation Failure |   100

-- No Failure ушли, но вместе с ними пропали 12 перегревов

-- Считаю оставить temp_diff <= 8.6 т.к. по моему мнению 12 поломок станка стоят дороже чем 13 ложных тех обслуживаний.