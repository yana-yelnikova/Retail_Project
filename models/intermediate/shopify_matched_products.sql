select *, price * quantity as total_item_revenue
from {{ ref("add_full_category_name_to_shopify") }}
where product_name in ('Laptop', 'Headphones', 'Smartphone', 'Tablet')

