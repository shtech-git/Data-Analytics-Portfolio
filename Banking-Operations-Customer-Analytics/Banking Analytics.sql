
--==============================================================
-- BANKING OPERATIONS & CUSTOMER ANALYTICS PROJECT
-- Dataset: Banking and Customer Transaction Data
--==============================================================


CREATE DATABASE Banking_Analytics;
GO

USE Banking_Analytics;
GO


--==============================================================
-- CHECK DATA
--==============================================================

select *
from customer_data;

select *
from transaction_data;


select * 
from bank_data;


--==============================================================
-- TOTAL RECORDS
--==============================================================

select count(*) as Total_Customers
from customer_data;


select count(*) as Total_Transactions
from transaction_data;


select count(*) as Total_Bank_Branches
from bank_data;

-- Insight:
-- The dataset contains 10,000 customers, 10,000 transactions, and 1,000 bank branches.


--==============================================================
-- DUPLICATE CHECK
--==============================================================

-- Duplicate Customer_ID

select
   customer_id,
   count(*) as Total_Count
from customer_data
group by Customer_ID
having count(*)>1;

-- Insight:
-- No duplicate Customer_ID records were found in the dataset.
-- Each customer has a unique Customer_ID.


-- Duplicate Transaction_ID

select
  Transaction_ID,
  count(*) as Total_Count
from transaction_data
group by Transaction_ID
having count(*) >1;


-- Insight:
-- No duplicate Transaction_ID records were found in the dataset.
-- Each transaction has a unique Transaction_ID.


-- Duplicate Branch_ID

select 
   Branch_Id,
   count(*) as Total_Count
from bank_data
group by Branch_ID
having count(*)>1;

-- Insight:
-- No duplicate Branch_ID records were found in the dataset.
-- Each branch has a unique Branch_ID.


--==============================================================
-- MISSING VALUE CHECK
--==============================================================

-- Customer_Data Missing Values
select
     sum(case when customer_id is null then 1 else 0 end) as Missing_Customer_ID,
	 sum(case when age is null then 1 else 0 end) as Missing_Age,
	 sum(case when customer_type is null then 1 else 0 end) as Missing_Customer_Type,
	 sum(case when city is null then 1 else 0 end) as Missing_City,
	 sum(case when region is null then 1 else 0 end) as Missing_Region,
	 sum(case when bank_name is null then 1 else 0 end) as Missing_Bank_Name,
	 sum(case when branch_id is null then 1 else 0 end) as Missing_Branch_ID
from customer_data;

-- Insight:
-- Customer_ID, Region, Bank_Name, and Branch_ID have no missing values.
-- Age, Customer_Type, and City each contain 500 missing records and may require data cleaning before analysis.


-- Transaction_Data Missing Values
select
    sum(case when transaction_id is null then 1 else 0 end) as Missing_Transaction_ID,
	sum(case when customer_id is null then 1 else 0 end) as Missing_Customer_ID,
	sum(case when account_type is null then 1 else 0 end) as Missing_Account_Type,
	sum(case when total_balance is null then 1 else 0 end) as Missing_Total_Balance,
	sum(case when transaction_amount is null then 1 else 0 end) as Missing_Transaction_Amount,
	sum(case when investment_amount is null then 1 else 0 end) as Missing_Investment_Amount,
	sum(case when investment_type is null then 1 else 0 end) as Missing_Investment_Type,
	sum(case when transaction_date is null then 1 else 0 end) as Missing_Transaction_Date
from transaction_data;

-- Insight:
-- No missing values were found in the Transaction_Data table.
-- The transaction dataset is complete and ready for further analysis.


-- Bank_Data Missing Values
select
     sum(case when branch_id is null then 1 else 0 end) as Missing_Branch_ID,
	 sum(case when city is null then 1 else 0 end) as Missing_City,
	 sum(case when region is null then 1 else 0 end) as Missing_Region,
	 sum(case when firm_revenue is null then 1 else 0 end) as Missing_Firm_Revenue,
	 sum(case when expenses is null then 1 else 0 end) as Missing_Expenses,
	 sum(case when profit_margin is null then 1 else 0 end) as Missing_Profit_Margin
from bank_data;

-- Insight:
-- Branch_ID, City, Region, Expenses, and Profit_Margin have no missing values.
-- Firm_Revenue contains 50 missing records and should be cleaned before revenue analysis.


--==============================================================
-- DATA VALIDATION (MIN & MAX VALUES)
--==============================================================

-- Customer_Data Validation
select
    min(age) as Minimum_Age,
	max(age) as Maximum_Age
