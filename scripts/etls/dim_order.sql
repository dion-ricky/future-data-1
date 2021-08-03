INSERT INTO warehouse.order_dim (
    order_key,
    "user_name",
    order_status,
    order_date,
    order_approved_date,
    pickup_date,
    delivered_date,
    estimated_time_delivery
)

SELECT
    order_id AS order_key,
    "user_name",
    order_status,
    order_date,
    order_approved_date,
    pickup_date,
    delivered_date,
    estimated_time_delivery
FROM
    public.order;