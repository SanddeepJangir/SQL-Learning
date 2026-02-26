-- 4️ Create Secure Masked View

-- This hides Aadhaar and Account Number

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
