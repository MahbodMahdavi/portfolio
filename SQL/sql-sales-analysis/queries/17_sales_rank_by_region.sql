SELECT
    Region,
    SUM(Sales) AS TotalSales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS SalesRank
FROM train
GROUP BY Region
ORDER BY SalesRank;
