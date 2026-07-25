SELECT
    DATE_TRUNC('month', "Order Date") AS Month,
    SUM(Sales) AS MonthlySales,
    SUM(SUM(Sales)) OVER (
        ORDER BY DATE_TRUNC('month', "Order Date")
    ) AS RunningTotalSales
FROM train
GROUP BY DATE_TRUNC('month', "Order Date")
ORDER BY Month;
