select *, price * quantity as total_item_revenue
from {{ ref("stg_add_full_category_name_to_shopify") }}
where product_name in ('Laptop', 'Headphones', 'Smartphone', 'Tablet')

