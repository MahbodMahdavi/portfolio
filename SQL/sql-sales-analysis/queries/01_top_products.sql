/*
Query: Top 10 Products by Total Sales

Purpose:
Identify the products generating the highest total sales.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT TOP (10)
    Product_Name,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales
FROM train
GROUP BY Product_Name
ORDER BY TotalSales DESC;
