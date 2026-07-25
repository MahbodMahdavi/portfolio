/*
Query: Monthly Sales Trend

Purpose:
Analyze monthly sales trends over time to identify seasonal patterns.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT
    YEAR(Order_Date) AS SalesYear,
    DATENAME(MONTH, Order_Date) AS SalesMonth,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales
FROM train
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date),
    DATENAME(MONTH, Order_Date)
ORDER BY
    SalesYear,
    MONTH(Order_Date);
