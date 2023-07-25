{{
    config(
        materialized = 'table',
        tags=['finance']
    )
}}


with region_customer as (
    
    select * from {{ ref('region_customers') }}

),
order_item as (
    
    select 
        order_key,
        customer_key,
        gross_item_sales_amount,
        item_discount_amount,
        item_tax_amount,
        net_item_sales_amount,
        order_date 
    from {{ ref('order_items') }}

),

final as (

    select 
        region_customer.region_key,
        region_customer.nation_key,
        region_customer.region_name,
        region_customer.nation_name,
        region_customer.customer_key,
        order_item.order_key,
        order_item.gross_item_sales_amount,
        order_item.item_discount_amount,
        order_item.item_tax_amount,
        order_item.net_item_sales_amount
    from
        region_customer
        inner join order_item
            on region_customer.customer_key = order_item.customer_key
)
select * from final

