with fct_region_order_items as (
    
    select * from {{ ref('fct_region_order_items') }}

),

final as (
    select
        fct_region_order_items.region, 
        sum(fct_region_order_items.gross_item_sales_amount) as total_revenue
    from
        fct_region_order_items
    group by 1
)

select * from final order by total_revenue desc
