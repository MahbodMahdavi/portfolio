USE SalesAnalysis;
GO

WITH MonthlySales AS (
    SELECT
        DATEFROMPARTS(YEAR(Order_Date), MONTH(Order_Date), 1) AS MonthDate,
        CAST(SUM(Sales) AS DECIMAL(10,2)) AS MonthlySales
    FROM train
    GROUP BY
        DATEFROMPARTS(YEAR(Order_Date), MONTH(Order_Date), 1)
)
SELECT
    FORMAT(MonthDate, 'yyyy-MM') AS [Month],
    MonthlySales,
    CAST(
        SUM(MonthlySales) OVER (ORDER BY MonthDate)
        AS DECIMAL(10,2)
    ) AS RunningTotalSales
FROM MonthlySales
ORDER BY MonthDate;
