-- List each pair of actors that have worked together.

SELECT a1.first_name, a2.first_name AS actors
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
JOIN actor a1 ON fa1.actor_id = a1.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
WHERE fa1.actor_id <> fa2.actor_id
AND fa1.film_id IN (
  SELECT film_id FROM film_actor WHERE actor_id = fa1.actor_id
)
AND fa2.film_id IN (
  SELECT film_id FROM film_actor WHERE actor_id = fa2.actor_id
)
GROUP BY fa1.actor_id, fa2.actor_id
ORDER BY actors;

-- For each film, list actor that has acted in more films.
SELECT f.title, (
  SELECT a.first_name
  FROM actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
  WHERE fa.film_id = f.film_id
  GROUP BY a.actor_id
  ORDER BY COUNT(*) DESC, a.first_name
  LIMIT 1
) AS most_frequent_actor
FROM film f;
