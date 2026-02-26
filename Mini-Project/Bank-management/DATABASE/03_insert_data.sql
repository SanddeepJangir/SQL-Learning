-- 3️ Insert Sample Data

INSERT INTO customers VALUES
(1, 'Rahul Sharma', '123456789012', '9876543210', 'rahul@gmail.com', 'Jaipur'),
(2, 'Priya Verma', '987654321098', '9123456780', 'priya@gmail.com', 'Delhi'),
(3, 'Amit Singh', '456789123456', '9988776655', 'amit@gmail.com', 'Mumbai'),
(4, 'Neha Gupta', '789123456789', '9090909090', 'neha@gmail.com', 'Bangalore'),
(5, 'Sandeep Jangir', '654321987654', '8888888888', 'sandeep@gmail.com', 'Hingona');

INSERT INTO accounts VALUES
(101, 1, 'SB1000012345', 'Savings', 250000.00),
(102, 2, 'SB1000012346', 'Savings', 150000.00),
(103, 3, 'CR2000012347', 'Current', 500000.00),
(104, 4, 'SB1000012348', 'Savings', 75000.00),
(105, 5, 'CR2000012349', 'Current', 900000.00);

INSERT INTO transactions VALUES
(1001, 101, '2026-01-10', 5000.00, 'Debit'),
(1002, 101, '2026-01-15', 10000.00, 'Credit'),
(1003, 102, '2026-01-12', 2000.00, 'Debit'),
(1004, 103, '2026-01-18', 15000.00, 'Debit'),
(1005, 105, '2026-01-20', 25000.00, 'Credit');

INSERT INTO loans VALUES
(201, 1, 'Home Loan', 2500000.00, 'Approved'),
(202, 2, 'Car Loan', 800000.00, 'Pending'),
(203, 3, 'Business Loan', 5000000.00, 'Approved'),
(204, 5, 'Personal Loan', 300000.00, 'Rejected');
