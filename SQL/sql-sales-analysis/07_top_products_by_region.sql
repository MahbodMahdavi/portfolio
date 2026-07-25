/*
Query: Top Products by Region

Purpose:
Analyze total sales by region and product category.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT
    Region,
    Category,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales
FROM train
GROUP BY
    Region,
    Category
ORDER BY
    Region,
    TotalSales DESC;
