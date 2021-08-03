CREATE SCHEMA IF NOT EXISTS warehouse;

DROP TABLE IF EXISTS warehouse.product_dim;

CREATE TABLE warehouse.product_dim (
    product_sk serial,
    product_key varchar null,
    product_master_category varchar null,
    product_category varchar null,
    product_name_length int4 null,
    product_description_length int4 null,
    product_photos_qty int4 null,
    product_weight_g float8 null,
    product_length_cm float8 null,
    product_height_cm float8 null,
    product_width_cm float8 null
);