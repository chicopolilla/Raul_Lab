# Use sakila database.
use sakila;
#Selecct tables

SHOW TABLES;

SELECT * FROM sakila.actor, sakila.film,sakila.customer;

select * from sakila.film;

select name from sakila.language;
# Find out how many stores does the company have?

select * from sakila.store;
# they just have two stores

# 5.2 Find out how many employees staff does the company have?
select * from sakila.staff;
# they just have two employees

 # 5.3 Return a list of employee first names only?
 select first_name from sakila.staff;
 
 