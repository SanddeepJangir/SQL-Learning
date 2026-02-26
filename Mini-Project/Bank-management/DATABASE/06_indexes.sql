-- Index on foreign keys (very important)
CREATE INDEX idx_accounts_customer_id 
ON accounts(customer_id);

CREATE INDEX idx_transactions_account_id 
ON transactions(account_id);

CREATE INDEX idx_loans_customer_id 
ON loans(customer_id);

-- Index on frequently searched columns
CREATE INDEX idx_accounts_account_type 
ON accounts(account_type);

CREATE INDEX idx_transactions_date 
ON transactions(transaction_date);

CREATE INDEX idx_loans_status 
ON loans(loan_status);
