with region_customer as (
    
    select * from {{ ref('dim_customers') }}

),

final as (
    select
        region_customer.nation, 
        count(region_customer.nation_key) as count_customers
    from
        region_customer
    group by 1
)

select * from final order by nation desc limit 10
