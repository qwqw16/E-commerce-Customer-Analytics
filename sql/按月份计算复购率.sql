-- 按月份计算复购率
SELECT 
    DATE_FORMAT(sales_data.InvoiceDate, '%Y-%m') AS month, 
    COUNT(DISTINCT CASE WHEN user_orders.total_orders >= 2 THEN sales_data.CustomerID END) * 100.0 / 
    COUNT(DISTINCT sales_data.CustomerID) AS repurchase_rate
FROM (
    SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS total_orders
    FROM sales_data
    GROUP BY CustomerID
) AS user_orders
JOIN sales_data ON user_orders.CustomerID = sales_data.CustomerID
GROUP BY month
ORDER BY month;