from customer_data;

-- Insight:
-- Customer ages range from 18 to 79 years.
-- This indicates the dataset includes both young and senior customers.


-- Transaction_Data Validation

select
     min(total_balance) as Minimum_Balance,
	 max(total_balance) as Maximum_Balance,
	 min(transaction_amount) as Minimum_Transaction_Amount,
	 max(transaction_amount) as Maximum_Transaction_Amount,
	 min(investment_amount) as Minimum_Investment_Amount,
	 max(investment_amount) as Maximum_Investment_Amount
from transaction_data;

-- Insight:
-- Customer balances range from 1,003 to 99,993, while transaction amounts range from 51.61 to 7,046.30.
-- Investment amounts range from 1,001 to 49,998, indicating a wide variation in customer financial activity.


-- Bank_Data Validation

select
     min(firm_revenue) as Minimum_Firm_Revenue,
	 max(firm_revenue) as Maximum_Firm_Revenue,
	 min(expenses) as Minimum_Expenses,
	 max(expenses) as Maximum_Expenses,
	 min(profit_margin) as Minimum_Profit_Margin,
	 max(profit_margin) as Maximum_Profit_Margin
from bank_data;

-- Insight:
-- Firm revenue ranges from 51,241 to 999,975, while expenses range from 20,520 to 499,568.
-- Profit margins vary from -49.5% to 99.97%, 
-- indicating that some branches are operating at a loss while others are highly profitable.


--==============================================================
-- DISTINCT VALUE CHECK
--==============================================================

-- Customer_Type
select
      distinct customer_type
from customer_data
where customer_type is not null;

-- Insight:
-- The dataset contains three customer types: Business, Employee, and Individual.
-- This enables customer type-wise analysis.


-- Account_Type
select
      distinct account_type
from transaction_data
where Account_Type is not null;

-- Insight:
-- The dataset contains three account types: Savings, Current, and Business.
-- This enables account type-wise transaction and balance analysis.


-- Investment_Type
select
     distinct investment_type
from transaction_data
where investment_type is not null;

-- Insight:
-- The dataset includes three investment types: Fixed Deposit, Recurring Deposit, and Mutual Fund.
-- This supports investment-wise analysis of customer investment patterns.


-- Region
select 
     distinct region
from bank_data
where region is not null;

-- Insight:
-- The bank operates across four regions: North, East, South, and West.
-- This allows region-wise analysis of revenue, expenses, and branch performance.


--==============================================================
-- KPI ANALYSIS
--==============================================================

-- Total Transaction Amount
select
     sum(transaction_amount) as Total_Transaction_Amount
from transaction_data;

-- Insight:
-- The bank processed a total transaction amount of 25.43 million.
-- This represents the overall transaction value across all customers.

-- Total Investment Amount
select
       sum(investment_amount) as Total_Investment_Amount
from transaction_data;

-- Insight:
-- The total investment amount is 25.55 million.
-- This represents the overall investment made by customers.


-- Average Account Balance
select 
     avg(Total_balance) as Average_Account_Balance
from transaction_data;

-- Insight:
-- The average account balance is 50,221.
-- This represents the average balance maintained across all customer accounts.


-- Total Firm Revenue & Average Profit Margin

select
      sum(firm_revenue) as Total_Firm_Revenue,
	  avg(profit_margin) as Average_Profit_Margin
from bank_data;

-- Insight:
-- The bank generated a total firm revenue of 48.84 million.
-- The average profit margin across all branches is 24.56%.


--==============================================================
-- CUSTOMER ANALYSIS
--==============================================================

-- Customer Distribution by Age Group
select
   case  
       when age <= 30 then 'Young'
	   when age <= 50 then 'Middle-Age'
	   else 'Senior'
   end as Age_Group,
   count(*) as Total_Customers
from customer_data
group by 
case  
       when age <= 30 then 'Young'
	   when age <= 50 then 'Middle-Age'
	   else 'Senior'
   end
order by Total_Customers desc;

-- Insight:
-- Senior customers represent the largest age group with 4,970 customers.
-- Young customers are the smallest age group with 1,929 customers.


-- Customer Distribution by Customer Type
select
      customer_type,
	  count(*) as Total_Customers
from customer_data
where Customer_Type is not null
group by Customer_Type
order by Total_Customers desc;

-- Insight:
-- Business customers represent the largest customer segment with 3,186 customers.
-- Individual customers are the smallest segment with 3,132 customers.


--==============================================================
-- TRANSACTION & REVENUE ANALYSIS
--==============================================================

