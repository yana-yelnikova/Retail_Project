select
    -- Shopify specific fields (mapped to common unified names)
    order_id as transaction_id,
    product_name,
    category as category_abbreviation,
    full_category_name,  -- Comes directly from 'shopify_matched_products' model
    total_item_revenue,  -- Calculated in 'shopify_matched_products'
    quantity as quantity_sold,
    order_date as transaction_date,
    customer_email as customer_identifier,
    null as store_id,  -- Not applicable for online sales
    null as store_location,  -- Not applicable for online sales
    'Online' as sales_channel,
    price as unit_price,
    null as customer_age,
    null as customer_gender,
    null as customer_income,
    null as customer_loyalty_level,
    null as holiday_indicator,
    null as inventory_level,
    null as payment_method,
    null as promotion_applied,
    null as promotion_type,
    null as reorder_point,
    null as reorder_quantity,
    null as stockout_indicator,
    null as supplier_id,
    null as supplier_lead_time,
    null as weather_conditions,
    null as weekday_name,
    sku as product_sku  -- Shopify-specific SKU

from {{ ref("shopify_matched_products") }}

union all

select
    -- Walmart specific fields (mapped to common unified names)
    transaction_id,
    product_name,
    category_abbreviation,
    full_category_name,
    total_item_revenue,  -- Calculated in 'walmart_matched_products'
    quantity_sold,
    transaction_date,
    customer_id as customer_identifier,
    store_id,
    store_location,
    'Offline' as sales_channel,
    unit_price,
    customer_age,
    customer_gender,
    customer_income,
    customer_loyalty_level,
    holiday_indicator,
    inventory_level,
    payment_method,
    promotion_applied,
    promotion_type,
    reorder_point,
    reorder_quantity,
    stockout_indicator,
    supplier_id,
    supplier_lead_time,
    weather_conditions,
    weekday_name,
    product_id as product_sku

from {{ ref("walmart_matched_products") }}
