## ✨ Data Transformation Steps (dbt Models)

1.  ### Staging Layer (`models/staging/`)
    * **Purpose:** Initial raw data cleaning and standardization.
    * `stg_walmart.sql`: Performs basic cleaning and standardizes column names (e.g., to `snake_case`) from the raw Walmart source.
    * `shopify_orders_with_full_categories.sql`: Selects all columns from raw Shopify orders and adds a `full_category_name` column by mapping `CATEGORY` abbreviations to full names.

2.  ### Intermediate Layer (`models/intermediate/`)
    * **Purpose:** Applying specific business logic, filtering data, and further standardization.
    * `shopify_matched_products.sql`: Filters data from `shopify_orders_with_full_categories` to include only the specified electronic products (`Laptop`, `Headphones`, `Smartphone`, `Tablet`) and calculates `total_item_revenue`.
    * `walmart_matched_products.sql`: Filters data from `stg_walmart` to include only the specified electronic products, calculates `total_item_revenue`, and **standardizes `full_category_name` to 'Electronics'** for these products.

3.  ### Analytics Layer (`models/marts/`)
    * **Purpose:** To provide a unified, business-friendly view of sales data, optimized for direct consumption by Business Intelligence (BI) tools and analytical queries.
    * `unified_sales.sql`: This is the core omnichannel sales data mart. Built using **Snowflake**'s powerful processing capabilities, it `UNION ALL`s the filtered data from `shopify_matched_products` and `walmart_matched_products`.
        * It ensures **consistent column names and data types** across both channels.
        * It handles missing data by inserting `NULL` values for channel-specific columns where data is absent (e.g., `store_id` for Shopify, `customer_age` for Walmart).
        * The `sales_channel` column (`Online`/`Offline`) is explicitly included for easy cross-channel comparison.
