/*
Query: Annual Sales

Purpose:
Summarize total sales by year.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT
    YEAR(Order_Date) AS SalesYear,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales
FROM train
GROUP BY YEAR(Order_Date)
ORDER BY SalesYear;