CREATE DATABASE Salaries;
USE Salaries;

-- Show all columns and rows in the table 

SELECT * FROM emp_salaries;

-- Rename Id column 

ALTER TABLE emp_salaries
RENAME COLUMN Id TO ID;

-- Check for duplicates

SELECT ID, COUNT(*) FROM emp_salaries
GROUP BY ID HAVING COUNT(*) >1;

-- Show only the EmployeeName and JobTitle columns

SELECT EmployeeName, JobTitle FROM emp_salaries;

-- Show the number of employees in the table 

SELECT COUNT(*) FROM emp_salaries;

-- Show the unique job titles in the table 

SELECT DISTINCT JobTitle FROM emp_salaries;

-- Show number of unique job titles

SELECT COUNT(DISTINCT JobTitle) AS Unique_Job_Titles 
FROM emp_salaries;

-- Show Average Salary by Job Title

SELECT JobTitle, ROUND(AVG(TotalPay), 2) AS AverageSalary
FROM emp_salaries
GROUP BY JobTitle
ORDER BY AverageSalary desc;

-- Count of FT vs. PT Employees

SELECT Status, COUNT(*) AS TotalEmployees
FROM emp_salaries
GROUP BY Status;

-- Compare Average Salaries of Full-Time vs. Part-Time Employees

SELECT Status, ROUND(AVG(TotalPay), 2) AS AvgSalary
FROM emp_salaries
GROUP BY Status;

-- Employees Who Are Paid Above the Average Salary

SELECT EmployeeName, JobTitle, TotalPay
FROM emp_salaries
WHERE TotalPay > (SELECT AVG(TotalPay) FROM emp_salaries)
ORDER BY TotalPay DESC;

-- Percentage of Employees in Each Job Category

SELECT JobTitle, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM emp_salaries)), 2) AS Percentage
FROM emp_salaries
GROUP BY JobTitle
ORDER BY Percentage DESC;

-- Show the job title and overtime pay for all employees with OT pay > 50000

SELECT DISTINCT JobTitle, OvertimePay 
FROM emp_salaries 
WHERE OvertimePay > 50000;

-- Show the average base pay for all employees

SELECT AVG(BasePay) FROM emp_salaries;
SELECT AVG(BasePay) as "Average Base Pay" FROM emp_salaries;

-- Show the top 10 highest paid employees

SELECT EmployeeName, TotalPay FROM emp_salaries
ORDER BY TotalPay desc limit 10;

-- Show the average of BasePay, OvertimePay, and OtherPay for each employee

SELECT EmployeeName, (BasePay + OvertimePay + OtherPay)/3 as avg_payments 
FROM emp_salaries;

-- Show all employees who have "Manager" in their job title 

SELECT EmployeeName, JobTitle FROM emp_salaries 
WHERE JobTitle LIKE '%Manager%';

-- Show all employees with a total pay between 50000 and 75000

SELECT * FROM emp_salaries 
WHERE TotalPay>=50000 and TotalPay<=75000;

-- Show all employees with a base pay less than 50000 or total pay greater than 100000

SELECT * FROM emp_salaries 
WHERE BasePay<50000 OR TotalPay>100000;

-- Show all employees with a total pay benefits value between 125000 and 150000 and a job title containing "Director"

SELECT * FROM emp_salaries 
WHERE TotalPayBenefits BETWEEN 125000 AND 150000 AND JobTitle LIKE '%Director%';

-- Show all employees ordered by their total pay benefits in desc order

SELECT * FROM emp_salaries 
ORDER BY TotalPayBenefits DESC;

-- Show all job titles with an average base pay of at least 100000 and order by avg base pay in desc order

SELECT JobTitle, AVG(BasePay) as "AVG BasePay" FROM emp_salaries 
GROUP BY JobTitle 
HAVING AVG(BasePay)>=100000
ORDER BY AVG(BasePay) DESC;

-- Update the base pay of all employees with job title containing "Manager" by 10% increase

UPDATE emp_salaries
SET BasePay = BasePay * 1.1
WHERE JobTitle LIKE '%Manager%';




