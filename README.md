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

### Notes:

- Numeric fields such as total_deaths and new_vaccinations are stored as text and required casting to numeric types.
- Aggregate rows (World, continents) were excluded by filtering on iso_code NOT LIKE 'OWID%'.
- Data cleaning ensures accurate country-level statistics.

## Tools & Technologies
- Excel for data cleaning, preprocessing, and formatting before importing into MySQL
- SQL (SELECT, JOIN, CTEs, window functions, views)
- GitHub for version control and documentation

