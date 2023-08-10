{% snapshot tpch_order_snapshot %}

{{ config(
    target_database='raw',
    target_schema='snapshots',
    unique_key='o_orderkey',
    strategy='timestamp',
    updated_at='o_orderdate',
)}}

select * from {{ source('tpch', 'orders') }}

{% endsnapshot %}