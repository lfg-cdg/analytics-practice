-- Посмотрим на параметры условий для каждого типа поломки:
--  сколько всего строк с этой поломкой
--  средняя разница температур
--  средняя скорость вращения
--  средний крутящий момент
--  средний износ инструмента

SELECT failure_type, 
    count(*) AS count, 
    round(avg(process_temp - air_temp)::numeric, 2) AS avg_temp_diff,
    round(avg(rotational_speed)::numeric, 2) AS avg_rot_speed,
    round(avg(torque)::numeric, 2) as avg_torque,
    round(avg(tool_wear)::numeric, 2) as avg_tool_wear
FROM predictive_maintenance_clean
GROUP BY failure_type
ORDER BY count DESC;

--       failure_type       | count | avg_temp_diff | avg_rot_speed | avg_torque | avg_tool_wear
--------------------------+-------+---------------+---------------+------------+---------------
-- No Failure               |  9643 |         10.02 |       1540.35 |      39.62 |        106.67
-- Heat Dissipation Failure |   112 |          8.23 |       1337.96 |      52.78 |        107.34
-- Power Failure            |    95 |          9.88 |       1763.97 |      48.51 |        101.88
-- Overstrain Failure       |    78 |         10.18 |       1354.24 |      56.88 |        208.22
-- Tool Wear Failure        |    45 |          9.88 |       1570.67 |      37.23 |        216.56
-- Random Failures          |    18 |          9.99 |       1489.44 |      43.52 |        119.89