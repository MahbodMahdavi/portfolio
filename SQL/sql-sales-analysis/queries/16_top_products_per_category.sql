/*
Query: Top Products by Category

Purpose:
Identify the highest-selling products within each category.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT TOP (20)
    Category,
    Product_Name,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales
FROM train
GROUP BY
    Category,
    Product_Name
ORDER BY
    Category,
    TotalSales DESC;