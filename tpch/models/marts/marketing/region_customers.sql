with region as (
    
    select * from {{ ref('stg_tpch_regions') }}

),

nation as (

    select * from {{ ref('stg_tpch_nations') }}

),

customer as (

    select * from {{ ref('stg_tpch_customers') }}

),

final as (
    select 

    region.region_key,
    nation.nation_key,
    region.name as region_name,
    nation.name as nation_name,
    customer.customer_key
from
    region
inner join 
    nation
        on region.region_key = nation.region_key
inner join
    customer
        on nation.nation_key = customer.nation_key
order by
    region.region_key
)

select * from final
