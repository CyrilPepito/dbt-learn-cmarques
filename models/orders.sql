-- with customers as (

--     select * from {{ ref('stg_customers') }}
-- ),

with orders as (

    select * from {{ ref('stg_orders') }}
),

payments as (

    select * from {{ ref('stg_payments') }}

), 

final as (

    select 
        payments.order_id as order_id
        , orders.customer_id as customer_id
        , payments.amount as amount

    from payments
    left outer join orders on orders.order_id = payments.order_id
)

select * from final