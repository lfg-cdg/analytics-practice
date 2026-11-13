-- Посмотрим на долю поломок из за износа инструмента по группам

WITH tool_wear_analyse AS (
SELECT MIN(tool_wear) AS min_wear, CASE WHEN
tool_wear < 50 THEN '0-49'
WHEN tool_wear < 100 THEN '50-99'
WHEN tool_wear < 150 THEN '100-149'
WHEN tool_wear < 200 THEN '150-199'
WHEN tool_wear < 210 THEN '200-209' WHEN tool_wear < 220 THEN '210-219' WHEN tool_wear < 230 THEN '220-229' WHEN tool_wear < 240 THEN '230-239' ELSE '240+'
END AS wear_bin, count(*) AS total, count(*) FILTER (WHERE failure_type = 'Tool Wear Failure') AS tool_failure_total FROM predictive_maintenance_clean
GROUP BY wear_bin )
SELECT *, ROUND((tool_failure_total * 1.0 / total) * 100.0, 2) AS share FROM tool_wear_analyse
ORDER BY min_wear;

-- min_wear | wear_bin | total | tool_failure_total | share
------------+----------+-------+--------------------+-------
--        0 | 0-49     |  2347 |                  0 |  0.00
--       50 | 50-99    |  2270 |                  0 |  0.00
--      100 | 100-149  |  2287 |                  0 |  0.00
--      150 | 150-199  |  2287 |                  1 |  0.04
 --     200 | 200-209  |   407 |                 16 |  3.93
 --     210 | 210-219  |   252 |                 12 |  4.76
 --     220 | 220-229  |    96 |                  9 |  9.38
 --     230 | 230-239  |    31 |                  5 | 16.13
 --     240 | 240+     |    14 |                  2 | 14.29

-- Явного порога при поломке нету. Чем лольше работает инстремент, тем выше шанс, что он сломается.
-- Следить за порогом не нужно, достаточно раз в 200 минут менять инструмент
