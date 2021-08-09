CREATE SCHEMA IF NOT EXISTS warehouse;

DROP TABLE IF EXISTS warehouse.product_dim;

CREATE TABLE warehouse.product_dim (
    product_sk serial,
    product_key varchar null,
    product_master_category varchar null,
    product_category varchar null
);