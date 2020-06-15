-- QUESTION 1
-- The example uses a WHERE clause to show the cases in 'Italy' in March.
-- Modify the query to show data from Spain

SELECT name, DAY(whn),
 confirmed, deaths, recovered
 FROM covid
WHERE name = 'Spain'
AND MONTH(whn) = 3
ORDER BY whn

-- QUESTION 2
-- The LAG function is used to show data from the preceding row or the table. 
-- When lining up rows the data is partitioned by country name and ordered by the data whn. 
-- That means that only data from Italy is considered.
-- Modify the query to show confirmed for the day before.

SELECT name, DAY(whn), confirmed,
   LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn

-- QUESTION 3
-- The number of confirmed case is cumulative - but we can use LAG to recover the number of new cases reported for each day.
-- Show the number of new cases for each day, for Italy, for March.

