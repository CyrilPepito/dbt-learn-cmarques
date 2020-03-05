with orders as (

    select * from {{ ref('stg_jaffle_shop_orders') }}
),

payments as (

    select * from {{ ref('stg_stripe_payments') }}

), 

final as (

    select 
        orders.order_id as order_id
        , orders.order_date as order_date
        , orders.customer_id as customer_id
        , sum(payments.amount) as amount

    from orders
    left outer join payments on orders.order_id = payments.order_id
    group by 1,2,3
)

select * from final