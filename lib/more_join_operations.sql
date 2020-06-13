-- QUESTION 1
-- List the films where the yr is 1962 [Show id, title]

SELECT id, title FROM movie WHERE yr = 1962

-- QUESTION 2
-- Give year of 'Citizen Kane'.

SELECT yr FROM movie WHERE title = 'Citizen Kane'

-- QUESTION 3
-- List all of the Star Trek movies, 
-- include the id, title and yr (all of these movies include the words Star Trek in the title). 
-- Order results by year.

SELECT id, title, yr FROM movie WHERE title LIKE '%Star Trek%'
ORDER BY yr

-- QUESTION 4
-- What id number does the actor 'Glenn Close' have?

SELECT id FROM actor WHERE name = 'Glenn Close'

-- QUESTION 5
-- What is the id of the film 'Casablanca'

SELECT id FROM movie WHERE title = 'Casablanca'

-- QUESTION 6
-- Obtain the cast list for 'Casablanca'.
-- what is a cast list?
-- The cast list is the names of the actors who were in the movie.
-- Use movieid=11768, (or whatever value you got from the previous question)

SELECT actor.name
FROM actor JOIN casting ON (actor.id=casting.actorid)
WHERE casting.movieid=11768

-- QUESTION 7
-- Obtain the cast list for the film 'Alien'

SELECT actor.name
FROM actor JOIN casting ON (actor.id=casting.actorid) JOIN movie ON (movie.id=casting.movieid)
WHERE title = 'Alien'

-- QUESTION 8
-- List the films in which 'Harrison Ford' has appeared

SELECT title 
FROM movie JOIN casting ON (casting.movieid = movie.id) JOIN actor ON (casting.actorid=actor.id)
WHERE name LIKE '%Harrison Ford%'

-- QUESTION 9
-- List the films where 'Harrison Ford' has appeared - but not in the starring role. 
-- [Note: the ord field of casting gives the position of the actor. 
-- If ord=1 then this actor is in the starring role]

SELECT title 
FROM movie JOIN casting ON (casting.movieid = movie.id) JOIN actor ON (casting.actorid=actor.id)
WHERE name LIKE '%Harrison Ford%' AND ord <> 1

-- QUESTION 10
-- List the films together with the leading star for all 1962 films.

SELECT title, actor.name 
FROM movie JOIN casting ON (casting.movieid = movie.id) JOIN actor ON (casting.actorid=actor.id)
WHERE ord = 1 AND yr = 1962

-- QUESTION 11
-- Which were the busiest years for 'Rock Hudson', 
-- show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr, COUNT(title) as no_of_movies FROM
    movie JOIN casting ON movie.id=movieid
          JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 1
ORDER BY COUNT(title) DESC
LIMIT 2

-- QUESTION 12
-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.
-- Did you get "Little Miss Marker twice"?

SELECT title, name 
FROM 
   movie  JOIN casting ON movie.id=movieid
          JOIN actor   ON actorid=actor.id
WHERE ord = 1 AND movieid IN ( SELECT movieid 
                               FROM casting JOIN actor
                               ON actorid = actor.id
                               WHERE name = 'Julie Andrews') 

-- QUESTION 13
-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles

SELECT name
FROM actor JOIN casting ON id = actorid AND ord = 1
GROUP BY name
HAVING COUNT(name) >= 15

-- QUESTION 14
-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

SELECT title, COUNT(casting.actorid) as no_of_actors
FROM movie JOIN casting ON (casting.movieid = movie.id) JOIN actor ON (casting.actorid=actor.id)
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(actorid)DESC, title

-- QUESTION 15
-- List all the people who have worked with 'Art Garfunkel'

SELECT name FROM actor JOIN casting ON actor.id = actorid JOIN movie ON movie.id = movieid WHERE movie.id IN (
SELECT movieid FROM casting 
WHERE actorid IN (SELECT id FROM actor WHERE name  = 'Art Garfunkel') 
) AND actor.name != 'Art Garfunkel'