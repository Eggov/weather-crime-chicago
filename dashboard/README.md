# Weather & Crime Dashboard — Як користуватись

1) Відкрий публічну лінку з `dashboard/link.txt`.
2) Джерела даних: BigQuery → проект `pet-project-weather-crime` → датасет `weather_chicago_2022_23` → views.
3) Фільтри (рекомендовано):
   - Date range (2022–2023)
   - Temperature range
   - Precipitation type
   - Crime type
4) Розділи:
   - **Weather Impact on Crime Rates** — температура/SLP vs total crimes
   - **Crime Types by Weather Conditions** — типи по діапазонах температур та опадах
   - **Locations of Crimes under Heat or Rain** — локації при Hot/Rainy/Normal
5) Експорт: File → Download → PDF (збережи у `dashboard/exports/`).

