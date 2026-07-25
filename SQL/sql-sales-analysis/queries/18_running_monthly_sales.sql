/*
Query: Running Monthly Sales

Purpose:
Calculate cumulative sales over time.

Author: Mahbod Mahdavi
*/

USE SalesAnalysis;
GO

WITH MonthlySales AS
(
    SELECT
        YEAR(Order_Date) AS SalesYear,
        MONTH(Order_Date) AS SalesMonthNumber,
        DATENAME(MONTH, Order_Date) AS SalesMonth,
        SUM(Sales) AS MonthlySales
    FROM train
    GROUP BY
        YEAR(Order_Date),
        MONTH(Order_Date),
        DATENAME(MONTH, Order_Date)
)

SELECT
    SalesYear,
    SalesMonth,
    CAST(MonthlySales AS DECIMAL(10,2)) AS MonthlySales,
    CAST(
        SUM(MonthlySales) OVER (
            ORDER BY SalesYear, SalesMonthNumber
        ) AS DECIMAL(10,2)
    ) AS RunningTotalSales
FROM MonthlySales
ORDER BY
    SalesYear,
    SalesMonthNumber;
