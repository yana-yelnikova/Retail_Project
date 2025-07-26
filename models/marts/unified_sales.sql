select
    -- Shopify specific fields (mapped to common unified names)
    cast(order_id as varchar(255)) as transaction_id,  -- Cast to VARCHAR
    product_name,
    full_category_name,
    total_item_revenue,
    quantity as quantity_sold,
    order_date as transaction_date,
    cast(customer_email as varchar(255)) as customer_identifier,  -- Cast to VARCHAR
    null as store_id,
    null as store_location,
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
    cast(sku as varchar(255)) as product_sku,  -- Cast to VARCHAR
    NULL AS actual_demand, 
    NULL AS forecasted_demand   
from {{ ref("shopify_matched_products") }}

union all

select
    -- Walmart specific fields (mapped to common unified names)
    cast(transaction_id as varchar(255)) as transaction_id,  -- Cast to VARCHAR
    product_name,
    full_category_name,
    total_item_revenue,
    quantity_sold,
    transaction_date,
    cast(customer_id as varchar(255)) as customer_identifier,  -- Cast to VARCHAR
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
    cast(product_id as varchar(255)) as product_sku,  -- Cast to VARCHAR
    actual_demand,
    forecasted_demand

from {{ ref("walmart_matched_products") }}
