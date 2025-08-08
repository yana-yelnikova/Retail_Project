SELECT
    transaction_id,
    product_id,
    product_name,
    category_abbreviation, -- Original category from staging
    customer_age,
    customer_gender,
    customer_id,
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
    store_id,
    store_location,
    supplier_id,
    supplier_lead_time,
    transaction_date,
    unit_price,
    weather_conditions,
    weekday_name,
    actual_demand,

    -- Standardize category for our specific products
    'Electronics' AS full_category_name, -- Always 'Electronics' for these 4 products

    -- Calculate total item revenue
    unit_price * quantity_sold AS total_item_revenue

FROM
    {{ ref('stg_walmart') }}
WHERE
    product_name IN ('Laptop', 'Headphones', 'Smartphone', 'Tablet')
