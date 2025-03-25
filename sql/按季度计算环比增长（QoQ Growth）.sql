-- 按季度计算环比增长（QoQ Growth）
WITH quarterly_repurchase AS (
    SELECT 
        CONCAT(YEAR(InvoiceDate), '-Q', QUARTER(InvoiceDate)) AS quarter, 
        COUNT(DISTINCT CASE WHEN total_orders >= 2 THEN sales_data.CustomerID END) * 100.0 / 
        COUNT(DISTINCT sales_data.CustomerID) AS repurchase_rate
    FROM (
        SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS total_orders
        FROM sales_data
        GROUP BY CustomerID
    ) AS user_orders
    JOIN sales_data ON user_orders.CustomerID = sales_data.CustomerID
    GROUP BY quarter
)
SELECT 
    quarter,
    repurchase_rate,
    LAG(repurchase_rate, 1) OVER (ORDER BY quarter) AS prev_quarter_rate,
    (repurchase_rate - LAG(repurchase_rate, 1) OVER (ORDER BY quarter)) / LAG(repurchase_rate, 1) OVER (ORDER BY quarter) * 100 AS QoQ_growth
FROM quarterly_repurchase
ORDER BY quarter;
