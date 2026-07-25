/*
Query: Sales by Ship Mode

Purpose:
Compare total sales by shipping method.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT
    Ship_Mode,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales
FROM train
GROUP BY Ship_Mode
ORDER BY TotalSales DESC;