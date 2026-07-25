WITH CustomerSales AS (
    SELECT
        Region,
        "Customer Name",
        SUM(Sales) AS TotalSales
    FROM train
    GROUP BY Region, "Customer Name"
),
RankedCustomers AS (
    SELECT
        Region,
        "Customer Name",
        TotalSales,
        ROW_NUMBER() OVER (
            PARTITION BY Region
            ORDER BY TotalSales DESC
        ) AS RowNum
    FROM CustomerSales
)
SELECT
    Region,
    "Customer Name",
    TotalSales
FROM RankedCustomers
WHERE RowNum = 1
ORDER BY Region;
