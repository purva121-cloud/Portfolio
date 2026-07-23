SET GLOBAL local_infile = 1;
USE inventory_analytics;
SELECT COUNT(*) FROM retail_store_inventory_data;
WITH row_status AS (
    SELECT
        `Store ID`      AS Store_ID,
        Category,
        Region,
        Date,
        `Inventory Level`  AS Inventory_Level,
        `Demand Forecast`  AS Demand_Forecast,
        CASE
            WHEN `Inventory Level` < `Demand Forecast` * 3 THEN 'Critical Understock'
            WHEN `Inventory Level` < `Demand Forecast` * 7 THEN 'Reorder Warning'
            ELSE 'Healthy Stock'
        END AS Day_Status
    FROM retail_store_inventory_data
)
SELECT Store_ID, Category, Region,
    COUNT(*) AS Total_Days,
    ROUND(100.0 * SUM(CASE WHEN Day_Status = 'Critical Understock' THEN 1 ELSE 0 END) / COUNT(*), 1) AS Pct_Critical,
    ROUND(100.0 * SUM(CASE WHEN Day_Status = 'Reorder Warning'     THEN 1 ELSE 0 END) / COUNT(*), 1) AS Pct_Warning,
    ROUND(100.0 * SUM(CASE WHEN Day_Status = 'Healthy Stock'       THEN 1 ELSE 0 END) / COUNT(*), 1) AS Pct_Healthy
FROM row_status
GROUP BY Store_ID, Category, Region
ORDER BY Pct_Critical DESC;
WITH daily AS (
    SELECT
        `Store ID` AS Store_ID, Category, Region, Date,
        SUM(`Units Sold`)     AS Units_Sold,
        SUM(`Inventory Level`) AS Inventory_Level
    FROM retail_store_inventory_data
    GROUP BY Store_ID, Category, Region, Date
),
stats AS (
    SELECT
        Store_ID, Category, Region,
        ROUND(AVG(Inventory_Level), 2) AS Avg_Stock_On_Hand,
        ROUND(SUM(Units_Sold) / COUNT(DISTINCT Date), 2) AS Sales_Velocity
    FROM daily
    GROUP BY Store_ID, Category, Region
)
SELECT
    *,
    ROUND(Sales_Velocity * 3, 2)  AS Safety_Stock,
    ROUND(Sales_Velocity * 10, 2) AS Reorder_Point,
    ROUND(Avg_Stock_On_Hand - (Sales_Velocity * 10), 2) AS Stock_Gap,
    RANK() OVER (ORDER BY Avg_Stock_On_Hand - (Sales_Velocity * 10) ASC) AS Urgency_Rank
FROM stats
ORDER BY Urgency_Rank;
SELECT `Store ID`, Category, Region,
    RANK() OVER (ORDER BY SUM(`Units Sold`) DESC) AS Rnk
FROM retail_store_inventory_data
GROUP BY `Store ID`, Category, Region
ORDER BY Rnk
LIMIT 1000;
WITH daily AS (
    SELECT
        `Store ID` AS Store_ID, Category, Region, Date,
        SUM(`Units Sold`) AS Units_Sold
    FROM retail_store_inventory_data
    GROUP BY Store_ID, Category, Region, Date
),
velocity AS (
    SELECT
        Store_ID, Category, Region,
        ROUND(SUM(Units_Sold) / COUNT(DISTINCT Date), 2) AS Avg_Daily_Sales
    FROM daily
    GROUP BY Store_ID, Category, Region
)
SELECT
    Movement_Category, COUNT(*) AS How_Many
FROM (
    SELECT *,
        CASE
            WHEN Avg_Daily_Sales >= 217.6 THEN 'Fast-Moving'
            WHEN Avg_Daily_Sales >= 207.4 THEN 'Medium-Moving'
            ELSE 'Slow-Moving'
        END AS Movement_Category
    FROM velocity
) x
GROUP BY Movement_Category;