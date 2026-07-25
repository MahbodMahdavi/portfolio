/*
Query: Top 10 Customers by Total Sales

Purpose:
Identify the customers generating the highest revenue.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT TOP (10)
    Customer_Name,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales
FROM train
GROUP BY Customer_Name
ORDER BY TotalSales DESC;
