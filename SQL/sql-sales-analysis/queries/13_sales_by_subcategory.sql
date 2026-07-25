/*
Query: Sales by Sub-Category

Purpose:
Compare total sales across product sub-categories.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT
    Sub_Category,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales
FROM train
GROUP BY Sub_Category
ORDER BY TotalSales DESC;