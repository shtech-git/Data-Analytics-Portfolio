--====================================================
-- HR ATTRITION ANALYTICS PROJECT
-- Dataset: IBM HR Attrition Dataset
--====================================================

--==============================
-- 1. DATABASE SETUP
--==============================

CREATE DATABASE HR_Analytics;
GO

USE HR_Analytics;
GO

--==============================
-- 2. DATA VALIDATION CHECK
--==============================

--2.1 View sample data
select top 10 *
from hr_data;

--2.2 Total Records
select count(*) as total_records
from hr_data;

--2.3 Total Columns
select count(*) as total_columns
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'hr_data';

--2.4 Check Missing Values
select *
from hr_data
where Employee_Number IS NULL
OR Age IS NULL
OR Attrition IS NULL
OR Department IS NULL
OR Education_Field IS NULL
OR Gender IS NULL
OR Job_Role IS NULL
OR Job_Satisfaction IS NULL
OR Monthly_Income IS NULL
OR Over_Time IS NULL
OR Percent_Salary_Hike IS NULL
OR Performance_Rating IS NULL
OR Total_Working_Years IS NULL
OR Work_LifeBalance IS NULL
OR Years_At_Company IS NULL;

--2.5 Check Duplicate Employees

select
Employee_Number,
count(*) as duplicate_count
from hr_data
group by Employee_Number
having count(*) > 1;

-- Insight:
-- The dataset contains 1,470 employee records and 15 columns.
-- No missing values or duplicate employee records were found.


--==============================
-- 3. OVERALL KPI ANALYSIS
--==============================

--3.1 Total Employees

select count(*) as total_employees
from hr_data;

--3.2 Active Employees

select count(*) as active_employees
from hr_data
where Attrition = 0;

--3.3 Employees Left

select count(*) as employees_left
from hr_data
where Attrition = 1;

--3.4 Attrition Rate (%)

select
cast(
count(case when attrition = 1 then 1 end)
* 100.0
/ count(*)
as decimal(5,2)
) as attrition_rate
from hr_data;

-- Insight:
-- The organization has 1,470 employees, of which 1,233 are active and
-- 237 employees have left, resulting in an overall attrition rate of 16.12%.


--==============================
-- 4. DEPARTMENT ANALYSIS
--==============================

--4.1 Attrition by Department

select
Department,
count(*) as employees_left
from hr_data
where Attrition = 1
group by Department
order by employees_left desc;

--4.2 Department-wise Attrition Rate

select
Department,
cast(
count(case when Attrition = 1 then 1 end)
*100.0
/ count(*)
as decimal(5,2)
) as attrition_rate
from hr_data
group by Department
order by attrition_rate desc;

--4.3 Average Salary by Department

select
Department,
       round(avg(Monthly_Income),2) as avg_salary
from hr_data
group by Department
order by avg_salary desc;

-- Insight:
-- Research & Development recorded the highest number of employees leaving (133),
-- while Sales had the highest attrition rate (20.63%) and the highest average
-- monthly salary (6,959) among all departments.


--==============================
-- 5. OVERTIME ANALYSIS
--==============================

-- Attrition by Overtime

select
Over_Time,
count(*) as employees_left
from hr_data
where Attrition = 1
group by Over_Time;

-- Insight:
-- Employees who worked overtime had a higher number of resignations (127)
-- compared to employees who did not work overtime (110).


--==============================
-- 6. AGE GROUP ANALYSIS
--==============================

-- Attrition by Age Group

select
  case
     when age <= 30 then 'Young'
	 when age <= 50 then 'Adult'
	 else 'Senior'
	 end as age_group,
	 count(*) as employees_left
from hr_data
where attrition = 1
group by
case
     when age <= 30 then 'Young'
	 when age <= 50 then 'Adult'
	 else 'Senior'
	 end
order by employees_left desc;

-- Insight:
-- Adult employees had the highest attrition (119), followed by Young employees (100),
-- while Senior employees had the lowest attrition (18).


--==============================
-- 7. INCOME BAND ANALYSIS
--==============================

-- Attrition by Income Band

select
   case
       when monthly_income <= 5000 then 'Low'
	   when Monthly_Income <= 10000 then 'Medium'
	   else 'High'
   end as income_band,
   count(*) as employees_left
from hr_data
where attrition = 1
group by 
   case
       when monthly_income <= 5000 then 'Low'
	   when Monthly_Income <= 10000 then 'Medium'
	   else 'High'
	end
order by employees_left desc;


-- Insight:
-- Employees in the Low income band had the highest attrition (163),
-- followed by the Medium (49) and High (25) income bands.



--==============================
-- 8. EXPERIENCE ANALYSIS
--==============================

-- Attrition by Experience Group

select
  case
     when total_working_years <= 5 then 'Junior'
	 when total_working_years <= 15 then 'Mid-Level'
	 else 'Senior'
   end as experience_group,
   count(*) as employees_left
