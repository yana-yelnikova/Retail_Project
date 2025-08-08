select
    *,
    case
        category
        when 'SPRT'
        then 'Sports'
        when 'HOME'
        then 'Home Goods'
        when 'BEAU'
        then 'Beauty'
        when 'AUTO'
        then 'Automotive'
        when 'FOOD'
        then 'Food'
        when 'TOYS'
        then 'Toys'
        when 'ELEC'
        then 'Electronics'
        when 'FASH'
        then 'Fashion'
        else category
    end as full_category_name
from {{ source("retail_data", "SHOPIFY_ORDERS") }}  
