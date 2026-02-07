create database drivers;
-- 22nd January - Driver file for practice
use drivers;
CREATE TABLE drivers (
  driver_id   INT PRIMARY KEY,
  driver_name VARCHAR(50) NOT NULL,
  base_area   VARCHAR(50) NOT NULL
);

-- -------------------------
-- Create table: trips  (DATE column included)
-- -------------------------
CREATE TABLE trips (
  trip_id      INT PRIMARY KEY,
  driver_id    INT NOT NULL,
  trip_date    DATE NOT NULL,
  distance_km  DECIMAL(5,1) NOT NULL,
  fare         INT NOT NULL,
  rating       DECIMAL(3,1) NOT NULL,
  CONSTRAINT fk_trips_driver
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

-- -------------------------
-- Insert data: drivers (4 rows)
-- -------------------------
INSERT INTO drivers (driver_id, driver_name, base_area) VALUES
(1, 'Asha',  'Indiranagar'),
(2, 'Ravi',  'Koramangala'),
(3, 'Meera', 'Whitefield'),
(4, 'Kabir', 'HSR Layout');

-- -------------------------
-- Insert data: trips (10 rows)
-- -------------------------
INSERT INTO trips (trip_id, driver_id, trip_date, distance_km, fare, rating) VALUES
(101, 1, '2025-11-01', 12.0, 350, 4.8),
(102, 1, '2025-11-02',  5.5, 180, 4.6),
(103, 2, '2025-11-01',  8.0, 260, 4.9),
(104, 2, '2025-11-03', 15.0, 500, 4.7),
(105, 3, '2025-11-02',  3.0, 120, 4.2),
(106, 3, '2025-11-04', 22.0, 780, 4.9),
(107, 4, '2025-11-01',  6.0, 210, 4.5),
(108, 4, '2025-11-03',  9.0, 300, 4.4),
(109, 4, '2025-11-04',  4.0, 150, 4.8),
(110, 1, '2025-11-04', 18.0, 620, 4.9);

-- Quick check
SELECT * FROM drivers ORDER BY driver_id;
SELECT * FROM trips ORDER BY trip_id;

-- 1.Question: For each trip_date, show number of trips, total fare, and average rating.
SELECT
    trip_date,
    COUNT(*) AS total_trips,
    SUM(fare) AS total_fare,
    AVG(rating) AS avg_rating
FROM trips
GROUP BY trip_date
ORDER BY trip_date;

-- 2.Question: By base_area, show total trips, total fare, and average distance.

select d.base_area, count(*) as total_trips, sum(fare), avg(distance_km) from drivers as d 
join trips 
on d.driver_id = trips.driver_id
group by d.base_area
order by total_trips desc;

-- 3. Rating buckets count (>=4.8 as “High”, else “Other”)
select 
CASE 
    WHEN rating >= 4.8 THEN 'High'
    ELSE 'Other'
  END AS rating_bucket,
  COUNT(*) AS trips
FROM trips
group by rating_bucket;

-- 4. Days where total fare >= 800 (GROUP BY + HAVING)

select trip_date,sum(fare) as total_fare from trips
group by trip_date
having total_fare >= 800;

-- 5. Base-area average rating, only areas with avg rating >= 4.7 (HAVING)

select d.base_area, avg(t.rating) from drivers as d 
join trips as t
on d.driver_id = t.driver_id
group by d.base_area
having avg(rating)>4.7;

-- 6.Trips with fare greater than the overall average fare (single-row subquery)
select trip_id,driver_id,fare from trips;

-- 7.Drivers who have at least one trip rated 4.9 (multi-row IN subquery)
-- driver_id driver_name
-- 1        Asha
-- 2        Ravi
-- 3        Meera
select driver_id,driver_name from drivers
where driver_id in (select driver_id from trips where rating= 4.9);
-- Drivers whose total fare is greater than the average total fare per driver
-- Hint: (subquery on aggregated derived table) Hard level

SELECT d.driver_id, d.driver_name, t.total_fare
FROM drivers d
JOIN (
    SELECT driver_id, SUM(fare) AS total_fare
    FROM trips
    GROUP BY driver_id
) t ON d.driver_id = t.driver_id
WHERE t.total_fare > (
    SELECT AVG(total_fare)
    FROM (
        SELECT driver_id, SUM(fare) AS total_fare
        FROM trips
        GROUP BY driver_id
    ) x
);

-- Latest trip per driver

SELECT driver_id, trip_id, trip_date, fare
FROM (
    SELECT
        driver_id,
        trip_id,
        trip_date,
        fare,
        ROW_NUMBER() OVER (PARTITION BY driver_id ORDER BY trip_date DESC, trip_id DESC) AS rn
    FROM trips
) x
WHERE rn = 1
ORDER BY driver_id;

-- Row number of trips per driver ordered by date (then trip_id) with output
SELECT
  driver_id,
  trip_id,
  trip_date,
  fare,
  ROW_NUMBER() OVER (
    PARTITION BY driver_id
    ORDER BY trip_date, trip_id
  ) AS rn
FROM trips
ORDER BY driver_id, trip_date, trip_id;

-- Running total fare per driver over time driver_id trip_id trip_date fare running_fare

SELECT
  driver_id,
  trip_id,
  trip_date,
  fare,
  SUM(fare) OVER (
    PARTITION BY driver_id
    ORDER BY trip_date, trip_id
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS running_fare
FROM trips
ORDER BY driver_id, trip_date, trip_id;

-- Rank trips by fare within each driver (highest fare rank 1) with output

SELECT
  driver_id,
  trip_id,
  trip_date,
  fare,
  RANK() OVER (
    PARTITION BY driver_id
    ORDER BY fare DESC
  ) AS fare_rank
FROM trips
ORDER BY driver_id, fare_rank, trip_id;

-- Show each trip’s fare minus the driver’s average fare (window AVG)

SELECT
  driver_id,
  trip_id,
  trip_date,
  fare,
  ROUND(AVG(fare) OVER (PARTITION BY driver_id), 2) AS avg_fare_per_driver,
  ROUND(fare - AVG(fare) OVER (PARTITION BY driver_id), 2) AS fare_minus_avg
FROM trips
ORDER BY driver_id, trip_date, trip_id;


-- For each driver, show the previous trip’s fare (LAG) ordered by date

SELECT
  driver_id,
  trip_id,
  trip_date,
  fare,
  LAG(fare) OVER (
    PARTITION BY driver_id
    ORDER BY trip_date, trip_id
  ) AS prev_fare
FROM trips
ORDER BY driver_id, trip_date, trip_id;



