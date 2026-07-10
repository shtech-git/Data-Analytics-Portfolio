
--==============================================================
-- E-COMMERCE SALES & CUSTOMER BEHAVIOR ANALYTICS PROJECT
--==============================================================
create database ecommerce_project;
Go

use ecommerce_project;
Go

--======================
-- CHECK DATA
--======================
select * from customers;
select * from events;
select * from order_items;
select * from orders;
select * from products;
select * from reviews;
select * from sessions;

--======================
-- KPI ANALYSIS
--======================

-- Total Revenue
select sum(total_usd) as total_revenue
from orders;

-- Insight:
-- The business generated total revenue of $4.49M, reflecting strong overall sales performance.

-- Total Orders Placed
select count(*) as total_orders_placed
from orders;

-- Insight:
-- A total of 33,580 orders were placed, indicating strong customer purchasing activity.


-- Average Order Value
select avg(total_usd) as average_order_value
from orders;

-- Insight:
-- The average order value was $133.81, indicating the average amount spent per order.

--======================
-- REVENUE ANALYSIS
--======================

-- Revenue Trend Over Time (Monthly Performance)
select
   format(order_time,'yyyy-MM') as year_month,
   sum(total_usd) as total_revenue
from orders
group by format(order_time,'yyyy-MM')
order by year_month;

-- Insight:
-- Monthly revenue remained relatively stable throughout the analysis period, 
-- with normal fluctuations across different months.


-- Revenue by Country
select
    country,
    sum(total_usd) as revenue
from orders
group by country
order by revenue desc;

-- Insight:
-- The US generated the highest revenue, making it the top-performing market and the largest contributor to overall sales.


-- Revenue by Device
select
     device,
     sum(total_usd) as revenue
from orders
group by device
order by revenue desc;

-- Insight:
-- Mobile devices generated the highest revenue, indicating that most customers preferred shopping through mobile devices.


-- Revenue by Traffic Source
select
     source,
     sum(total_usd) as revenue
from orders
group by source
order by revenue desc;

-- Insight:
-- Organic traffic contributed the highest revenue among all traffic sources.


--======================
-- PRODUCT ANALYSIS
--======================

-- Top Selling Products by Quantity
select top 10
        product_id,
        sum(quantity) as total_quantity
from order_items
group by product_id
order by total_quantity desc;

-- Insight:
-- The analysis identifies the top 10 best-selling products based on the total quantity sold.


-- Top 10 Products by Revenue
select TOP 10
    p.name,
    SUM(oi.line_total_usd) AS revenue
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY revenue DESC;

-- Insight:
-- Mouse RosyBrown 419 generated the highest revenue among all products.


-- Revenue by Product Category
select
     p.category,
     sum(oi.line_total_usd) as revenue
from products p
inner join order_items oi
on p.product_id = oi.product_id
group by p.category
order by revenue desc;

-- Insight:
-- Home & Kitchen generated the highest revenue among all product categories.


--======================
-- CUSTOMER ANALYSIS
--======================

-- Top Spending Customers
select top 10
     c.customer_id,
     c.name,
     sum(o.total_usd) as total_spend
from customers c
inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.name
order by total_spend desc;

-- Insight:
-- Dr. Tiffany York PhD generated the highest total spending, making them the most valuable customer by revenue.


-- Customer Segmentation by Age Group
select
case
      when age between 18 and 24 then '18-24'
      when age between 25 and 34 then '25-34'
      when age between 35 and 44 then '35-44'
      else '45+'
end as age_group,
count(*) as total_customers
from customers
group by
case
      when age between 18 and 24 then '18-24'
      when age between 25 and 34 then '25-34'
      when age between 35 and 44 then '35-44'
else '45+'
end
order by age_group;

-- Insight:
-- Customers aged 45+ formed the largest customer segment, 
-- indicating that mature customers make up a significant portion of the customer base.


--======================
-- FUNNEL ANALYSIS
--======================

-- Event Distribution
select
     event_type,
     count(*) as total_events
from events
group by event_type;

-- Insight:
-- Page View recorded the highest number of events among all customer interactions.


-- Conversion Rates Between Funnel Stages
with funnel as
(
select
      sum(case when event_type = 'page_view' then 1 else 0 end) as pageviews,
      sum(case when event_type = 'add_to_cart' then 1 else 0 end) as carts,
      sum(case when event_type = 'checkout' then 1 else 0 end) as checkouts,
      sum(case when event_type = 'purchase' then 1 else 0 end) as purchases
from events
)
select *,
(carts * 100.0 / nullif(pageviews,0)) as view_to_cart_rate,
(purchases * 100.0 / nullif(pageviews,0)) as view_to_purchase_rate
from funnel;

-- Insight:
-- The funnel achieved a 26.54% view-to-cart conversion rate and a 6.23% view-to-purchase conversion rate.


--======================
-- WINDOW FUNCTIONS
--======================

-- Revenue Ranking by Country
select *
from
(
    select
    country,
    sum(total_usd) as revenue,
    dense_rank() over(order by sum(total_usd) desc) as rank_no
from orders
group by country
) t
order by revenue desc;

-- Cumulative Revenue Over Time
SELECT
    FORMAT(order_time,'yyyy-MM') AS year_month,
    SUM(total_usd) AS revenue,
    SUM(SUM(total_usd)) OVER
    (
        ORDER BY YEAR(order_time), MONTH(order_time)
    ) AS running_revenue
FROM orders
GROUP BY
    YEAR(order_time),
    MONTH(order_time),
    FORMAT(order_time,'yyyy-MM');

--======================
-- CTE ANALYSIS
--======================

-- Customer-wise Total Spending
with customer_spend as
(
    select
    customer_id,
    sum(total_usd) as total_spend
from orders
group by customer_id
)
select *
from customer_spend
order by total_spend desc;

--======================
-- CASE WHEN ANALYSIS
--======================

-- High Value vs Normal Orders
select
     order_id,
     total_usd,
    case
       when total_usd > 200 then 'High-value'
       else 'Normal'
    end as order_type
from orders;


