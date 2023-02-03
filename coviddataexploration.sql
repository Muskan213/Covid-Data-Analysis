create database coviddata;
use coviddata;


select * from coviddeaths ;
select * from covidvaccination;


#showing Total Cases v/s Total Deaths
select location,date,population,total_cases,new_cases,total_deaths
from coviddeaths 
where  continent is not null order by 1;



# showing total deaths out of total cases  
select location,date,total_cases,total_deaths,population,
round(total_deaths  *100.0/total_cases,2) as Deathprcnt 
from coviddeaths where continent is not null;



#showing countries with highest cases out of total population
select location,date,total_cases,max(total_cases) as total_case,
total_deaths,population ,round(max(total_cases)*100.0/population,2) 
as pcnt_of_infected_population from coviddeaths 
where continent is NOT NULL 
group by location
order by pcnt_of_infected_population desc ;


#showing continent with highest cases 
select continent,date,population,max(total_cases) as highest_infection_count,
round(max(total_cases)*100/population,2) as prcnt_population_infected 
from coviddeaths 
where continent is NOT NULL 
group by continent
order by prcnt_population_infected desc;



#showing countries with Highest Death Count 
select location,max(total_deaths) as total_death_count 
from coviddeaths where  continent is NOT NULL 
group by location 
order by total_death_count desc ; 



#showing continent with Highest Death count 
select continent,sum(total_death_count ) as total  from
(select continent,location,max(total_deaths) as total_death_count 
from coviddeaths 
where continent is NOT NULL 
group by location)a 
group by continent
order by total desc; 



#showing Death percentage across the Globe
select date,sum(new_cases) as total_cases,sum(new_deaths) as total_deaths,
round(sum(new_deaths)*100.0/sum(new_cases),2) as death_prcnt 
from coviddeaths where continent is not null group by date;



#showing Vaccinations done on a particular day
select cd.continent,cd.location,cd.date,cv.population,new_vaccinations
from coviddeaths as cd join covidvaccination as cv 
on cd.location=cv.location and cd.date=cv.date
where cd.continent is not null ;


#showing total vaccinations done upto a particular date
select cd.continent,cd.location, cd.date, cd.population, cv.new_vaccinations,
sum(cv.new_vaccinations) over (partition by cd.location order by  cd.date) 
 as total_vaccination from coviddeaths cd
join covidvaccination as cv
on cd.location =cv.location
and cd.date = cv.date
where cd.continent is not null;
 


#showing population fully vaccinated 
select location,max(people_fully_vaccinated ) as population_fully_vaccinated
from covidvaccination where continent is not null
group by location 
order by population_fully_vaccinated desc;


#showing population vaccinated with booster dose
select location,max(total_boosters) as pop_vaccinated_with_booster
from covidvaccination where continent is not null
group by location 
order by pop_vaccinated_with_booster desc;

