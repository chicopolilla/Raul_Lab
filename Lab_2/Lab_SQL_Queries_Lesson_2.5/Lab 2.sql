use sakila;
# 1 Select all the actors with the first name ‘Scarlett’.
select * from actor
WHERE first_name = "Scarlett";
# 2 How many films (movies) are available for rent and how many films have been rented?
select * from rental
where rental_date >= return_date; # No hay rentas
# What are the shortest and longest movie duration?
# Name the values max_duration and min_duration.
select max(length) as max_duration,
		min(length) as min_duration
from film; 
# What's the average movie duration expressed in format (hours, minutes)?
# la fecha '2000-01-01' funcion como un 0 para time 
SELECT convert( date_add( '2000-01-01', interval AVG(length) minute) ,time) as average_movie_duration
	from film;
    
# 5 How many distinct (different) actors' last names are there?
select distinct  (last_name)
from actor; 
# 6 Since how many days has the company been operating (check DATEDIFF() function)?
select 
datediff(max(rental_date),min(rental_date))
from rental; 
# 7 Show rental info with additional columns month and weekday. Get 20 results.

SELECT *,
	   monthname(rental_date) as month,
       dayname(rental_date) as weekday 
FROM rental
limit 20;
# 8 Add an additional column day_type with values 'weekend' and 'workday' 
# depending on the rental day of the week.
SELECT 
	   monthname(rental_date) as month,
       CASE WHEN dayname(rental_date) IN ('Saturday', 'Sunday') THEN 'Weekend' 
       ELSE 'Weekday' END AS weekday
FROM rental
limit 20;

Alter table rental
add column day_type  varchar(15) after rental_date;
SET SQL_SAFE_UPDATES = 0; # To disable the safe mode
update rental
set day_type = case when dayname(rental_date) IN ('Saturday', 'Sunday') THEN 'Weekend' 
       ELSE 'workday' END;
# Check if the change was applied
SELECT * 
from rental;
# 9 How many rentals were in the last month of activity?
SELECT 
month(rental_date) as month1,
count(*) as rentals
FROM rental
group by month1
order by month1 DESC
limit 1;

