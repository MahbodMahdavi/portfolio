/*
Query: Sales by State

Purpose:
Identify the states generating the highest total sales.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT
    State,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales
FROM train
GROUP BY State
ORDER BY TotalSales DESC;
