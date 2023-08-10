USE sakila;
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT * FROM sakila.film;
SELECT  MAX(length) AS max_duration, MIN(length) AS min_duration FROM sakila.film;
-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: look for floor and round functions.
SELECT AVG(length) DIV 60 AS average_duration_hours
FROM sakila.film;
SELECT ROUND(AVG(length) % 60) AS average_duration_minutes
FROM sakila.film;

-- 2.1 Calculate the number of days that the company has been operating. Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date))
FROM sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, MONTH(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_weekday
FROM sakila.rental
LIMIT 20;

-- 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. Hint: use a conditional expression.
SELECT *,
CASE WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
ELSE 'workday' END AS DAY_TYPE
FROM sakila.rental;

-- 3 We need to ensure that our customers can easily access information about our movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
-- Sort the results by the film title in ascending order. Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
SELECT title,
CASE WHEN rental_duration IS NULL THEN 'Not Available'
ELSE rental_duration
END AS rental_duration
FROM sakila.film
ORDER BY title ASC;


-- 4 As a marketing team for a movie rental company, we need to create a personalized email campaign for our customers. To achieve this, we want to retrieve the concatenated first and last names of our customers, 
-- along with the first 3 characters of their email address, so that we can address them by their first name and use their email address to send personalized recommendations.
--  The results should be ordered by last name in ascending order to make it easier for us to use the data.
SELECT CONCAT(first_name, ' ', last_name), LEFT(email, 3) 
FROM sakila.customer
ORDER BY last_name ASC;

--  ---------------------------------------------------------CHALLENGE 2------------------------------------------------------------------
--  1.1 The total number of films that have been released.
SELECT COUNT(film_id) 
FROM sakila.film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(*) 
FROM sakila.film
GROUP BY rating;


-- 1.3 The number of films for each rating, and sort the results in descending order of the number of films. This will help us better understand the popularity of different film ratings and adjust our purchasing decisions accordingly.
SELECT rating, COUNT(*) 
FROM sakila.film
GROUP BY rating
ORDER BY COUNT(*) DESC;
-- comment: I am not sure this is what you wanted, i understood that the number of films stands from the number of films in each rating, is that correct?
-- 2 We need to track the performance of our employees. Using the rental table, determine the number of rentals processed by each employee. This will help us identify our top-performing employees and areas where additional training may be necessary.
SELECT COUNT(*), staff_id
FROM sakila.rental
GROUP BY staff_id;
-- 3 Using the film table, determine: 3.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. 
-- This will help us identify popular movie lengths for each category.
SELECT ROUND(AVG(length),2), rating 
FROM sakila.film
GROUP BY rating
ORDER BY AVG(length) DESC;
-- 3.2 Identify which ratings have a mean duration of over two hours, to help us select films for customers who prefer longer movies.
SELECT AVG(length), rating 
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY AVG(length) DESC;

-- 4- Determine which last names are not repeated in the table actor.
SELECT last_name
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) = 1;

