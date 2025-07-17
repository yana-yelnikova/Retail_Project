-- models/staging/stg_walmart.sql
select
    transaction_id as transaction_id,
    product_id as product_id,
    product_name as product_name,
    category as category_abbreviation,  -- Keep the original category here and rename for clarity
    customer_age,  
    customer_gender,
    customer_id as customer_id,
    customer_income,
    customer_loyalty_level,
    forecasted_demand,
    holiday_indicator,
    inventory_level,
    payment_method,
    promotion_applied,
    promotion_type,
    quantity_sold,
    reorder_point,
    reorder_quantity,
    stockout_indicator,
    store_id as store_id,
    store_location,
    supplier_id,
    supplier_lead_time,
    transaction_date as transaction_date,
    unit_price as unit_price,
    weather_conditions,
    weekday as weekday_name,
    actual_demand

from {{ source("retail_data", "WALMART") }}
