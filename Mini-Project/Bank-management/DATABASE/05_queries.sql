-- 5️ Final Join Query (3 Tables + View)

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
