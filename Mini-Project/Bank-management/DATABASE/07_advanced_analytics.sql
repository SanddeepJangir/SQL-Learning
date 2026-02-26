-- 1. Customer Total Balance Across All Accounts
-- Which customers hold the highest total deposits?
select c.customer_id,c.full_name,SUM(a.balance) as total_balance,
RANK() over (order by SUM(a.balance) desc) as balance_rank from customers c
join accounts a 
on c.customer_id = a.customer_id
group by c.customer_id, c.full_name;


