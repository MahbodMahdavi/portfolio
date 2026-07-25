/*
Query: Sales Share by Category

Purpose:
Calculate each category's percentage of total sales.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT
    Category,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales,
    CAST(
        SUM(Sales) * 100.0 /
        SUM(SUM(Sales)) OVER ()
        AS DECIMAL(5,2)
    ) AS SalesPercentage
FROM train
GROUP BY Category
ORDER BY TotalSales DESC;
