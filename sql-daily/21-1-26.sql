create database managementevent;
-- Create table: events
use managementevent;
-- -------------------------
CREATE TABLE events (
  event_id   INT PRIMARY KEY,
  event_name VARCHAR(100) NOT NULL,
  city       VARCHAR(50)  NOT NULL
);

-- -------------------------
-- Create table: ticket_sales
-- -------------------------
CREATE TABLE ticket_sales (
  sale_id          INT PRIMARY KEY,
  event_id         INT NOT NULL,
  sale_date        DATE NOT NULL,
  ticket_type      VARCHAR(20) NOT NULL,
  qty              INT NOT NULL,
  price_per_ticket INT NOT NULL,
  CONSTRAINT fk_ticket_sales_event
    FOREIGN KEY (event_id) REFERENCES events(event_id)
);

-- -------------------------
-- Insert data: events
-- -------------------------
INSERT INTO events (event_id, event_name, city) VALUES
(1, 'Music Fest', 'Mumbai'),
(2, 'Tech Summit', 'Bengaluru'),
(3, 'Food Carnival', 'Delhi'),
(4, 'Startup Meetup', 'Mumbai');

-- -------------------------
-- Insert data: ticket_sales
-- -------------------------
INSERT INTO ticket_sales (sale_id, event_id, sale_date, ticket_type, qty, price_per_ticket) VALUES
(101, 1, '2025-01-05', 'Regular', 2, 1500),
(102, 1, '2025-01-10', 'VIP',     1, 5000),
(103, 2, '2025-02-03', 'Regular', 3, 2000),
(104, 2, '2025-02-10', 'VIP',     1, 6000),
(105, 3, '2025-03-01', 'Regular', 5,  800),
(106, 3, '2025-03-15', 'VIP',     2, 2500),
(107, 4, '2025-01-20', 'Regular', 4, 1200),
(108, 4, '2025-02-05', 'Regular', 1, 1200);

-- Quick check
SELECT * FROM events ORDER BY event_id;
SELECT * FROM ticket_sales ORDER BY sale_id;

-- 1 find total qty sold per event_id.
select event_id, sum(qty) from ticket_sales group by event_id;

-- 2 Find total revenue per event_id.
select event_id, sum(qty*price_per_ticket) from ticket_sales group by event_id;

-- 3 Find monthly total revenue(group by month of sale_date).
select month(sale_date), sum(qty*price_per_ticket) from ticket_sales group by month(sale_date);

-- 4 Find max price_per_ticket per event.
select event_id, max(price_per_ticket) from ticket_sales group by event_id;

-- 5 find total revenue per month and ticket_type.
select month(sale_date), ticket_type, sum(qty*price_per_ticket) from ticket_sales
 group by month(sale_date), ticket_type;

-- 6 List all sales with event_name and sale_date.
select sale_id, event_name,sale_date from events
join ticket_sales
on events.event_id = ticket_sales.event_id;


-- 7 show event_name,ticket_type, qty for each sale.
select e.event_name, t.ticket_type, t.qty from events as e
join ticket_sales as t 
on e.event_id = t.event_id;

-- 8 Show sales where the event_city is mumbai.
select sale_id, event_name, city, sale_date from events
join ticket_sales
on events.event_id = ticket_sales.event_id 
where city = 'Mumbai';

-- 9 Show all event and matching sales
select event_name, sale_id, sale_date from events
join ticket_sales 
on events.event_id = ticket_sales.event_id;

select * from events;
select * from ticket_sales;
-- 10 show distinct event names that have atleast one sale.
select distinct event_name from events
inner join ticket_sales
on events.event_id = ticket_sales.event_id;

-- 11 show each sale's computed revenue with event name.
select event_name, sale_id, qty*price_per_ticket as revenue from events
join ticket_sales 
on events.event_id = ticket_sales.event_id;

-- 12 find total qty per event_name.
select event_name,sum(qty) from events
join ticket_sales
on events.event_id = ticket_sales.event_id 
group by event_name;

-- 13 Find total VIP revenue per event_name
SELECT
  e.event_name,
  SUM(ts.qty * ts.price_per_ticket) AS vip_revenue
FROM events e
JOIN ticket_sales ts
  ON e.event_id = ts.event_id