-- Transaction Amount by Balance Category
select
     case
	    when total_balance <= 30000 then 'Low Balance'
		when total_balance <= 70000 then 'Medium Balance'
		else 'High Balance'
	end as Balance_Category,
	sum(transaction_amount) as Total_Transaction_Amount
from transaction_data
group by 
case
	    when total_balance <= 30000 then 'Low Balance'
		when total_balance <= 70000 then 'Medium Balance'
		else 'High Balance'
	end
order by Total_Transaction_Amount desc;

-- Insight:
-- Customers with Medium Balance contributed the highest transaction amount.
-- Customers with Low Balance recorded the lowest transaction amount.


-- Investment Amount by Investment Type
select
      investment_type,
	  sum(investment_amount) as Total_Investment
from transaction_data
where investment_type is not null
group by investment_type
order by Total_Investment desc;

-- Insight:
-- Recurring Deposit has the highest total investment amount.
-- Fixed Deposit has the lowest total investment amount among the three investment types.


-- Revenue by Region
select
     region,
	 sum(firm_revenue) as Total_Revenue
from bank_data
group by region
order by Total_Revenue desc;

-- Insight:
-- South region generated the highest total revenue.
-- North region generated the lowest total revenue.


--==============================================================
-- JOIN ANALYSIS
--==============================================================

-- Customer and Transaction Details
select
      C.customer_id,
	  C.customer_type,
	  C.city,
	  T.account_type,
	  T.total_balance,
	  T.transaction_amount,
	  T.investment_amount
from customer_data as C
inner join
transaction_data as T
on C.customer_id = T.customer_id;


-- Customer and Bank Details
select
       C.Customer_ID,
	   C.Customer_Type,
	   C.City,
	   B.Branch_ID,
	   B.Region,
	   B.Firm_Revenue,
	   B.Expenses,
	   B.Profit_Margin
from customer_data as C
inner join
Bank_data as B
on C.Branch_ID = B.Branch_ID;


--==============================================================
-- CASE WHEN ANALYSIS
--==============================================================

-- Customer Balance Category
select
    Customer_ID,
	Total_Balance,
	case
	    when total_balance <= 30000 then 'Low Balance'
	    when total_balance <= 70000 then 'Medium Balance'
	    else 'High Balance'
	end as Balance_Category
from transaction_data
order by Total_Balance desc;

--==============================================================
-- CTE ANALYSIS
--==============================================================

-- Customers with Above Average Transaction Amount
with Avg_Transaction as
   (
   select avg(transaction_amount) as Avg_Amount from transaction_data
   )
    select transaction_id,
	transaction_amount
	from transaction_data
	where Transaction_Amount >
	 (
   select Avg_Amount from Avg_Transaction
   )
order by Transaction_Amount desc;


-- Branches with Above Average Revenue

with Branch_Revenue as
(
    select avg(firm_revenue) as Avg_Revenue from bank_data
)
    select
	  branch_id,
	  Region,
	  firm_revenue
	from bank_data
	where Firm_Revenue >
	(
	   select Avg_Revenue from Branch_Revenue
	)
order by firm_revenue desc;


--==============================================================
-- WINDOW FUNCTION ANALYSIS
--==============================================================
-- Rank Customers by Transaction Amount

select
      customer_id,
	  transaction_amount,
	  DENSE_RANK() over
	  (
	     order by transaction_amount desc
	  ) as Transaction_Rank
from transaction_data;


-- Rank Branches by Revenue

select
     branch_id,
	 region,
	 firm_revenue,
	 row_number() over
	 (
	   order by firm_revenue desc 
	  ) as Revenue_Rank
from bank_data;


--==============================================================
-- BUSINESS SCENARIO ANALYSIS
--==============================================================

-- Top 10 Branches by Revenue
select top (10)
       branch_id,
	   region,
	   firm_revenue
from bank_data
order by Firm_Revenue desc;

-- Insight:
-- The top-performing branch generated a revenue of 999,975.
-- South region has the highest representation in the Top 10 revenue-generating branches.


-- Customer, Transaction & Branch Summary
select 
     C.customer_id,
	 C.customer_type,
	 C.city,
	 T.account_type,
	 T.total_balance,
	 T.transaction_amount,
	 T.investment_amount,
	 B.branch_id,
	 B.region,
	 B.firm_revenue,
	 B.expenses,
	 B.profit_margin
from customer_data as C
inner join
transaction_data as T
on C.Customer_ID = T.Customer_ID
inner join
bank_data as B
on C.Branch_ID = B.Branch_ID;



