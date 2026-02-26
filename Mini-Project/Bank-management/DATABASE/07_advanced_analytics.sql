-- 1. Customer Total Balance Across All Accounts
-- Q.1 Which customers hold the highest total deposits?
select c.customer_id,c.full_name,SUM(a.balance) as total_balance,
RANK() over (order by SUM(a.balance) desc) as balance_rank from customers c
join accounts a 
on c.customer_id = a.customer_id
group by c.customer_id, c.full_name;


HERE use 
Aggregation
Window function
Ranking

-- 2. Running Balance Per Account (Window Function)
-- Q.2 Track transaction movement chronologically.
SELECT 
    account_id,
    transaction_date,
    amount,
    transaction_type,
    SUM(
        CASE 
            WHEN transaction_type = 'Credit' THEN amount 
            ELSE -amount # debit condition
        END
    ) OVER (
        PARTITION BY account_id 
        ORDER BY transaction_date
    ) AS running_balance
FROM transactions;

-- 3. Monthly Transaction Summary

SELECT 
    account_id,
    DATE_FORMAT(transaction_date, '%Y-%m-%d') AS month,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY account_id, month;

