# 📈 Omnichannel Sales Data Unification (Shopify & Walmart)

This project demonstrates the process of building a centralized data pipeline using dbt (data build tool) to unify sales data from an online store (Shopify) and a chain of physical stores (selling through Walmart). The goal is to provide a comprehensive, integrated view of omnichannel sales for enhanced business analytics.

***

## 🎯 Business Case

A mid-sized retailer aims to consolidate its online (Shopify) and in-store (Walmart) sales data into a centralized data warehouse. This unification enables:

* **Revenue Tracking:** Real-time comparison of online vs. in-store sales performance.
* **Best-Selling Products:** Identification of top products across all channels for optimized inventory and marketing.
* **Customer Behavior Analysis:** Understanding cross-channel shopping patterns to tailor marketing strategies.
* **Operational Efficiency:** Elimination of manual reporting and reduction of data reconciliation errors.

The project builds a fully automated data pipeline that ingests, processes, and visualizes omnichannel sales data, empowering data-driven decisions.

***

## 🛠️ Technology Stack

* **Data Transformation:** [dbt (data build tool)](https://www.getdbt.com/)
* **Data Warehouse:** [Snowflake](https://www.snowflake.com/)
* **Version Control:** Git / GitHub

***

## 📊 Data Sources

This project utilizes two primary sales datasets:

1.  **Shopify Orders Data:** Represents e-commerce transactions.
    * **Original Columns:** `ORDER_ID`, `SKU`, `PRODUCT_NAME`, `CATEGORY`, `CHANNEL`, `CUSTOMER_EMAIL`, `PRICE`, `QUANTITY`, `ORDER_DATE`, `WEEK`, `YEAR`.
2.  **Walmart Sales Data:** Represents in-store transactions.
    * **Original Columns:** `TRANSACTION_ID`, `PRODUCT_ID`, `PRODUCT_NAME`, `CATEGORY`, `CUSTOMER_AGE`, `CUSTOMER_GENDER`, `CUSTOMER_ID`, `CUSTOMER_INCOME`, `CUSTOMER_LOYALTY_LEVEL`, `FORECASTED_DEMAND`, `HOLIDAY_INDICATOR`, `INVENTORY_LEVEL`, `PAYMENT_METHOD`, `PROMOTION_APPLIED`, `PROMOTION_TYPE`, `QUANTITY_SOLD`, `REORDER_POINT`, `REORDER_QUANTITY`, `STOCKOUT_INDICATOR`, `STORE_ID`, `STORE_LOCATION`, `SUPPLIER_ID`, `SUPPLIER_LEAD_TIME`, `TRANSACTION_DATE`, `UNIT_PRICE`, `WEATHER_CONDITIONS`, `WEEKDAY`, `ACTUAL_DEMAND`.

### 📂 Raw Data / Source Files

The raw data files (`.csv` or `.json` if applicable) for both Shopify and Walmart should be placed in a designated directory within the repository, typically `data/` or `seeds/` (if using dbt seeds). This ensures data availability and project reproducibility. **You should add a folder named `data/` in the root of your GitHub repository and place your `shopify.csv` and `walmart.csv` (or `.json`) files there.**

***

## 🚀 Project Structure

The dbt project follows a layered architecture within **Snowflake**:
