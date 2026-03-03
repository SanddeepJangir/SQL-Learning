-- Q1: Get customer name, product name, quantity, and total amount per item.

select 
c.full_name as customer_name,
p.product_name as product_name, 
oi.quantity as quantity,
(p.price * oi.quantity) as total_price
from customers as c 
join products as p 
join order_items as oi
join orders as o
On c.customer_id = o.customer_id
and o.order_id = oi.order_id 
and oi.product_id = p.product_id;


-- Find total order value per order.

select 
o.order_id,
c.full_name as Customer_name,
sum(p.price*oi.quantity) as total_order_value
from customers as c
Inner join orders as o
Inner Join products as p
Inner join order_items as oi
on o.order_id = c.customer_id
and oi.product_id = p.product_id
and o.order_id = oi.order_id
group by c.full_name,o.order_id;

-- Q3: Get top 5 customers by total spending.
select 
c.customer_id,
c.full_name as customer_name, 
sum(p.price * oi.quantity) as total_spent
from customers as c
Inner join orders as o
Inner Join products as p
Inner join order_items as oi
on o.order_id = c.customer_id
and oi.product_id = p.product_id
and o.order_id = oi.order_id
group by c.full_name,c.customer_id
order by sum(p.price * oi.quantity) desc
limit 5;

-- Q4: Find all customers who never made a payment.

select c.customer_id,c.full_name from customers as c left join orders as o
on c.customer_id = o.customer_id
left join payments as p
on o.order_id = p.order_id
where p.payment_id is null;


show tables;
select * from customers;
select * from order_items;
select * from products;
select * from orders;
select * from payments;
