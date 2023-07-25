with region_customer as (
    
    select * from {{ ref('region_customers') }}

),

final as (
    select
        region_customer.region_name, 
        count(region_customer.region_key) as count_customers
    from
        region_customer
    group by 1
)

select * from final order by count_customers desc
