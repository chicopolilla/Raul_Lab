use sakila;

-- 1 Get all pairs of actors that worked together.
select a1.film_id, a1.actor_id as actor1,a2.actor_id as actor2
from film_actor a1
join film_actor a2
on a1.film_id = a2.film_id
and a1.actor_id <> a2.actor_id;

-- 2 Get all pairs of customers that have rented the same film more than 3 times.
create  table sakila.inventory_retal
select i.inventory_id, film_id,store_id,rental_id,rental_date,customer_id, staff_id
from inventory i
left join rental r
on i.film_id = r.film_id;

# create  table sakila.inventory_retal_self_join
select a1.customer_id as customer1,  a2.customer_id as customer2, a1.film_id, a1.rental_id as rental1, a2.rental_id as rental2, a1.rental_date
from inventory_retal a1
join inventory_retal a2
on a1.film_id = a2.film_id
and a1.customer_id <> a2.customer_id;

select count(*) number_film_rented, customer1, customer2, film_id
from sakila.inventory_retal_self_join
group by customer1, customer2,film_id
having number_film_rented > 3
order by number_film_rented;

-- 3 Get all possible pairs of actors and films.
select a1.film_id,  a1.actor_id as actor1, a2.actor_id as actor2
from film_actor a1
left join film_actor a2
on a1.film_id = a2.film_id
and a1.actor_id <> a2.actor_id;

 