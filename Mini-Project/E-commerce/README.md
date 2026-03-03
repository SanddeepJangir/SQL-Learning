🛒 E-Commerce SQL Practice Project

This project simulates a real-world E-Commerce Database designed to practice:

Multiple table joins

Aggregations with GROUP BY

Complex queries

View creation for sensitive data

Interview-level SQL problems

The dataset contains 20 rows in each table to simulate realistic relational behavior.

📂 Database Structure
1️⃣ customers

Stores customer information.

Column	Type	Description
customer_id	INT (PK)	Unique customer ID
full_name	VARCHAR	Customer name
email	VARCHAR	Customer email
phone	VARCHAR	Contact number
city	VARCHAR	Customer city
password_hash	VARCHAR	Encrypted password

⚠ Sensitive column: password_hash

2️⃣ products

Stores product catalog.

Column	Type	Description
product_id	INT (PK)	Unique product ID
product_name	VARCHAR	Product name
category	VARCHAR	Product category
price	DECIMAL	Product price
stock	INT	Available inventory
3️⃣ orders

Stores customer order information.

Column	Type	Description
order_id	INT (PK)	Unique order ID
customer_id	INT (FK)	Linked to customers
order_date	DATE	Order date
status	VARCHAR	Order status

Relationship:

One customer → Many orders

4️⃣ order_items

Stores product-level details inside each order.

Column	Type	Description
order_item_id	INT (PK)	Unique item ID
order_id	INT (FK)	Linked to orders
product_id	INT (FK)	Linked to products
quantity	INT	Quantity ordered

Relationship:

One order → Many products

Many-to-many resolved using this table

5️⃣ payments

Stores payment transactions.

Column	Type	Description
payment_id	INT (PK)	Unique payment ID
order_id	INT (FK)	Linked to orders
amount	DECIMAL	Payment amount
payment_method	VARCHAR	Card / UPI / NetBanking
card_number	VARCHAR	Full card number

⚠ Sensitive column: card_number

🔐 Security Implementation (Views)

Sensitive information should never be exposed directly.

1️⃣ Secure Payment View

Masks card numbers

Shows only last 4 digits

Example output:

payment_id	order_id	amount	payment_method	masked_card
1	1	64000	Card	XXXX-XXXX-XXXX-1234
2️⃣ Public Customer View

Excludes:

password_hash

Example output:

customer_id	full_name	email	city
🔎 Practice Problems Included
1. Multi-table Join

Retrieve:

Customer name

Product name

Quantity

Total price per item

Tables involved:
customers → orders → order_items → products

2. Aggregation with GROUP BY

Calculate total order value per order.

Concepts tested:

JOIN

SUM()

GROUP BY

3. Top Customers by Spending

Find top 5 customers based on total spending.

Concepts tested:

Multi-table joins

Aggregation

ORDER BY DESC

LIMIT

4. LEFT JOIN (Missing Data Detection)

Find customers who never made a payment.

Concept tested:

LEFT JOIN

NULL filtering
