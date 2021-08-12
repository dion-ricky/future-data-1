CREATE SCHEMA IF NOT EXISTS warehouse;

DROP TABLE IF EXISTS warehouse.product_dim CASCADE;

CREATE TABLE warehouse.product_dim (
    product_sk serial,
    product_legacy_id varchar null,
    product_master_category varchar null,
    product_category varchar null,
    CONSTRAINT product_dim_pkey PRIMARY KEY(product_sk)
);