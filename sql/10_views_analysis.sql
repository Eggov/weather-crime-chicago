-- 1) Температура vs кількість злочинів по днях
CREATE OR REPLACE VIEW `pet-project-weather-crime.weather_chicago_2022_23.temp_vs_crimes` AS
SELECT 
  w.datetime AS date,
  w.temp,
  COUNT(c.primary_type) AS total_crimes
FROM `pet-project-weather-crime.weather_chicago_2022_23.chicago` AS w
LEFT JOIN `pet-project-weather-crime.weather_chicago_2022_23.crimes` AS c
  ON DATE(c.date) = w.datetime
GROUP BY w.datetime, w.temp
ORDER BY w.datetime;

-- 2) Типи злочинів за діапазонами температур
CREATE OR REPLACE VIEW `pet-project-weather-crime.weather_chicago_2022_23.crimes_by_temp_range` AS
SELECT 
  CASE 
    WHEN w.temp < 0 THEN 'Cold (< 0°C)'
    WHEN w.temp BETWEEN 0 AND 10 THEN 'Cool (0-10°C)'
    WHEN w.temp BETWEEN 10 AND 20 THEN 'Mild (10-20°C)'
    WHEN w.temp BETWEEN 20 AND 30 THEN 'Warm (20-30°C)'
    ELSE 'Hot (>30°C)'
  END AS temp_range,
  c.primary_type,
  COUNT(*) AS crime_count
FROM `pet-project-weather-crime.weather_chicago_2022_23.chicago` AS w
JOIN `pet-project-weather-crime.weather_chicago_2022_23.crimes` AS c
  ON DATE(c.date) = w.datetime
GROUP BY temp_range, c.primary_type
ORDER BY crime_count DESC;

-- 3) Опади vs типи злочинів
CREATE OR REPLACE VIEW `pet-project-weather-crime.weather_chicago_2022_23.crimes_by_precip` AS
SELECT 
  COALESCE(w.preciptype, 'None') AS precipitation_type,
  c.primary_type,
  COUNT(*) AS crime_count
FROM `pet-project-weather-crime.weather_chicago_2022_23.chicago` AS w
JOIN `pet-project-weather-crime.weather_chicago_2022_23.crimes` AS c
  ON DATE(c.date) = w.datetime
GROUP BY precipitation_type, c.primary_type
ORDER BY crime_count DESC;

-- 4) Тиск (приведений до рівня моря) vs кількість злочинів
CREATE OR REPLACE VIEW `pet-project-weather-crime.weather_chicago_2022_23.sealevelpressure_vs_crimes` AS
SELECT 
  w.datetime,
  w.sealevelpressure,
  COUNT(c.primary_type) AS total_crimes
FROM `pet-project-weather-crime.weather_chicago_2022_23.chicago` AS w
LEFT JOIN `pet-project-weather-crime.weather_chicago_2022_23.crimes` AS c
  ON DATE(c.date) = w.datetime
GROUP BY w.datetime, w.sealevelpressure
ORDER BY w.datetime;

-- 5) Локації злочинів при жарі/дощі/нормі
CREATE OR REPLACE VIEW `pet-project-weather-crime.weather_chicago_2022_23.crimes_by_weather_condition` AS
SELECT 
  c.location_description,
  CASE 
    WHEN w.temp >= 25 THEN 'Hot'
    WHEN w.precip > 0 THEN 'Rainy'
    ELSE 'Normal'
  END AS weather_condition,
  COUNT(*) AS crime_count
FROM `pet-project-weather-crime.weather_chicago_2022_23.chicago` AS w
JOIN `pet-project-weather-crime.weather_chicago_2022_23.crimes` AS c
  ON DATE(c.date) = w.datetime
GROUP BY c.location_description, weather_condition
ORDER BY crime_count DESC;
