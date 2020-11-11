USE sakila;


## 1.Select the first name, last name, and email address of all the customers who have rented a movie.
select * from rental;
select * from customer;

select count(distinct customer_id) from rental;

select distinct r.customer_id, c.first_name , c.last_name , c.email from rental r
join
customer c on r.customer_id = c.customer_id;


### 2.What is the average payment made by each customer (display the customer id,
###  customer name (concatenated), and the average payment made).

select * from customer;
select * from payment;

select p.customer_id , concat(c.first_name,c.last_name) as name , round(avg(p.amount),2) as Average from customer c
join
payment p on c.customer_id = p.customer_id
group by 1,2;

### 3.Select the name and email address of all the customers who have rented the "Action" movies.

### Write the query using multiple join statements

/*select * from customer;
select * from rental;
select * from film;
select * from inventory;
select * from film_category;
select * from category;*/

select concat(c.first_name,c.last_name) as Name , c.email from customer c 
join
rental r on c.customer_id = r.customer_id
join 
inventory i on r.inventory_id = i.inventory_id
join
film_category f on i.film_id = f.film_id
join
category ct on f.category_id = ct.category_id
where ct.name = 'Action'
group by 1, 2
order by 1;

### Write the query using sub queries with multiple WHERE clause and IN condition

select concat(first_name, ' ', last_name) as customer_name, email from sakila.customer
where customer_id in (select customer_id from sakila.rental
where inventory_id in (select i.inventory_id from sakila.film_category as fc
inner join sakila.inventory as i on fc.film_id = i.film_id
where category_id=1))
order by customer_name;


### 4.Use the case statement to create a new column classifying existing columns as either or high value transactions based 
### on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, 
### the label should be medium, and if it is more than 4, then it should be high.

select *,
case
	when amount <= 1.99 then 'low'
    when amount >= 2 and amount <= 3.99 then 'medium'
    when amount >= 4 then 'high'
end as value_based_on_amount
from sakila.payment;

