-- recursive cte

select actor_id, first_name from sakila.actor where actor_id between 2 and 4
union 
select actor_id, first_name from sakila.actor where actor_id between 3 and 5;

select actor_id, first_name from sakila.actor where actor_id between 1 and 4
union all
select actor_id, first_name from sakila.actor where actor_id between 3 and 5;

with recursive cte as
(select 10 as num     -- assigning values to this num column
union all
select num+1 from cte   -- call of cte function
where num < 15   -- terminating condition (stop point)
)

select * from cte;

-- employee hierarchy 
use regex1;

CREATE TABLE employees2 (
    employeeid INT PRIMARY KEY,
    name VARCHAR(50),
    managerid INT
);

insert into employees2 (employeeid, name , managerid) values (1,'alice', NULL),
(2,'bob',1),
(3,'charlie', 2),
(4,'diana',2),
(5,'eve',3);

select * from employees2;

WITH RECURSIVE cte AS (SELECT employeeid, name,name AS hierarchy_path FROM employees2
    WHERE managerid IS NULL
    UNION ALL
    SELECT e.employeeid,e.name,concat(cte.hierarchy_path, ' -> ', e.name) AS hierarchy_path
    FROM employees2 e
    JOIN cte
        ON e.managerid = cte.employeeid
)
SELECT *
FROM cte;


with recursive cte as 
(select empoyeeid, name as hierarchy_path from employees2 where managerid is null
union all
select e.employeeid, e.name, concat(e.name,'->',cte.hierarchy_path) from employees2 as e
join cte where e.managerid = cte.employeeid and employeeid < 5
)

select * from cte;

WITH RECURSIVE cte AS (
    -- Anchor: top-level manager(s)
    SELECT
        employeeid,
        name,
        managerid,
        1 AS level
    FROM employees2
    WHERE managerid IS NULL

    UNION ALL

    -- Recursive: employees reporting to manager
    SELECT
        e.employeeid,
        e.name,
        e.managerid,
        cte.level + 1 AS level
    FROM employees2 e
    JOIN cte
        ON e.managerid = cte.employeeid
)
SELECT *
FROM cte
ORDER BY level, employeeid;
