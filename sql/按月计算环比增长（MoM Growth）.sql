-- 按月计算环比增长（MoM Growth）
WITH monthly_repurchase AS (
    SELECT 
        DATE_FORMAT(InvoiceDate, '%Y-%m') AS month, 
        COUNT(DISTINCT CASE WHEN total_orders >= 2 THEN sales_data.CustomerID END) * 100.0 / 
        COUNT(DISTINCT sales_data.CustomerID) AS repurchase_rate
    FROM (
        SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS total_orders
        FROM sales_data
        GROUP BY CustomerID
    ) AS user_orders
    JOIN sales_data ON user_orders.CustomerID = sales_data.CustomerID
    GROUP BY month
)
SELECT 
    month,
    repurchase_rate,
    LAG(repurchase_rate, 1) OVER (ORDER BY month) AS prev_month_rate,
    (repurchase_rate - LAG(repurchase_rate, 1) OVER (ORDER BY month)) / LAG(repurchase_rate, 1) OVER (ORDER BY month) * 100 AS MoM_growth
FROM monthly_repurchase
ORDER BY month;
