use sakila;
-- 1 List the number of films per category.
select count(f.film_id)as numer_films,category_id
from film f
left join film_category fc 
on f.film_id = fc.film_id
group by category_id;

-- 2 Display the first and the last names, as well as the address, of each staff member.
select first_name, last_name, address
from staff s
left join address a on s.address_id = a.address_id;

-- 3 Display the total amount rung up by each staff member in August 2005.
SELECT first_name, last_name, SUM(amount)
FROM staff s
INNER JOIN payment p
ON s.staff_id = p.staff_id
GROUP BY p.staff_id;

-- 4 List all films and the number of actors who are listed for each film.
select f.film_id, count(actor_id) as number_actors
from film f
left join film_actor fa 
on f.film_id = fa.film_id
group by f.film_id;
-- 5 Using the payment and the customer tables as well as the JOIN command,
-- list the total amount paid by each customer. 
# List the customers alphabetically by their last names.
select first_name, last_name, sum(amount) 
from payment p
left join customer c 
on c.customer_id = p.customer_id
group by c.customer_id
order by last_name ASC;


