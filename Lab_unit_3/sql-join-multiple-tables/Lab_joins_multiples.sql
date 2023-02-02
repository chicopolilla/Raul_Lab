use sakila;
-- 1 Write a query to display for each store its store ID, city, and country.
select store_id,city,country
from store s 
left join address a
on s.address_id = a.address_id
left join city c
on a.city_id = c.city_id
left join country cy
on c.country_id = cy.country_id;

-- 2 Write a query to display how much business, in dollars, each store brought in.

select s.store_id, sum(amount)as dollars
from store s 
left join inventory i
on s.store_id = i.store_id
left join rental r
on i.inventory_id = r.inventory_id
left join payment a
on r.rental_id = a.rental_id
group by s.store_id;


-- 3 What is the average running time of films by category?
select title, avg(length) as film_for_category
from film f 
left join film_category fc
on f.film_id = fc.film_id
group by fc.category_id, f.film_id;
-- 4 Which film categories are longest?
select title, avg(length) as film_for_category
from film f 
left join film_category fc
on f.film_id = fc.film_id
group by fc.category_id, f.film_id
order by film_for_category DESC
limit 1;
-- 5 isplay the most frequently rented movies in descending order.

select f.film_id,count(rental_id) as freq_rent
from film f 
left join inventory i
on f.film_id = i.film_id
left join rental r
on i.inventory_id = r.inventory_id
group by f.film_id
order by freq_rent DESC ;

-- 6 List the top five genres in gross revenue in descending order.
create temporary table sakila.Revenue_films
select f.film_id, sum(amount)as dollars
from film f 
left join inventory i
on f.film_id = i.film_id
left join rental r
on i.inventory_id = r.inventory_id
left join payment a
on r.rental_id = a.rental_id
group by f.film_id;

select sum(dollars) ,category_id
from film f
left join Revenue_films rf
on f.film_id = rf.film_id
left join film_category fc
on f.film_id = fc.film_id
group by fc.category_id 
order by rf.sum(dollars)
limit 5;
select sum(dollars) ,category_id
from Revenue_films rf
left join film f
on f.film_id = rf.film_id
left join film_category fc
on f.film_id = fc.film_id
group by fc.category_id 
order by sum(dollars)
limit 5;

-- 7 Is "Academy Dinosaur" available for rent from Store 1?
 SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

create temporary table sakila.films_store_title
select i.inventory_id, r.rental_id, r.rental_date, r.return_date, f.title
from film f 
left join inventory i
on f.film_id = i.film_id
left join rental r
on i.inventory_id = r.inventory_id
left join store s
on i.store_id = s.store_id;
#group by i.inventory_id ;

-- create temporary table sakila.films_store_MAX3
select *
from ( select *, rank() over (partition by  inventory_id order by rental_date DESC) last_dates
 from sakila.films_store_title) as table_1
where table_1.last_dates = 1;

select *
from sakila.films_store_MAX3

where return_date > rental_date and title = 'Academy Dinosaur' ;
# Existen 7 peliculas disponibles para rentar llamadas "Academy Dinosaur".