from hr_data
where attrition = 1
group by
    case
     when total_working_years <= 5 then 'Junior'
	 when total_working_years <= 15 then 'Mid-Level'
	 else 'Senior'
   end
order by employees_left desc;


-- Insight:
-- Mid-Level employees had the highest attrition (115), followed by
-- Junior employees (91), while Senior employees had the lowest attrition (31).


--==============================
-- 9. JOB ROLE ANALYSIS
--==============================

--9.1 Attrition by Job Role

select
Job_Role,
count(*) as employees_left
from hr_data
where Attrition = 1
group by Job_Role
order by employees_left desc;

-- Insight:
-- Laboratory Technicians had the highest attrition (62), followed by
-- Sales Executives (57) and Research Scientists (47), while Research
-- Directors had the lowest attrition (2).


--9.2 Average Salary by Job Role

select
Job_Role,
      round(avg(Monthly_Income),2) as avg_salary
from hr_data
group by Job_Role
order by avg_salary desc;

-- Insight:
-- Managers received the highest average monthly salary (17,181),
-- followed by Research Directors (16,033), while Sales Representatives
-- had the lowest average monthly salary (2,626).


--==============================
-- 10. GENDER ANALYSIS
--==============================

-- Attrition by Gender

select
Gender,
count(*) as employees_left
from hr_data
where Attrition = 1
group by Gender
order by employees_left desc;

-- Insight:
-- Male employees had higher attrition (150) compared to
-- female employees (87).


--==============================
-- 11. JOB SATISFACTION ANALYSIS
--==============================

-- Attrition by Job Satisfaction

select
Job_Satisfaction,
count(*) as employees_left
from hr_data
where Attrition = 1
group by Job_Satisfaction
order by Job_Satisfaction;


-- Insight:
-- Employees with Job Satisfaction level 3 had the highest attrition (73),
-- while employees with Job Satisfaction level 2 had the lowest attrition (46).


--==============================
-- 12. WORK-LIFE BALANCE ANALYSIS
--==============================

-- Attrition by Work-Life Balance

select
Work_LifeBalance,
count(*) as employees_left
from hr_data
where Attrition = 1
group by Work_LifeBalance
order by Work_LifeBalance;

-- Insight:
-- Employees with Work-Life Balance level 3 had the highest attrition (127),
-- while employees with Work-Life Balance level 1 had the lowest attrition (25).



--==============================
-- 13. TENURE ANALYSIS
--==============================

-- Attrition by Years At Company

select
Years_At_Company,
count(*) as employees_left
from hr_data
where Attrition = 1
group by Years_At_Company
order by Years_At_Company;

-- Insight:
-- Employees with 1 year at the company had the highest attrition (59),
-- while attrition generally decreased as years at the company increased.


--==============================
-- 14. PERFORMANCE ANALYSIS
--==============================

-- Performance Rating Distribution

select
Performance_Rating,
count(*) as employee_count
from hr_data
group by Performance_Rating
order by Performance_Rating;

-- Insight:
-- Most employees received a Performance Rating of 3 (1,244),
-- while 226 employees received a Performance Rating of 4.


--==============================
-- 15. EDUCATION FIELD ANALYSIS
--==============================

-- Attrition by Education Field

select
Education_Field,
count(*) as employees_left
from hr_data
where Attrition = 1
group by Education_Field
order by employees_left desc;

-- Insight:
-- Employees from the Life Sciences education field had the highest attrition (89),
-- while the Human Resources education field had the lowest attrition (7).

--==============================
-- 16. SUBQUERY ANALYSIS
--==============================

-- Employees Earning More Than Company Average Salary

select
   Employee_Number,
   Department,
   Job_Role,
   Monthly_Income
from hr_data
where Monthly_Income >
(
     select 
	      avg(monthly_income)
     from hr_data
)
order by monthly_income desc;

-- Insight:
-- A total of 493 employees earn more than the company's average monthly
-- salary, helping identify high-income employees across different
-- departments and job roles.


--===================================
-- 17. WINDOW FUNCTION ANALYSIS
--===================================
   
--17.1 Rank Employees by Salary Within Each Department using DENSE_RANK()

select
   employee_number,
   department,
   Job_Role,
   Monthly_Income,
   DENSE_RANK() over
   (
	     partition by department 
	     order by monthly_income desc
    ) as salary_rank
from hr_data;

-- Insight:
-- Employees are ranked by monthly salary within each department,
-- with employees earning the same salary receiving the same rank.


--17.2 Display the Top-Paid Employee in Each Department using ROW_NUMBER()

select
    employee_number,
       job_role,
       department,
	   monthly_income
from
(
    select 
       employee_number,
       job_role,
       department,
	   monthly_income,
       ROW_NUMBER() over
       (
          partition by department
	      order by monthly_income desc
       ) as row_no
    from hr_data
) as salary_rank
where row_no = 1;


-- Insight:
-- The query identifies the highest-paid employee in each department,
-- showing that Research & Development had the highest monthly salary (19,999),
-- followed by Sales (19,847) and Human Resources (19,717).





