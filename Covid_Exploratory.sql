 select *
 from CovidDeaths
 where continent is not null
 order by 3,4
 
 
 SELECT Location , date ,
 total_cases ,new_cases ,
 total_deaths , population 
 from CovidDeaths
  where continent is not null
 order by 1,2

 -- looking total cases vs total deaths 
  
 SELECT Location , date ,
 total_cases ,total_deaths ,(total_deaths/total_cases)*100 as death_percentateg
 from CovidDeaths
 where location like '%egypt%'
  where continent is not null
 order by 1,2

 --looking  at total cases vs population 

   
 SELECT Location , date ,population ,
 total_cases ,(total_deaths/population)*100 as Percent_Population_Infected 
 from CovidDeaths
  where continent is not null
 order by 1,2


  -- the highest countries
  
     
 SELECT Location ,population ,
 Max(total_cases) as Highest_infection  ,Max(total_cases/population)*100 as Percent_Population_Infected 
 from CovidDeaths
  where continent is not null
 group by location,population
 order by Percent_Population_Infected Desc
 

 -- counteries highest death count per population 
 
Select location ,Max(cast (total_deaths as int)) as total_death_count
from CovidDeaths
 where continent is not null
group by location 
order by total_death_count desc

-- let's braek things by continent  

Select continent ,Max(cast (total_deaths as int)) as total_death_count
from CovidDeaths 
where continent is not null
group by continent
order by total_death_count desc
 

 -- global numbers

 SELECT sum(new_cases) as total_cases , sum(cast(new_deaths as int)) as total_deaths ,
 sum(cast(new_deaths as int ))/sum(new_cases)*100 as deaths_percentege
 from CovidDeaths
 where continent is not null
 order by 1,2




    --use cte
   with popvsvac (continent,location,date,population,new_vaccinations,rolling_people_vacc)
   as
   (
 -- looking at total population vs vaccinations 
 select dea.continent , dea.location ,dea.date,dea.population ,vac.new_vaccinations
 ,sum(cast(vac.new_vaccinations as int )) over(partition by dea.location order by dea.location,dea.date) as rolling_people_vacc
 from  CovidDeaths dea
 Join CovidVaccinations vac 
 on  dea.location = vac.location and dea.date = vac.date  
 where dea.continent is not null
 --order by 2,3
   
   )
   select *,(rolling_people_vacc/population)*100  
   from popvsvac




   --TEMP TABLE

   DROP Table if exists #percent_population_vacc
   create Table #percent_population_vacc
   (continent nvarchar(255),location nvarchar(255),Date datetime,
   population numeric,new_vaccinations numeric,rolling_people_vacc numeric)
   insert into #percent_population_vacc
    -- looking at total population vs vaccinations 
 select dea.continent , dea.location ,dea.date,dea.population ,vac.new_vaccinations
 ,sum(cast(vac.new_vaccinations as int )) over(partition by dea.location order by dea.location,dea.date) as rolling_people_vacc
 from  CovidDeaths dea
 Join CovidVaccinations vac 
 on  dea.location = vac.location and dea.date = vac.date  
--where dea.continent is not null

  select *,(rolling_people_vacc/population)*100  
   from #percent_population_vacc


   --creating view to store date for later  visualizations

   CREATE VIEW percent_population_vacc as
   select dea.continent , dea.location ,dea.date,dea.population ,vac.new_vaccinations
 ,sum(cast(vac.new_vaccinations as int )) over(partition by dea.location order by dea.location,dea.date) as rolling_people_vacc
 from  CovidDeaths dea
 Join CovidVaccinations vac 
 on  dea.location = vac.location and dea.date = vac.date  
where dea.continent is not null
--order by 2,3
 

 select *
 from percent_population_vacc