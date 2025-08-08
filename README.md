# 📈 Omnichannel Sales Data Unification (Shopify & Walmart)

This project demonstrates the process of building a centralized data pipeline using dbt (data build tool) to unify sales data from an online store (Shopify) and a chain of physical stores (selling through Walmart). The goal is to provide a comprehensive, integrated view of omnichannel sales for enhanced business analytics.

***

## 🎯 Business Case

A mid-sized retailer faced the challenge of siloed sales data from its online (Shopify) and in-store (Walmart) channels. This project successfully addresses that problem by **building a unified data model** in a centralized data warehouse.

This unification enables the business to:

* **Revenue Tracking:** Gain a real-time, consolidated view for comparing online vs. in-store sales performance.
* **Customer Behavior Analysis:** Analyze cross-channel purchasing patterns to tailor marketing strategies.
* **Operational Efficiency:** Eliminate manual reporting and reduce data reconciliation errors.

The project demonstrates a fully automated data pipeline that ingests, processes, and prepares omnichannel sales data, empowering data-driven decisions.

***

## 🛠️ Technology Stack

* **Data Transformation:** [dbt (data build tool)](https://www.getdbt.com/)
* **Data Warehouse:** [Snowflake](https://www.snowflake.com/)
* **Visualization:** [Looker Studio](https://lookerstudio.google.com/)
* **Version Control:** Git / GitHub

***

## 📊 Data Sources

This project utilizes two primary sales datasets:

1.  **Shopify Orders Data:** Represents e-commerce transactions.
    * **Original Columns:** `ORDER_ID`, `SKU`, `PRODUCT_NAME`, `CATEGORY`, `CHANNEL`, `CUSTOMER_EMAIL`, `PRICE`, `QUANTITY`, `ORDER_DATE`, `WEEK`, `YEAR`.
2.  **Walmart Sales Data:** Represents in-store transactions.
    * **Original Columns:** `TRANSACTION_ID`, `PRODUCT_ID`, `PRODUCT_NAME`, `CATEGORY`, `CUSTOMER_AGE`, `CUSTOMER_GENDER`, `CUSTOMER_ID`, `CUSTOMER_INCOME`, `CUSTOMER_LOYALTY_LEVEL`, `FORECASTED_DEMAND`, `HOLIDAY_INDICATOR`, `INVENTORY_LEVEL`, `PAYMENT_METHOD`, `PROMOTION_APPLIED`, `PROMOTION_TYPE`, `QUANTITY_SOLD`, `REORDER_POINT`, `REORDER_QUANTITY`, `STOCKOUT_INDICATOR`, `STORE_ID`, `STORE_LOCATION`, `SUPPLIER_ID`, `SUPPLIER_LEAD_TIME`, `TRANSACTION_DATE`, `UNIT_PRICE`, `WEATHER_CONDITIONS`, `WEEKDAY`, `ACTUAL_DEMAND`.

### 📂 Raw Data Files (For Reference/Reproducibility)

The original raw data files, which were loaded into Snowflake, are located in the data/ folder within this repository.


***

***

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

***

## 🚀 How to Run the Project

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/your-username/your-repo-name.git](https://github.com/your-username/your-repo-name.git)
    cd your-repo-name
    ```
2.  **Ensure Raw Data in Snowflake:**
    * This dbt project expects your raw `SHOPIFY_ORDERS` and `WALMART` tables to be already loaded into your `RETAIL_PROJECT.PUBLIC` schema in Snowflake.
3.  **Configure dbt:**
    * Ensure you have dbt Core (`pip install dbt-snowflake`) or dbt Cloud set up.
    * Update your `~/.dbt/profiles.yml` (for dbt Core) or your dbt Cloud connection settings with your Snowflake credentials (Account, User, Password/Key, Role, Warehouse, Database, Schema). **Do NOT commit `profiles.yml` to Git if it contains sensitive credentials.**
4.  **Run dbt Models:**
    * Execute the full dbt build process to create all models and run tests:
        ```bash
        dbt build
        ```
    * Alternatively, run specific models (e.g., just the final mart):
        ```bash
        dbt run --select unified_sales
        ```
5.  **Generate Documentation (Optional but Recommended):**
    ```bash
    dbt docs generate
    dbt docs serve # For local viewing
    ```
    (In dbt Cloud, access documentation via the "Docs" tab.)

***

## 📈 Analysis 


Once the summary table `unified_sales` is built in Snowflake, I connected it to Looker for detailed analysis.

***
## 📈 Insights

The provided data, after being unified and processed, offers a clear view into key performance areas of the business. The analysis reveals both expected trends and critical discrepancies that require further action.

### Key Insights

* **Significant Revenue Discrepancy:** Despite nearly identical unit sales in online (7.4k units) and offline (7.3k units) channels from January to September 2024, offline revenue ($7.5M) is over 6 times higher than online revenue ($1.2M).
* **Pricing is the Primary Factor:** A deeper analysis shows that this vast difference in revenue is caused by a significant price discrepancy. The average price of offline sales is approximately $1000 per unit, while the average online price is only around $155 per unit.
* **Mixed Monthly Trends:** Offline sales peaked in March and August, while online sales peaked in August and May.
* **Operational Variance in Offline Stores:** While sales at a city level are homogeneous, there is a substantial performance gap between individual stores. The top-performing store (ID 1 in New York) generated over 3x the profit of the lowest-performing store (ID 16 in New York), indicating a significant difference in efficiency.
* **Stable Customer Behavior:** The average check and sales by day of the week are highly stable and consistent for offline sales, showing minimal changes on holidays (a mere 3% increase) and across different weekdays.

### Recommendations & Next Steps

Based on these insights, we recommend the following strategic steps:

1.  **Investigate Pricing Strategy:** Analyze the reasons behind the vast price difference between online and offline channels. Determine if this gap is intentional and sustainable, or if a pricing adjustment is needed to optimize revenue.
2.  **Optimize Store Performance:** Conduct a detailed analysis of the top-performing store (ID 1) versus the lowest-performing store (ID 16) to identify best practices, operational differences, or external factors that contribute to such a wide performance gap.
3.  **Evaluate Price Impact:** Explore whether raising online prices to a point between the current online and offline averages would increase revenue without significantly reducing unit sales.
4.  **Monitor Monthly Trends:** Use the prepared dashboard to continuously monitor monthly sales trends and identify the factors behind the monthly peaks and dips.

