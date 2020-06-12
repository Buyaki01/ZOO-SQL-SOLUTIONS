-- QUESTION 1
-- List each country name where the population is larger than that of 'Russia'.

SELECT name FROM world WHERE population>( SELECT population FROM world WHERE name = 'Russia')

-- QUESTION 2
-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name FROM world WHERE continent = 'Europe' AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom')

-- QUESTION 3
-- List the name and continent of countries in the continents containing either Argentina or Australia. 
-- Order by name of the country

SELECT name, continent FROM world 
WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia')) ORDER BY name

-- QUESTION 4
-- Which country has a population that is more than Canada but less than Poland? 
-- Show the name and the population.

SELECT name, population FROM world 
WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland');

-- QUESTION 5
-- Germany (population 80 million) has the largest population of the countries in Europe. 
-- Austria (population 8.5 million) has 11% of the population of Germany.
-- Show the name and the population of each country in Europe. 
-- Show the population as a percentage of the population of Germany.

SELECT name, CONCAT(ROUND(population/(SELECT population FROM world WHERE name = 'Germany')*100), '%') 
FROM world 
WHERE continent = 'Europe'

-- QUESTION 6
-- Which countries have a GDP greater than every country in Europe? 
-- [Give the name only.] (Some countries may have NULL gdp values)

SELECT name FROM world WHERE gdp > ALL(SELECT gdp FROM world WHERE gdp > 0 AND continent = 'Europe')

-- QUESTION 7
-- Find the largest country (by area) in each continent, show the continent, the name and the area: 

SELECT continent, name, area
FROM world
WHERE area IN (SELECT MAX(area) 
                  FROM world 
                 GROUP BY continent)

-- QUESTION 8 
-- List each continent and the name of the country that comes first alphabetically

SELECT continent, MIN(name) AS name
FROM world 
GROUP BY continent
ORDER by continent

-- QUESTION 9
--Find the continents where all countries have a population <= 25000000. 
-- Then find the names of the countries associated with these continents. 
-- Show name, continent and population. 

SELECT name, continent, population
FROM world wd
WHERE NOT EXISTS (
SELECT * FROM world nx
WHERE nx.continent = wd.continent
AND nx.population > 25000000
)

-- QUESTION 10
-- Some countries have populations more than three times that of any of their neighbours (in the same continent). 
-- Give the countries and continents.

SELECT name, continent
FROM world x
WHERE population > ALL(SELECT population*3 FROM world y WHERE x.continent = y.continent AND population > 0 AND y.name != x.name)