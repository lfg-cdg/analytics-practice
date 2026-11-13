CREATE TABLE predictive_maintenance (
udi INTEGER,
product_id VARCHAR(10),
type VARCHAR(5),
air_temperature REAL,
process_temperature REAL,
rotational_speen INTEGER,
torque REAL,
tool_wear INTEGER,
target INTEGER,
failure_type VARCHAR(50)
);

\COPY predictive_maintenance FROM '/home/glavar/sql-practice/predictive_maintenance.csv' DELIMITER ',' CSV HEADER;
