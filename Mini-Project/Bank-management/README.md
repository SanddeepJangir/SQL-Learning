# 🏦 Bank Management System – SQL Database Project

## 📌 Project Overview

This project simulates a structured **Banking Database System** designed using strong relational database principles.

It demonstrates:

* Proper schema design
* Third Normal Form (3NF) normalization
* Foreign key relationships
* Index optimization
* Secure data masking using SQL Views
* Multi-table joins for analytics

This project reflects **production-level database thinking**, not basic academic CRUD practice.

---

# 🧱 Database Schema

## 📂 Tables Included

* `customers`
* `accounts`
* `transactions`
* `loans`

---

# 🔗 Entity Relationships

## Relationship Structure

```
Customers (1) ───── (M) Accounts  
Accounts  (1) ───── (M) Transactions  
Customers (1) ───── (M) Loans  
```

### Relationship Explanation

* One customer can have multiple accounts.
* One account can have multiple transactions.
* One customer can have multiple loans.
* Every foreign key enforces referential integrity.

---

# 🧩 Table Design Summary

## 1️⃣ customers

Stores personal customer information.

| Column         | Description                |
| -------------- | -------------------------- |
| customer_id    | Primary Key                |
| full_name      | Customer full name         |
| aadhaar_number | Government ID (Sensitive)  |
| phone          | Contact number (Sensitive) |
| email          | Email address              |
| city           | City location              |

---

## 2️⃣ accounts

Stores bank account details.

| Column         | Description                       |
| -------------- | --------------------------------- |
| account_id     | Primary Key                       |
| customer_id    | Foreign Key → customers           |
| account_number | Unique account number (Sensitive) |
| account_type   | Savings / Current                 |
| balance        | Account balance                   |

---

## 3️⃣ transactions

Stores debit/credit activities.

| Column           | Description            |
| ---------------- | ---------------------- |
| transaction_id   | Primary Key            |
| account_id       | Foreign Key → accounts |
| transaction_date | Date of transaction    |
| amount           | Transaction amount     |
| transaction_type | Debit / Credit         |

---

## 4️⃣ loans

Stores customer loan details.

| Column      | Description                   |
| ----------- | ----------------------------- |
| loan_id     | Primary Key                   |
| customer_id | Foreign Key → customers       |
| loan_type   | Home / Car / Business         |
| loan_amount | Approved loan amount          |
| loan_status | Approved / Pending / Rejected |

---

# 🧱 Normalization Strategy

This database follows **Third Normal Form (3NF)**.

---

## ✅ First Normal Form (1NF)

* Each table has a primary key.
* No repeating groups.
* All fields contain atomic values.

**Example:**

* Account numbers are not stored as comma-separated values.
* Each transaction is stored as a separate row.

---

## ✅ Second Normal Form (2NF)

* No partial dependency.
* All non-key columns depend fully on the primary key.

**Example:**

* Account balance depends only on `account_id`.
* Loan amount depends only on `loan_id`.

---

## ✅ Third Normal Form (3NF)

* No transitive dependency.
* No redundant storage of customer data inside account or loan tables.

**Example:**

* Customer city is stored only in `customers`.
* Loan data is not stored in `accounts`.
* Transaction data is not duplicated elsewhere.

### Benefits

* Prevents update anomalies
* Prevents delete anomalies
* Reduces redundancy
* Improves data consistency

---

# 🔐 Data Security Using SQL View

Sensitive data such as:

* Aadhaar number
* Phone number
* Account number

Are masked using a secure SQL view.

## Example View

```sql
CREATE VIEW secure_customer_view AS
SELECT 
    c.customer_id,
    c.full_name,
    CONCAT('XXXX-XXXX-', RIGHT(c.aadhaar_number,4)) AS masked_aadhaar,
    CONCAT('XXXXXX', RIGHT(c.phone,4)) AS masked_phone,
    c.city,
    a.account_id,
    CONCAT('XXXXXX', RIGHT(a.account_number,4)) AS masked_account_number,
    a.account_type,
    a.balance
FROM customers c
JOIN accounts a 
ON c.customer_id = a.customer_id;
```

This ensures raw sensitive data is not exposed to reporting users.

---

# 🚀 Indexing Strategy

Indexes are created on:

* Foreign key columns
* Frequently filtered columns
* Reporting columns

## Indexes Created

```sql
CREATE INDEX idx_accounts_customer_id ON accounts(customer_id);
CREATE INDEX idx_transactions_account_id ON transactions(account_id);
CREATE INDEX idx_loans_customer_id ON loans(customer_id);

CREATE INDEX idx_accounts_account_type ON accounts(account_type);
CREATE INDEX idx_transactions_date ON transactions(transaction_date);
CREATE INDEX idx_loans_status ON loans(loan_status);
```

## Why Indexing Matters

* Improves JOIN performance
* Optimizes WHERE filtering
* Reduces full table scans
* Scales better for large datasets

---

# 📊 Sample Analytical Query

Example joining secure view with transactions and loans:

```sql
SELECT 
    v.customer_id,
    v.full_name,
    v.masked_account_number,
    v.account_type,
    v.balance,
    t.transaction_date,
    t.amount,
    t.transaction_type,
    l.loan_type,
    l.loan_amount,
    l.loan_status
FROM secure_customer_view v
LEFT JOIN transactions t 
    ON v.account_id = t.account_id
LEFT JOIN loans l 
    ON v.customer_id = l.customer_id;
```

---

# 📂 Project Structure

```
bank-management-system/
│
├── database/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_insert_data.sql
│   ├── 04_views.sql
│   ├── 05_queries.sql
│   ├── 06_indexes.sql
│
└── README.md
```

---

# 🛠 Technologies Used

* MySQL
* SQL (DDL, DML, DQL)
* Index Optimization
* Relational Database Design

---

# 🎯 Key Learning Outcomes

* Designing normalized relational databases
* Enforcing referential integrity
* Implementing secure data masking
* Writing multi-table analytical joins
* Performance optimization using indexing

---

