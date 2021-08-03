CREATE SCHEMA IF NOT EXISTS warehouse;

CREATE TABLE IF NOT EXISTS warehouse.order_dim (
    order_sk SERIAL,
    order_key VARCHAR NULL,
    "user_name" VARCHAR NULL,
    order_status VARCHAR NULL,
    order_date TIMESTAMP NULL,
    order_approved_date TIMESTAMP NULL,
    pickup_date TIMESTAMP NULL,
    delivered_date TIMESTAMP NULL,
    estimated_time_delivery TIMESTAMP NULL
);