/*
Query: Sales by Region

Purpose:
Compare total sales across regions to identify the highest-performing markets.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT
    Region,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales
FROM train
GROUP BY Region
ORDER BY TotalSales DESC;
