USE SalesAnalysis;
GO

SELECT
    Region,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS TotalSales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS SalesRank
FROM train
GROUP BY Region
ORDER BY SalesRank;
