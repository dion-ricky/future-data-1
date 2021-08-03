CREATE SCHEMA IF NOT EXISTS warehouse;

DROP TABLE IF EXISTS warehouse.seller_dim;

CREATE TABLE warehouse.seller_dim (
    seller_sk SERIAL,
    seller_key VARCHAR NULL,
    seller_zip_code VARCHAR NULL,
    seller_city VARCHAR NULL,
    seller_state VARCHAR NULL,
    seller_state_id SMALLINT NULL
);