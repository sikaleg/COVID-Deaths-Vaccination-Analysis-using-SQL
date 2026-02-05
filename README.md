# COVID-19 Data Analysis Using SQL (MySQL)
## Project Overview

This project performs a comprehensive analysis of global COVID-19 data using SQL (MySQL 8+).
The analysis explores COVID-19 infections, deaths, and vaccination trends across countries and continents.
It demonstrates data cleaning, aggregation, window functions, and views to create reusable datasets for analysis and visualization.

The focus of this project is on country-level insights while excluding aggregate regions such as continents and global totals.

## Dataset

The analysis uses the Our World in Data (OWID) COVID-19 <a href='https://ourworldindata.org/covid-deaths'>Dataset:</a>

- coviddeaths — contains daily data on COVID-19 cases, deaths, and population
- covidvaccinations — contains daily vaccination data including new vaccinations

Notes:

- Numeric fields such as total_deaths and new_vaccinations are stored as text and required casting to numeric types.
- Aggregate rows (World, continents) were excluded by filtering on iso_code NOT LIKE 'OWID%'.
- Data cleaning ensures accurate country-level statistics.

## Tools & Technologies
- Excel for data cleaning, preprocessing, and formatting before importing into MySQL
- SQL (SELECT, JOIN, CTEs, window functions, views)
- GitHub for version control and documentation

## Analysis Performed
1. COVID-19 Cases and Deaths
- Calculated total cases and deaths per country
- Computed death percentage: likelihood of dying if infected
- Computed infection percentage relative to population
2. Country-Level Rankings
- Identified countries with highest infection rates relative to population
- Ranked countries with highest total deaths
- Aggregated by continent to show continental-level death trends
  
  <img width="236" height="137" alt="continent" src="https://github.com/user-attachments/assets/bb82e525-7dc4-478d-ae4c-6d51bc5d1129" />

3. Global Summary
- Calculated total global cases and deaths
- Computed overall global death percentage

  
  <img width="376" height="117" alt="global numbers" src="https://github.com/user-attachments/assets/04a7ce4d-01d5-4cf2-bdbb-28e3943c6b92" />

4. Vaccination Analysis
- Joined coviddeaths and covidvaccinations to calculate rolling vaccination metrics
- Computed rolling number of people vaccinated per country using window functions
- Calculated percentage of population vaccinated over time
5. Reusable Views
- Created the view PercentPopulationVaccinated for easy querying and visualization
<img width="740" height="316" alt="Screenshot 2026-02-05 133629" src="https://github.com/user-attachments/assets/8b5a8593-1bcc-4a75-a8d6-c3c32eaa9575" />

## Key Insights
- Countries with the highest population generally had the highest total deaths, but death percentage varies widely.
- Vaccination rollout speed and adoption differed significantly across regions.
- Rolling vaccination metrics reveal the rate of vaccine uptake over time at the country level.
- Aggregating data by continent provides insight into regional trends and the overall pandemic impact.

## Conclusion
This project demonstrates a full end-to-end COVID-19 data analysis workflow using SQL. Starting from data cleaning and preprocessing in Excel, the project progresses to advanced SQL queries that calculate key metrics such as total cases, deaths, and vaccination rates.

By leveraging window functions, aggregations, CTEs, and views, the analysis provides country-level and continent-level insights while ensuring data accuracy through the exclusion of aggregate regions. The creation of the PercentPopulationVaccinated view also illustrates how SQL can be used to prepare datasets for visualization and further analysis efficiently.

Overall, this project highlights strong data wrangling, analytical thinking, and SQL proficiency