WHERE ts.ticket_type = 'VIP'
GROUP BY e.event_name
ORDER BY vip_revenue;

-- 14.Monthly revenue per city
SELECT
  e.city,
  MONTH(ts.sale_date) AS sale_month,
  SUM(ts.qty * ts.price_per_ticket) AS total_revenue
FROM events e
JOIN ticket_sales ts
  ON e.event_id = ts.event_id
GROUP BY e.city, MONTH(ts.sale_date)
ORDER BY e.city, sale_month;

-- 15.Total quantity per city and ticket_type
SELECT
  e.city,
  ts.ticket_type,
  SUM(ts.qty) AS total_qty
FROM events e
JOIN ticket_sales ts
  ON e.event_id = ts.event_id
GROUP BY e.city, ts.ticket_type;

-- 16. Sales on the latest sale_date
SELECT *
FROM ticket_sales
WHERE sale_date = (SELECT MAX(sale_date) FROM ticket_sales);

-- 17. Sales where revenue > overall average sale revenue

SELECT
  sale_id,
  event_id,
  (qty * price_per_ticket) AS revenue
FROM ticket_sales
WHERE (qty * price_per_ticket) >
      (SELECT AVG(qty * price_per_ticket) FROM ticket_sales);

-- 18 Events that have at least one VIP sale

SELECT DISTINCT
  e.event_id,
  e.event_name
FROM events e
JOIN ticket_sales ts
  ON e.event_id = ts.event_id
WHERE ts.ticket_type = 'VIP';

-- 19. Events in cities that have at least one VIP sale (subquery + join)
-- This means: find cities where VIP happened, then list all events in those cities.

SELECT
  e.event_id,
  e.event_name,
  e.city
FROM events e
WHERE e.city IN (
  SELECT DISTINCT e2.city
  FROM events e2
  JOIN ticket_sales ts2
    ON e2.event_id = ts2.event_id
  WHERE ts2.ticket_type = 'VIP'
)
ORDER BY e.event_id;

-- 20.Events that have at least one sale in February 2025

SELECT DISTINCT
  e.event_id,
  e.event_name,
  e.city
FROM events e
JOIN ticket_sales ts
  ON e.event_id = ts.event_id
WHERE ts.sale_date >= '2025-02-01'
  AND ts.sale_date <  '2025-03-01'
ORDER BY e.event_id;

-- 21.For each event, return the highest price_per_ticket sale row
-- Option A (simple, but duplicates possible if tie)

SELECT ts.*
FROM ticket_sales ts
JOIN (
  SELECT event_id, MAX(price_per_ticket) AS max_price
  FROM ticket_sales
  GROUP BY event_id
) m
  ON ts.event_id = m.event_id
 AND ts.price_per_ticket = m.max_price
ORDER BY ts.event_id, ts.sale_id;

-- 22. Monthly total revenue + monthly total qty, only months with revenue ≥ 10000 

SELECT
  MONTH(sale_date) AS sale_month,
  SUM(qty) AS total_qty,
  SUM(qty * price_per_ticket) AS total_revenue
FROM ticket_sales
GROUP BY MONTH(sale_date)
HAVING SUM(qty * price_per_ticket) >= 10000
ORDER BY sale_month;

-- 23. Month-wise count of sales rows, only months with at least 3 sales rows

SELECT
  MONTH(sale_date) AS sale_month,
  COUNT(*) AS sales_rows
FROM ticket_sales
GROUP BY MONTH(sale_date)
HAVING COUNT(*) >= 3
ORDER BY sale_month;

-- 24.Avg revenue per sale row per month, only avg > 4000

SELECT
  MONTH(sale_date) AS sale_month,
  AVG(qty * price_per_ticket) AS avg_sale_revenue
FROM ticket_sales
GROUP BY MONTH(sale_date)
HAVING AVG(qty * price_per_ticket) > 4000
ORDER BY sale_month;

-- 25. Revenue per month + ticket_type, only groups with revenue ≥ 5000

SELECT
  MONTH(sale_date) AS sale_month,
  ticket_type,
  SUM(qty * price_per_ticket) AS total_revenue
FROM ticket_sales
GROUP BY MONTH(sale_date), ticket_type
HAVING SUM(qty * price_per_ticket) >= 5000
ORDER BY sale_month, ticket_type;
