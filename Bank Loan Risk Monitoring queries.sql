1. How many loan applications have been received in total?
SELECT COUNT(id) AS Total_Applications
FROM financial_loan;

2. How many loan applications were received during the current month (December)?
SELECT COUNT(id) AS Total_Applications
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 12;

3. How many loan applications were received during the previous month (November)?
SELECT COUNT(id) AS Total_Applications
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 11;

4. What is the total amount funded through loans?
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM financial_loan;

5. What is the total loan amount funded during the current month?
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 12;

6. What is the total loan amount funded during the previous month?
SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 11;

7. What is the total amount received from borrowers?
SELECT SUM(total_payment) AS Total_Amount_Collected
FROM financial_loan;

8. How much payment has been received during the current month?
SELECT SUM(total_payment) AS Total_Amount_Collected
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 12;

9. How much payment was received during the previous month?
SELECT SUM(total_payment) AS Total_Amount_Collected
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 11;

10. What is the average interest rate across all loans?
SELECT AVG(int_rate) * 100 AS Avg_Int_Rate
FROM financial_loan;

11. What is the average interest rate for loans issued during the current month?
SELECT AVG(int_rate) * 100 AS MTD_Avg_Int_Rate
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 12;

12. What was the average interest rate for loans issued during the previous month?
SELECT AVG(int_rate) * 100 AS PMTD_Avg_Int_Rate
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 11;

13. What is the average Debt-to-Income (DTI) ratio of borrowers?
SELECT AVG(dti) * 100 AS Avg_DTI
FROM financial_loan;

14. What is the average DTI ratio for loans issued during the current month?
SELECT AVG(dti) * 100 AS MTD_Avg_DTI
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 12;

15. What was the average DTI ratio for loans issued during the previous month?
SELECT AVG(dti) * 100 AS PMTD_Avg_DTI
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 11;

GOOD LOAN ANALYSIS

16. What percentage of loans are classified as good loans?
SELECT
    (COUNT(CASE
              WHEN loan_status IN ('Fully Paid', 'Current')
              THEN id
           END) * 100.0) / COUNT(id) AS Good_Loan_Percentage
FROM financial_loan;

17. How many loan applications are classified as good loans?
SELECT COUNT(id) AS Good_Loan_Applications
FROM financial_loan
WHERE loan_status IN ('Fully Paid', 'Current');

18. What is the total funded amount associated with good loans?
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM financial_loan
WHERE loan_status IN ('Fully Paid', 'Current');

19. What is the total amount received from good loans?
SELECT SUM(total_payment) AS Good_Loan_Amount_Received
FROM financial_loan
WHERE loan_status IN ('Fully Paid', 'Current');

BAD LOAN ANALYSIS

20. What percentage of loans are classified as bad loans?
SELECT
    ROUND(
        SUM(CASE
                WHEN loan_status = 'Charged Off'
                THEN 1
                ELSE 0
            END) * 100 / COUNT(*),
        2
    ) AS Bad_Loan_Percentage
FROM financial_loan;

21. How many loan applications are classified as bad loans?
SELECT COUNT(id) AS Bad_Loan_Applications
FROM financial_loan
WHERE loan_status = 'Charged Off';

22. What is the total funded amount associated with bad loans?
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM financial_loan
WHERE loan_status = 'Charged Off';

23. What is the total amount received from bad loans?
SELECT SUM(total_payment) AS Bad_Loan_Amount_Received
FROM financial_loan
WHERE loan_status = 'Charged Off';

LOAN STATUS ANALYSIS

24. How do loan applications, funded amounts, payments received, interest rates, and DTI vary across different loan statuses?
SELECT
    loan_status,
    COUNT(id) AS LoanCount,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    ROUND(AVG(int_rate) * 100, 2) AS Interest_Rate,
    ROUND(AVG(dti) * 100, 2) AS DTI
FROM financial_loan
GROUP BY loan_status;

25. How do funded amounts and received payments vary by loan status during the current month?
SELECT
    loan_status,
    SUM(total_payment) AS MTD_Total_Amount_Received,
    SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM financial_loan
WHERE EXTRACT(MONTH FROM issue_date) = 12
GROUP BY loan_status;

OVERVIEW ANALYSIS

26. How do loan applications, funded amounts, and received payments trend across different months?
SELECT
    TO_CHAR(issue_date, 'YYYY-MM') AS Month_Year,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY TO_CHAR(issue_date, 'YYYY-MM')
ORDER BY TO_CHAR(issue_date, 'YYYY-MM');

27. How are loan applications, funded amounts, and received payments distributed across states?
SELECT
    address_state AS State,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY address_state
ORDER BY address_state;

28. How do loan applications, funded amounts, and payments received vary by loan term?
SELECT
    term AS Term,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY term
ORDER BY term;

29. How does borrower employment length impact loan applications, funded amounts, and payments received?
SELECT
    emp_length AS Employee_Length,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length;

30. How are loans distributed across different loan purposes, and what are their funding and repayment trends?
SELECT
    purpose AS Purpose,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY purpose
ORDER BY purpose;

31.How do loan applications, funded amounts, and payments received vary across different home ownership categories?
SELECT
    home_ownership AS Home_Ownership,
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY home_ownership
ORDER BY home_ownership;