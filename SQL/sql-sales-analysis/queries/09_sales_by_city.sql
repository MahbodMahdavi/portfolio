/*
Query: Sales by City

Purpose:
Identify the cities generating the highest total sales.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT
    City,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales
FROM train
GROUP BY City
ORDER BY TotalSales DESC;