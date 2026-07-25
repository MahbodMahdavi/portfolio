# SQL Sales Analysis

A SQL portfolio project that explores retail sales data using Microsoft SQL Server. This project demonstrates SQL fundamentals and analytical techniques commonly used by data analysts to answer business questions and generate actionable insights.

---

## Project Overview

Using a retail sales dataset, this project analyzes sales performance across products, customers, regions, categories, and time. The queries progress from basic aggregations to more advanced analytical techniques.

Topics covered include:

- Data aggregation
- Business reporting
- Geographic analysis
- Customer analysis
- Product performance
- Time-series analysis
- Window functions (coming soon)
- Common Table Expressions (CTEs) (coming soon)

---

## Technologies Used

- Microsoft SQL Server 2022 Express
- SQL Server Management Studio (SSMS)
- T-SQL

---

## Dataset

This project uses the **Sample Superstore** retail sales dataset from Kaggle.

The dataset includes information such as:

- Orders
- Customers
- Products
- Categories
- Regions
- States
- Cities
- Shipping methods
- Sales

The dataset (`train.csv`) is included in this repository for reproducibility.

---

## Project Structure

```
sql-sales-analysis/
│
├── README.md
├── train.csv
└── queries/
    ├── 01_top_products.sql
    ├── 02_sales_by_region.sql
    ├── 03_sales_by_category.sql
    ├── 04_monthly_sales_trend.sql
    ├── 05_top_customers.sql
    ├── 06_sales_by_segment.sql
    ├── 07_top_products_by_region.sql
    ├── 08_sales_by_state.sql
    ├── 09_sales_by_city.sql
    ├── 10_sales_by_ship_mode.sql
    ├── 11_average_sale_by_category.sql
    ├── 12_order_count_by_region.sql
    ├── 13_sales_by_subcategory.sql
    ├── 14_top_customers_by_order_count.sql
    ├── 15_sales_by_year.sql
    └── 16_top_products_per_category.sql
```

---

## Business Questions Answered

- Which products generate the highest sales?
- Which regions contribute the most revenue?
- Which product categories perform best?
- How do monthly sales trends change over time?
- Who are the highest-value customers?
- Which customer segments generate the most sales?
- Which product categories perform best within each region?
- Which states and cities generate the highest sales?
- Which shipping methods are used most?
- What is the average sale by product category?
- Which regions process the most orders?
- Which sub-categories generate the most revenue?

---

## Sample SQL Concepts Demonstrated

- SELECT
- TOP
- SUM()
- AVG()
- COUNT()
- CAST()
- GROUP BY
- ORDER BY
- YEAR()
- MONTH()
- DATENAME()
- Aggregate functions
- Multi-column grouping
- Business reporting queries

---

## Future Enhancements

Planned additions include:

- Window functions
- CTEs (Common Table Expressions)
- Ranking functions
- Running totals
- Advanced business analytics queries

---

## Author

**Mahbod Mahdavi**

Senior Data Analyst Portfolio

- LinkedIn: https://www.linkedin.com/in/mahbodmahdavi
- GitHub: https://github.com/mahbodmahdavi
