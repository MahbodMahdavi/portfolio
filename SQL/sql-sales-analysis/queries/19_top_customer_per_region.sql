/*
Query: Top Customer per Region

Purpose:
Identify the highest-selling customer in each region.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

WITH CustomerSales AS
(
    SELECT
        Region,
        Customer_Name,
        SUM(Sales) AS TotalSales
    FROM train
    GROUP BY
        Region,
        Customer_Name
),
RankedCustomers AS
(
    SELECT
        Region,
        Customer_Name,
        TotalSales,
        ROW_NUMBER() OVER
        (
            PARTITION BY Region
            ORDER BY TotalSales DESC
        ) AS CustomerRank
    FROM CustomerSales
)

SELECT
    Region,
    Customer_Name,
    CAST(TotalSales AS DECIMAL(10,2)) AS TotalSales
FROM RankedCustomers
WHERE CustomerRank = 1
ORDER BY Region;
