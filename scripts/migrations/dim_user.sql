CREATE SCHEMA IF NOT EXISTS warehouse;

DROP TABLE IF EXISTS warehouse.user_dim;

CREATE TABLE warehouse.user_dim (
    user_sk serial,
    "user_name" varchar null,
    customer_zip_code varchar null,
    customer_city varchar null,
    customer_state varchar null,
    customer_state_id smallint null
);