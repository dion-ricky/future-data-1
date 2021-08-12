CREATE SCHEMA IF NOT EXISTS warehouse;

DROP TABLE IF EXISTS warehouse.seller_dim CASCADE;

CREATE TABLE warehouse.seller_dim (
    seller_sk int4 null,
    seller_legacy_id VARCHAR NULL,
    CONSTRAINT seller_dim_pkey PRIMARY KEY(seller_sk)
);