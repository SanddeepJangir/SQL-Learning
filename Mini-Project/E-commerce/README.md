# 🛒 E-Commerce SQL Practice Project

This project simulates a real-world **E-Commerce Database** designed to practice:

* Multiple table joins
* Aggregations with `GROUP BY`
* Complex queries
* View creation for sensitive data
* Interview-level SQL problems

The dataset contains 20 rows in each table to simulate realistic relational behavior.

---

# 📂 Database Structure

## 1️⃣ customers

Stores customer information.

| Column        | Type     | Description        |
| ------------- | -------- | ------------------ |
| customer_id   | INT (PK) | Unique customer ID |
| full_name     | VARCHAR  | Customer name      |
| email         | VARCHAR  | Customer email     |
| phone         | VARCHAR  | Contact number     |
| city          | VARCHAR  | Customer city      |
| password_hash | VARCHAR  | Encrypted password |

⚠ Sensitive column: `password_hash`

---

## 2️⃣ products

Stores product catalog.

| Column       | Type     | Description         |
| ------------ | -------- | ------------------- |
| product_id   | INT (PK) | Unique product ID   |
| product_name | VARCHAR  | Product name        |
| category     | VARCHAR  | Product category    |
| price        | DECIMAL  | Product price       |
| stock        | INT      | Available inventory |

---

## 3️⃣ orders

Stores customer order information.

| Column      | Type     | Description         |
| ----------- | -------- | ------------------- |
| order_id    | INT (PK) | Unique order ID     |
| customer_id | INT (FK) | Linked to customer_ |
