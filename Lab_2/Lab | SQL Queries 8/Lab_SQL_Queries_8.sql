-- 1 Rank films by length (filter out the rows with nulls or zeros in length column).
-- Select only columns title, length and rank in your output.
use sakila;
select  title, length, rank()
over ( order by length )
from film
where length is not null;

-- Rank films by length within the rating category 
-- (filter out the rows with nulls or zeros in length column).
-- In your output, only select the columns title, length, rating and rank.
select  title, length, category_id , rank()
over ( partition by category_id order by length )
from film f
left join film_category fc on f.film_id = fc.film_id
where length is not null;

-- Which actor has appeared in the most films? Hint: You can create a join between 
-- the tables "actor" and "film actor" and count the number of times an actor appears.
select * from film_actor;

select count(film_id) 
from film_actor fa
left join actor a on fa.actor_id = a.actor_id
group by a.actor_id
order by count(film_id) DESC
limit 1;


-- Bonus Which is the most rented film? 
 select count(rental_id), title
 from film f
 left join inventory i on f.film_id = i.film_id
 left join rental r on r.inventory_id = i.inventory_id
 group by f.film_id
 order by count(rental_id) DESC
 limit 1 ;

