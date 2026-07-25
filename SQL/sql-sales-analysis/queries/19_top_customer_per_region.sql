USE SalesAnalysis;
GO

WITH CustomerSales AS (
    SELECT
        Region,
        Customer_Name,
        CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales
    FROM train
    GROUP BY
        Region,
        Customer_Name
),
RankedCustomers AS (
    SELECT
        Region,
        Customer_Name,
        TotalSales,
        ROW_NUMBER() OVER (
            PARTITION BY Region
            ORDER BY TotalSales DESC
        ) AS RowNum
    FROM CustomerSales
)
SELECT
    Region,
    Customer_Name,
    TotalSales
FROM RankedCustomers
WHERE RowNum = 1
ORDER BY Region;
