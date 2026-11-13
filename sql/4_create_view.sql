-- Создадим виртуальную таблицу чтобы удобней выполнить запросы
CREATE VIEW predictive_maintenance_features AS
SELECT *, round((process_temp - air_temp)::numeric, 2) AS temp_diff,
round((rotational_speed * torque * 2 * PI() / 60)::numeric, 2) AS power
FROM predictive_maintenance_clean;