/*
Query: Order Count by Region

Purpose:
Count the number of orders in each region.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT
    Region,
    COUNT(*) AS OrderCount
FROM train
GROUP BY Region
ORDER BY OrderCount DESC;