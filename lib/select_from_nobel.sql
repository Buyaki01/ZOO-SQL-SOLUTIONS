-- QUESTION 1
-- Change the query shown so that it displays Nobel prizes for 1950.

SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950

-- QUESTION 2
-- Show who won the 1962 prize for Literature.

SELECT winner
FROM nobel
WHERE yr = 1962
AND subject = 'Literature'

-- QUESTION 3
-- Show the year and subject that won 'Albert Einstein' his prize.

SELECT yr, subject FROM nobel WHERE winner = 'Albert Einstein'

-- QUESTION 4
-- Give the name of the 'Peace' winners since the year 2000, including 2000.

SELECT winner FROM nobel WHERE yr >= 2000 AND subject = 'peace'

-- QUESTION 5
-- Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.

SELECT yr, subject, winner FROM nobel WHERE subject = 'Literature' AND yr BETWEEN 1980 AND 1989

-- QUESTION 6
-- Show all details of the presidential winners:
-- Theodore Roosevelt
-- Woodrow Wilson
-- Jimmy Carter
-- Barack Obama

SELECT * FROM nobel WHERE winner = 'Theodore Roosevelt' OR winner = 'Woodrow Wilson' OR winner = 'Jimmy Carter' OR winner = 'Barack Obama'

-- QUESTION 7
-- Show the winners with first name John

SELECT winner FROM nobel WHERE winner LIKE 'John%'

-- QUESTION 8
-- Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.

SELECT yr, subject, winner FROM nobel WHERE (subject = 'Physics' AND yr = 1980 ) OR (subject = 'Chemistry' AND yr = 1984)

-- QUESTION 9
-- Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine

SELECT yr, subject, winner FROM nobel 
WHERE yr = 1980 AND subject NOT IN ('Chemistry' , 'Medicine')

-- QUESTION 10
-- Show year, subject, and name of people who won a 'Medicine' prize 
-- in an early year (before 1910, not including 1910) 
-- together with winners of a 'Literature' prize in a later year (after 2004, including 2004)

SELECT yr, subject, winner FROM nobel WHERE (subject='Medicine' AND yr < 1910) OR (subject='Literature' AND yr >= 2004)

-- QUESTION 11
-- Find all details of the prize won by PETER GRÜNBERG

SELECT * FROM nobel WHERE winner = 'PETER GRÜNBERG'

-- QUESTION 12
-- Find all details of the prize won by EUGENE O'NEILL

SELECT * FROM nobel WHERE winner = 'EUGENE O''NEILL'

-- QUESTION 13
-- List the winners, year and subject where the winner starts with Sir. 
-- Show the the most recent first, then by name order.

SELECT winner, yr, subject FROM nobel WHERE winner LIKE 'Sir%' ORDER BY yr DESC, winner

-- QUESTION 14
-- The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.
-- Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.

SELECT winner, subject FROM nobel WHERE yr = 1984 ORDER BY subject IN ('Chemistry','Physics'), subject, winner 