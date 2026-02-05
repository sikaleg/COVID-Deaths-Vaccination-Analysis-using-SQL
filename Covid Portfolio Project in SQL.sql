CREATE DATABASE PortfolioProject;
select *
from portfolioproject.coviddeaths
order by 3,4

/* select *
from portfolioproject.covidvaccinations
order by 3,4
*/
	-- select data that i'll be using
    
select location, date, total_cases, new_cases, total_deaths, population
from portfolioproject.coviddeaths
order by 1,2

-- Lookin at Total cases vs Total deaths
-- Shows likelihood of dying if you contract covid in your country

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from portfolioproject.coviddeaths
-- where location like '%Nigeria%'
order by 1,2

-- Looking at Total cases vs Population

select location, date, population, total_cases, (total_cases/population)*100 as PercentageOfPopulationInfected
from portfolioproject.coviddeaths
-- where location like '%Nigeria%'
order by 1,2

-- Looking at Countries with Highest Infection Rate compared to Population

select location, population,  Max(total_cases) as HighestInfectionCount, MAX((total_cases)/population)*100 as PercentageOfPopulationInfected
from portfolioproject.coviddeaths
-- where location like '%Nigeria%'
Group by location, population
order by PercentageOfPopulationInfected desc

-- Showing Countries with Highest Death Count Per Population

select location, Max(cast(total_deaths as signed)) as TotalDeathCount
from portfolioproject.coviddeaths
-- where location like '%Nigeria%'
Where iso_code not like 'OWID%'
Group by location
order by TotalDeathCount desc

-- Let's Break Things Down By Continent
-- Showing Continents with Highest Death Count Per Population
select continent, Max(cast(total_deaths as signed)) as TotalDeathCount
from portfolioproject.coviddeaths
-- where location like '%Nigeria%'
Where iso_code not like 'OWID%'
Group by continent
order by TotalDeathCount desc

-- GLOBAL NUMBERS

select sum(new_cases) as total_cases, sum(cast(new_deaths as signed)) as total_deaths, 
sum(cast(new_deaths as signed))/ sum(new_cases)*100 as DeathPercentage
from portfolioproject.coviddeaths
-- where location like '%Nigeria%'
Where iso_code not like 'OWID%'
order by 1,2

-- Looking at Total Population vs Vaccination

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as signed)) over (partition by dea.location order by 
dea.location, dea.date) as RollingPeopleVaccinated
from portfolioproject.coviddeaths dea
join portfolioproject.covidvaccinations vac
	on dea.location = vac.location
    and dea.date = vac.date
Where dea.iso_code not like 'OWID%'
order by 2,3
    
-- USE CTE

with PopvsVac as (
    select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
        sum(cast(nullif(vac.new_vaccinations, '') as signed)) 
            over (partition by dea.location order by dea.date) 
            as RollingPeopleVaccinated
    from portfolioproject.coviddeaths dea
    join portfolioproject.covidvaccinations vac
        on dea.location = vac.location
        and dea.date = vac.date
    where dea.iso_code not like 'OWID%'
)
select *, (RollingPeopleVaccinated/population)*100
from PopvsVac;


-- BETTER & SIMPLER

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
    SUM(CAST(NULLIF(vac.new_vaccinations, '') as signed)) 
        over (partition by dea.location order by dea.date)
        as RollingPeopleVaccinated,
    (SUM(CAST(NULLIF(vac.new_vaccinations, '') as signed)) 
        over (partition by dea.location order by dea.date) / dea.population) * 100
        as PercentPopulationVaccinated
from portfolioproject.coviddeaths dea
join portfolioproject.covidvaccinations vac
    on dea.location = vac.location
    and dea.date = vac.date
where dea.iso_code not like 'OWID%';

-- CREATING VIEW TO STORE DATA FOR LATER VISUALIZATION

create view PercentPopulationVaccinated AS
select continent, location, date, population, new_vaccinations, RollingPeopleVaccinated,
    (RollingPeopleVaccinated / population) * 100 as PercentPopulationVaccinated
from (
    select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
        SUM(CAST(NULLIF(vac.new_vaccinations, '') as signed))
            over (partition by dea.location order by dea.date)
            as RollingPeopleVaccinated
    from portfolioproject.coviddeaths dea
    join portfolioproject.covidvaccinations vac
        on dea.location = vac.location
        and dea.date = vac.date
    where dea.iso_code not like 'OWID%'
) t;



