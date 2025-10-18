WITH
cte_weather AS (
  SELECT
    timestamp(w.datetime)                         AS date,               
    ((w.temp - 32) * 5.0 / 9.0)           AS temp_c,
    w.precip                                 AS precip_amount,      
    COALESCE(w.preciptype, 'None')           AS precip_type,        
    w.sealevelpressure                       AS pres                
  FROM `pet-project-weather-crime.weather_chicago_2022_23.chicago` AS w
),

cte_crimes AS (
  SELECT
    c.date                                    AS date,              
    c.primary_type                            AS primary_type,
    c.location_description                    AS loc_disc,
    c.Latitude                                AS loc_lat,
    c.Longitude                               AS loc_long,
    COUNT(*)                                  AS total_crimes
  FROM `pet-project-weather-crime.weather_chicago_2022_23.crimes` AS c
  GROUP BY date, primary_type, loc_disc, loc_lat, loc_long
)

SELECT
  c.date,
  w.temp_c,
  w.precip_amount,
  w.precip_type,
  w.pres,
  c.total_crimes,
  c.primary_type,
  c.loc_lat,
  c.loc_long,
  c.loc_disc,
  CASE 
    WHEN w.temp_c < 0            THEN 'Cold (< 0°C)'
    WHEN w.temp_c BETWEEN 0 AND 10  THEN 'Cool (0-10°C)'
    WHEN w.temp_c BETWEEN 10 AND 20 THEN 'Mild (10-20°C)'
    WHEN w.temp_c BETWEEN 20 AND 30 THEN 'Warm (20-30°C)'
    ELSE 'Hot (>30°C)'
  END AS temp_range,
  CASE 
    WHEN w.temp_c >= 25          THEN 'Hot'
    WHEN w.precip_amount > 0     THEN 'Rainy'
    ELSE 'Normal'
  END AS weather_condition
FROM cte_crimes c
inner join cte_weather w
USING (date)                        
ORDER BY w.date
limit 10
