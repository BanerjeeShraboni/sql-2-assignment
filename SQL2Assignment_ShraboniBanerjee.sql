-- BASIC AGGREGATE FUNCTIONS -–

-- Question 1: –-
-- Retrieve the total number of rentals made in the Sakila database. --
-- Answer of 1st: –
 SELECT  COUNT(*) AS total_rentals
 FROM rental;



-- Question 2: –-
-- Find the average rental duration (in days) of movies rented from the Sakila database.--
-- Answer of 2nd: –-
SELECT AVG(rental_duration)
FROM film;

-- STRING FUNCTIONS –-

-- Question 3: –-
--  Display the first name and last name of customers in uppercase. –-
-- Answer of 3rd: –-
 SELECT UPPER(first_name) , UPPER(last_name) 
FROM customer;


-- Question 4: –-
-- Extract the month from the rental date and display it alongside the rental ID. –- 
-- Answer of 4th: –-
SELECT rental_id, MONTH(rental_date) 
FROM rental;


-- Question 5: –-
-- Retrieve the count of rentals for each customer (display customer ID and the count of rentals). –-
-- Answer of 5th: –-
SELECT customer_id, COUNT(rental_id) AS rental_count
FROM rental
GROUP BY customer_id;



-- Question 6: –-
-- Find the total revenue generated by each store. –-
-- Answer of 6th: –
SELECT s.store , SUM(sales.amount)    AS total_revenue FROM stores s 
JOIN sales ON s.store_id = sales.store_id GROUP BY s.store_id, s.store;


-- Question 7: –-
-- Display the title of the movie, customers first name, and last name who rented it. --
-- Answer of 7th: –-
SELECT  * FROM film ; -- film_id , title 
SELECT  * FROM inventory ; -- film_id 
SELECT  * FROM rental ; -- customer id , inventory id , rental id 
SELECT  * FROM customer ; -- first name , last name , customer id .
 
SELECT film.title, customer.first_name, customer.last_name
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN customer ON rental.customer_id = customer.customer_id;



-- Question 8: –-
-- Retrieve the names of all actors who have appeared in the film "Gone with the Wind." –-
-- Answer of 8th: –- 
SELECT actor.first_name, actor.last_name
FROM actor
inner JOIN film_actor ON actor.actor_id = film_actor.actor_id
inner JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'Some Movie';





-- GROUP BY QUESTIONS –-

-- Question 1: –-
-- Determine the total number of rentals for each category of movies.  –-
-- Answer of 1st: –-
SELECT * FROM film ;
SELECT * FROM film_category ; 
SELECT * FROM inventory ;

SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id;

-- Question 2: –-
-- Find the average rental rate of movies in each language. -- 
-- Answer of 2nd: –-
SELECT l.name AS language_name, AVG(f.rental_rate) AS average_rental_rate
FROM language l
JOIN film f ON l.language_id = f.language_id
GROUP BY l.language_id;

-- JOINS –-

-- Question 3: –-
-- Retrieve the customer names along with the total amount they've spent on rentals. --
-- Answer of 3rd: –-
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_amount_spent_on_rental
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;


-- Question 4: –-
-- List the titles of movies rented by each customer in a particular city (e.g., 'London'). –-
-- Answer of 4th: –-
SELECT * from city ;

SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ct ON a.city_id = ct.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ct.city = ' london'
ORDER BY c.last_name, c.first_name, f.title;

--  ADVANCED JOINS and GROUP BY –-

-- Question 5: –-
 -- Display the top 5 rented movies along with the number of times they've been rented. –-
-- Answer of 5th: –-
SELECT f.title AS movie_title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY rental_count DESC
LIMIT 5 ;



-- Question 6: –-
-- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2). –-
-- Answer of 6th: –-
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
WHERE s.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT s.store_id) = 2;



