/*
Query: Sales by Category

Purpose:
Compare total sales across product categories to identify the largest revenue contributors.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT
    Category,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales
FROM train
GROUP BY Category
ORDER BY TotalSales DESC;
