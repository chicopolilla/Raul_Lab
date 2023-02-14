use sakila;
-- How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT COUNT(*) as num_copies
FROM inventory inv
JOIN film f ON f.film_id = inv.film_id
WHERE f.title = 'Hunchback Impossible';
-- List all films whose length is longer than the average of all the films.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);
-- Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
  SELECT actor_id
  FROM film_actor
  WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Alone Trip'
  )
);
-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT title, name as category_name
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE name = 'Family';

-- Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
  SELECT address_id
  FROM address
  WHERE city_id IN (
    SELECT city_id
    FROM city
    WHERE country_id = (
      SELECT country_id
      FROM country
      WHERE country = 'Canada'
    )
  )
);
-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
SELECT title, COUNT(*) AS actor_movies
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.actor_id = (
  SELECT actor_id
  FROM (
    SELECT actor_id, COUNT(*) AS films
    FROM film_actor
    GROUP BY actor_id
    ORDER BY films DESC
    LIMIT 1
  ) AS actor_films
)
GROUP BY film.film_id
ORDER BY actor_movies DESC, title ASC;

-- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer is the customer that has made the largest sum of payments
SELECT f.title, COUNT(*) AS rentals, SUM(p.amount) AS revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
JOIN (
    SELECT c.customer_id, SUM(amount) AS total_payments
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
    ORDER BY total_payments DESC
    LIMIT 1
) AS most_profitable ON most_profitable.customer_id = r.customer_id
GROUP BY f.film_id
ORDER BY revenue DESC, f.title ASC;
-- Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.

SELECT c.customer_id AS client_id, SUM(p.amount) AS total_amount_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
WHERE p.amount > (SELECT AVG(amount) FROM payment)
GROUP BY c.customer_id
ORDER BY total_amount_spent DESC;
