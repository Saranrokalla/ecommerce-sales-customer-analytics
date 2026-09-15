-- E-Commerce Sales & Customer Analytics
-- Portfolio SQL analysis
-- Dataset: ecommerce_sales_data.csv
-- SQL dialect: PostgreSQL-style SQL

-- 1. Overall sales KPIs
SELECT
    SUM(revenue) AS total_revenue,
    COUNT(*) FILTER (WHERE order_status = 'Completed') AS completed_orders,
    ROUND(
        SUM(revenue) / NULLIF(COUNT(*) FILTER (WHERE order_status = 'Completed'), 0), 2
    ) AS average_order_value
FROM ecommerce_sales_data;

-- 2. Monthly revenue trend
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(revenue) AS revenue
FROM ecommerce_sales_data
WHERE order_status <> 'Cancelled'
GROUP BY 1
ORDER BY 1;

-- 3. Regional performance
SELECT
    region,
    SUM(revenue) AS revenue,
    COUNT(*) FILTER (WHERE order_status = 'Completed') AS completed_orders
FROM ecommerce_sales_data
GROUP BY region
ORDER BY revenue DESC;

-- 4. Category performance
SELECT
    category,
    SUM(revenue) AS revenue,
    ROUND(100.0 * SUM(revenue) / SUM(SUM(revenue)) OVER (), 2) AS revenue_share_pct
FROM ecommerce_sales_data
GROUP BY category
ORDER BY revenue DESC;

-- 5. Top products
SELECT
    product,
    category,
    SUM(revenue) AS revenue,
    SUM(quantity) AS units_sold
FROM ecommerce_sales_data
WHERE order_status = 'Completed'
GROUP BY product, category
ORDER BY revenue DESC
LIMIT 10;

-- 6. Return analysis
SELECT
    category,
    COUNT(*) FILTER (WHERE returned_flag = 1) AS returned_orders,
    COUNT(*) FILTER (WHERE order_status <> 'Cancelled') AS qualifying_orders,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE returned_flag = 1)
        / NULLIF(COUNT(*) FILTER (WHERE order_status <> 'Cancelled'),0), 2
    ) AS return_rate_pct
FROM ecommerce_sales_data
GROUP BY category
ORDER BY return_rate_pct DESC;

-- 7. New vs repeat customer analysis
WITH customer_orders AS (
    SELECT customer_id, COUNT(*) AS qualifying_orders
    FROM ecommerce_sales_data
    WHERE order_status = 'Completed'
    GROUP BY customer_id
)
SELECT
    CASE WHEN qualifying_orders > 1 THEN 'Repeat' ELSE 'New' END AS customer_type,
    COUNT(*) AS customers
FROM customer_orders
GROUP BY 1
ORDER BY 1;

-- 8. High-value customers
SELECT
    customer_id,
    SUM(revenue) AS customer_revenue,
    COUNT(*) FILTER (WHERE order_status = 'Completed') AS completed_orders
FROM ecommerce_sales_data
GROUP BY customer_id
ORDER BY customer_revenue DESC
LIMIT 10;

-- 9. Region x category analysis
SELECT
    region,
    category,
    SUM(revenue) AS revenue
FROM ecommerce_sales_data
GROUP BY region, category
ORDER BY region, revenue DESC;

-- 10. Data-quality checks
SELECT 'Missing customer_id' AS check_name, COUNT(*) AS issue_count
FROM ecommerce_sales_data WHERE customer_id IS NULL
UNION ALL
SELECT 'Negative revenue', COUNT(*) FROM ecommerce_sales_data WHERE revenue < 0
UNION ALL
SELECT 'Invalid quantity', COUNT(*) FROM ecommerce_sales_data WHERE quantity <= 0
UNION ALL
SELECT 'Discount outside 0-100', COUNT(*) FROM ecommerce_sales_data WHERE discount_pct < 0 OR discount_pct > 100;
