/*
Query: Top Customers by Number of Orders

Purpose:
Identify customers placing the most orders.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT TOP (10)
    Customer_Name,
    COUNT(*) AS OrderCount
FROM train
GROUP BY Customer_Name
ORDER BY OrderCount DESC;