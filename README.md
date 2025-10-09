# Weather & Crime in Chicago (2022–2023)

Аналіз впливу погодних факторів (температура, опади, тиск) на частоту, характер і локації злочинів у Чикаго.  
Стек: **BigQuery + SQL + Looker Studio**.

## 🔗 Дашборд
- Публічна лінка: див. `dashboard/link.txt`
- Експорт у PDF та скріншоти: `dashboard/exports/`, `dashboard/screenshots/`

## 📦 Дані
- **Злочини**: Chicago Data Portal — *Crimes - 2001 to Present*
- **Погода**: Open-Meteo / VisualCrossing (історичні погодні дані)
- **Одиниці вимірювання**: температура — °C, тиск — hPa (`sealevelpressure`)

Докладніше: `docs/schema.md` та `docs/methods.md`.

## 🧱 Архітектура
BigQuery (таблиці `crimes`, `chicago`) → SQL Views/матеріалізовані таблиці → Looker Studio.

