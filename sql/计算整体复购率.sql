-- 计算整体复购率
SELECT 
    COUNT(DISTINCT CASE WHEN total_orders >= 2 THEN CustomerID END) * 100.0 / COUNT(DISTINCT CustomerID) AS repurchase_rate
FROM (
    SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS total_orders
    FROM sales_data
    GROUP BY CustomerID
) AS user_orders;
