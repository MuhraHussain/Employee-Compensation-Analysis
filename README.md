# Employee Compensation Analysis
Employee Compensation Insights: Data Cleaning, Preparation, and Analysis Using Excel and SQL

## Table of Contents
- [Project Overview](#project-overview)
- [Data Sources](#data-sources)
- [Tools](#tools)
- [Data Cleaning and Preparation](#data-cleaning-and-preparation)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Data Analysis](#data-analysis)
- [Results and Findings](#results-and-findings)
- [Recommendations](#recommendations)
- [Key Focus Areas for Improvement](#key-focus-areas-for-improvement)


### Project Overview

This project focuses on analyzing employee compensation data to uncover insights about salaries, benefits, and job roles. The process began with data cleaning and preparation in Excel to address formatting issues and ensure consistency. SQL was then used to perform in-depth analysis, including calculating average salaries, comparing compensation across job titles, identifying top earners, and more. The project demonstrates skills in data preprocessing, querying, and deriving actionable insights from structured data.


### Data Sources

Employee Data: The dataset used for this analysis is the "Salaries.csv" file, containing information about the employees, their job titles, compensation details, etc. The "SF Salaries" dataset was found on Kaggle. The cleaned file is "Salaries_cleaned_final.csv".


### Tools

- Excel (Data cleaning and preparation)
- SQL (Data analysis)


### Data Cleaning and Preparation

This step was performed in Excel, with summarized steps taken below:

- Removed empty "Notes" column
- Find and Replace [ ] with "NULL", "Not Provided" with "NULL"
- Standardized the data using CLEAN(TRIM(UPPER(A1)))
- IF (A1 = "NULL", 0, VALUE(TRIM(A1))) on "Benefits" column because of NULL values
- Removed duplicates
- The formula below was used for removing commas before job titles that came in brackets, while leaving them present following job titles that do not contain brackets. (e.g: CAPTAIN, FIRE SUPPRESSION keeps the comma, while BATTALION CHIEF, (FIRE DEPARTMENT) gets the comma removed and is now BATTALION CHIEF (FIRE DEPARTMENT).
- IF(IFERROR(FIND(",", A2), 0), IF (MID(A2, FIND (",", A2) + 2, 1) = "("SUBSTITUTE(A2, ",", ""), A2), A2)


### Exploratory Data Analysis

  **Inspection:**
  
  - Reviewed the dataset structure, including column names, data types, and missing values.
  - Noted key columns like BasePay, OvertimePay, TotalPay, and JobTitle for analysis.
  - Inspected column-level data for anomalies or patterns.
  - Identified outliers in salary-related fields for further investigation.

  **Key Observations:**

  - Found discrepancies in overtime pay, with many employees having 0 values.
  - Observed a wide range of salaries across job titles.
  - Noted a few job categories with consistently higher base pay.


### Data Analysis

**Step 1: Database Creation**

The first step in any SQL-based data analysis project is to set up a database to store and organize your data. In this case, I created a database called Salaries and selected it for use.

```sql
CREATE DATABASE Salaries;
USE Salaries;
```


**Step 2: Import Cleaned Dataset**

Imported the dataset using the import wizard into a newly created table [emp_salaries]


**Step 3: Queries**

**Display All Data**

This query retrieves all rows and columns from the emp_salaries table, providing a complete view of the dataset. It helps in understanding the structure of the table and the data it contains.

```sql
SELECT * FROM emp_salaries;
```

Output:

![select_all_from_table_x](https://github.com/user-attachments/assets/e6f27069-6fc5-40f1-9013-384a82f9d34e)


**Renaming Column** 

This query is used to rename the Id column to ID for better readability.

```sql
ALTER TABLE emp_salaries
RENAME COLUMN Id to ID;
```


**Identifying Duplicate Records**

This query is used to check for duplicate entries in the emp_salaries table based on the ID column. It ensures data integrity by highlighting any instances where the same ID appears more than once.

```sql
SELECT ID, COUNT(*) FROM emp_salaries
GROUP BY Id HAVING COUNT(*) >1;
```

Output:

![duplicate_check_ID_x](https://github.com/user-attachments/assets/3995984c-0a9a-439d-918d-9525e1e1536b)


**Display Employee Names and Their Job Titles**

```sql
SELECT EmployeeName, JobTitle 
FROM emp_salaries;
```

Output:

![emp_name_jobtitle_x](https://github.com/user-attachments/assets/3401c030-cd02-4527-904f-c6b00a4e5562)


**Total Number of Employees**

This query counts the total number of rows in the emp_salaries table, assuming each row corresponds to one employee.

```sql
SELECT COUNT(*) AS Total_Employees FROM emp_salaries;
```

Output:

![emp_num_count_x](https://github.com/user-attachments/assets/005e8229-306e-45d1-bddc-57753b6fe280)


**Unique Job Titles**

This query retrieves all the unique job titles from the emp_salaries table, ensuring that no duplicates are included in the result.

```sql
SELECT DISTINCT JobTitle 
FROM emp_salaries;
```

Output:

![jobtitle_unique_x](https://github.com/user-attachments/assets/4ff570b2-25da-405b-ac7e-985070d6d95c)


This would return the total count of unique job titles.

```sql
SELECT COUNT(DISTINCT JobTitle) AS Unique_Job_Titles 
FROM emp_salaries;
```

Output:

![jobtitle_unique_count_x](https://github.com/user-attachments/assets/801b6df8-7919-42b8-893e-f86adafc60ec)


**Show Average Salary by Job Title**

This query calculates the average salary for each job title in the dataset and orders the results from the highest to the lowest average salary. It helps to identify which positions are the highest paying and can be used for compensation analysis.

```sql
SELECT JobTitle, ROUND(AVG(TotalPay), 2) AS AverageSalary
FROM emp_salaries
GROUP BY JobTitle
ORDER BY AverageSalary DESC;
```

Output:

![avg_salary_jobtitle_x](https://github.com/user-attachments/assets/277efbb7-b8f8-401b-a913-e6fcbfeab28e)


**Count of FT vs. PT Employees**

The query groups employees by their work status (FT or PT) and counts the total number of employees in each category. This information helps organizations analyze their workforce composition and adjust staffing strategies if needed.

```sql
SELECT Status, COUNT(*) AS TotalEmployees
FROM emp_salaries
GROUP BY Status;
```

Output:

![FT_PT_count_x](https://github.com/user-attachments/assets/4f9b05e1-2463-4871-93c1-6d3144d286a5)


**Compare Average Salaries of Full-Time (FT) vs. Part-Time (PT) Employees**

The query groups employees by their work status (FT or PT) and calculates the average salary for each group. This provides an overview of salary differences based on employment type, offering a basis for further analysis or adjustment of pay structures.

```sql
SELECT Status, ROUND(AVG(TotalPay), 2) AS AvgSalary
FROM emp_salaries
GROUP BY Status;
```

Output:

![FT_PT_avg_salary_x](https://github.com/user-attachments/assets/9a54c887-7a1f-4006-9dc4-e348328c2b7a)


**Employees Who Are Paid Above the Average Salary**

The query selects employees whose total pay exceeds the company-wide average salary, calculated using a subquery. The results are ordered by salary in descending order, making it easy to identify the highest-paid employees.

```sql
SELECT EmployeeName, JobTitle, TotalPay
FROM emp_salaries
WHERE TotalPay > (SELECT AVG(TotalPay) FROM emp_salaries)
ORDER BY TotalPay DESC;
```

Output:

![emp_above_avg_sal_desc_x](https://github.com/user-attachments/assets/22e2d575-c25b-47f0-ba13-f488c24825e2)


**Percentage of Employees in Each Job Category**

The query calculates the proportion of employees in each job category by dividing the number of employees in a specific job title by the total number of employees. The result is rounded to two decimal places and sorted by the highest percentage.

```sql
SELECT JobTitle, ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM emp_salaries)), 2) AS Percentage
FROM emp_salaries
GROUP BY JobTitle
ORDER BY Percentage DESC;
```

Output:

![emp_percnt_jobtitle_x](https://github.com/user-attachments/assets/ce426ef1-79a9-46f5-b13f-48bc5a9c0f19)


**Employees with Significant Overtime Pay**

The query retrieves distinct job titles and their corresponding overtime pay for employees whose overtime pay exceeds $50,000. This helps focus on high overtime earners and associated job titles without duplicating results.

```sql
SELECT DISTINCT JobTitle, OvertimePay 
FROM emp_salaries 
WHERE OvertimePay > 50000;
```

Output:

![jobtitle_OTP_above_50K_x](https://github.com/user-attachments/assets/4d556d9a-972a-4bbe-8390-92808fa3be40)


**Average Base Pay for All Employees**

This query calculates the average base salary for all employees in the dataset. The result provides a single value that represents the organization's overall base salary benchmark.

```sql
SELECT AVG(BasePay) AS "Average Base Pay" 
FROM emp_salaries;
```

Output:

![emp_avg_basepay_X](https://github.com/user-attachments/assets/97eddf24-360f-4710-91f0-bd17d5c3b5db)


**Top 10 Highest Paid Employees**

The query retrieves the names and total pay of employees, sorted in descending order of total pay, and limits the results to the top 10 earners. This provides a focused view of the highest-paid individuals in the organization.

```sql
SELECT EmployeeName, TotalPay 
FROM emp_salaries
ORDER BY TotalPay DESC 
LIMIT 10;
```

Output:

![top_10_highest_paid_emp_x](https://github.com/user-attachments/assets/82b29453-a388-46d5-bc1f-c8dee1eb27a4)


**Average Pay Components for Each Employee**

The query computes the average of three pay components (Base Pay, Overtime Pay, and Other Pay) for each employee. This provides a personalized breakdown of the average compensation across different earnings categories.

```sql
SELECT EmployeeName, (BasePay + OvertimePay + OtherPay) / 3 AS Avg_Payments 
FROM emp_salaries;
```

Output:

![emp_avg_BP_OTP_OP_x](https://github.com/user-attachments/assets/9cd47579-6809-4934-bcdd-e857b804fc19)


**Employees with "Manager" in Their Job Title**

The query filters employees whose job titles contain the word "Manager" by using the LIKE operator with a wildcard (%). This ensures that any title with "Manager" (e.g., "Project Manager," "Sales Manager") is included in the results.

```sql
SELECT EmployeeName, JobTitle 
FROM emp_salaries 
WHERE JobTitle LIKE '%Manager%';
```

Output:

![emp_jobtitle_manager_x](https://github.com/user-attachments/assets/38aaaffa-80bf-42b2-b759-3841dc254062)


**Employees with Total Pay Between $50,000 and $75,000**

The query retrieves all columns for employees whose total pay is between $50,000 and $75,000. The WHERE clause specifies the range using >= (greater than or equal to) and <= (less than or equal to) operators.

```sql
SELECT * 
FROM emp_salaries 
WHERE TotalPay >= 50000 AND TotalPay <= 75000;
```

Output:

![emp_TP_between_50K_70K_x](https://github.com/user-attachments/assets/c4a3cfad-9b5d-4fd0-95dc-c2b32188ef1c)


**Employees with Base Pay Less Than $50,000 or Total Pay Greater Than $100,000**

The query selects all employees whose base pay is less than $50,000 or whose total pay exceeds $100,000. The OR operator is used to include both conditions, so employees fulfilling either criterion will be included in the results.

```sql
SELECT * 
FROM emp_salaries 
WHERE BasePay < 50000 OR TotalPay > 100000;
```

Output:

![emp_BP_less_50K_TP_more_100000_x](https://github.com/user-attachments/assets/9c2af977-ea67-4c27-b612-db04072a4b2b)


**Employees with Total Pay Benefits Between $125,000 and $150,000 and Job Title Containing "Director"**

The query retrieves all employees whose total pay benefits fall within the specified range and whose job title includes "Director." The BETWEEN operator is used to filter the pay range, and the LIKE operator with a wildcard (%) ensures that any job title containing "Director" (e.g., "Sales Director," "Project Director") is included.

```sql
SELECT * 
FROM emp_salaries 
WHERE TotalPayBenefits BETWEEN 125000 AND 150000 
AND JobTitle LIKE '%Director%';
```

Output:

![emp_TPB_between_125K_150K_director_x](https://github.com/user-attachments/assets/1a0a2379-82eb-4ec2-b9ab-2df51491d441)


**Employees Ordered by Total Pay Benefits in Descending Order**

The query retrieves all employee details and orders the results by the TotalPayBenefits column in descending order. This allows for easy identification of the highest-paid employees based on their total compensation.

```sql
SELECT * 
FROM emp_salaries 
ORDER BY TotalPayBenefits DESC;
```

Output:

![emp_TPB_desc_x](https://github.com/user-attachments/assets/95c8fba1-6f78-43fc-aa25-056c678a400b)


**Job Titles with an Average Base Pay of at Least $100,000**

The query calculates the average base pay for each job title using the AVG() function. The HAVING clause filters the results to include only those job titles with an average base pay of at least $100,000. The results are then sorted in descending order to show the highest-paying job titles first.

```sql
SELECT JobTitle, AVG(BasePay) AS "AVG BasePay" 
FROM emp_salaries 
GROUP BY JobTitle 
HAVING AVG(BasePay) >= 100000
ORDER BY AVG(BasePay) DESC;
```

Output:

![jobtitle_avg_BP_min_100000_avg_BP_desc_x](https://github.com/user-attachments/assets/337f6922-2e52-4aae-9887-989328700b11)


**Update Base Pay of Managers by 10%**

The query updates the BasePay column for all employees whose job titles contain the word "Manager." It applies a 10% increase by multiplying the current BasePay by 1.1 (representing a 10% increase). The WHERE clause filters the employees to only include those with "Manager" in their job title.

```sql
UPDATE emp_salaries
SET BasePay = BasePay * 1.1
WHERE JobTitle LIKE '%Manager%';
```


### Results and Findings

  - Average Salaries: Identified the job titles with the highest and lowest average salaries, highlighting roles such as     
    [e.g. "Directors"] as top earners.
  - Full-Time vs. Part-Time: Found that full-time employees earn significantly higher average salaries than part-time         
    employees.
  - Identified unusual cases where base pay was low but total pay was high, likely due to significant overtime or bonuses.
  - Observed employees with no overtime pay who still had above-average total compensation, possibly due to bonuses or other benefits.


### Recommendations

**Optimize Compensation for Key Roles:**

  - High-paying roles like [e.g., "Directors"] contribute significantly to total payroll costs. Regular reviews of compensation packages can ensure they align with industry standards and performance metrics.

**Analyze High Overtime Costs:**

  - Employees earning over $50,000 in overtime pay may indicate workload imbalances or inefficiencies. Conduct workload audits to optimize staffing and redistribute tasks to reduce dependency on overtime.

**Retain Top Talent:**

  - The top 10 highest-paid employees represent key personnel in the organization. Consider offering incentives, bonuses, or career advancement opportunities to retain these individuals.


### Key Focus Areas for Improvement

- **Employee Efficiency:** Reduce overtime dependency to minimize costs.
- **Fair Compensation Practices:** Conduct market analysis to ensure fairness in pay.
- **Workforce Development:** Invest in training programs for high-impact roles.


