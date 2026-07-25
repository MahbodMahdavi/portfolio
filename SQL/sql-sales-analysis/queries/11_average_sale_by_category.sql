/*
Query: Average Sale by Category

Purpose:
Calculate the average sales amount for each category.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

SELECT
    Category,
    CAST(AVG(Sales) AS DECIMAL(10,2)) AS AverageSale
FROM train
GROUP BY Category
ORDER BY AverageSale DESC;