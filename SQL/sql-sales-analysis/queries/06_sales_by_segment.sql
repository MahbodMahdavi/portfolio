/*
Query: Sales by Segment

Purpose:
Compare total sales across customer segments.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT
    Segment,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales
FROM train
GROUP BY Segment
ORDER BY TotalSales DESC;
