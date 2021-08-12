DROP TABLE IF EXISTS warehouse.fact_product_metrics;

CREATE TABLE warehouse.fact_product_metrics (
    product_sk int4,
    product_name_length int4 null,
    product_description_length int4 null,
    product_photos_qty int4 null,
    product_weight_g float8 null,
    product_length_cm float8 null,
    product_height_cm float8 null,
    product_width_cm float8 null,
    CONSTRAINT fact_product_metrics_pkey PRIMARY KEY (product_sk)
);

ALTER TABLE warehouse.fact_product_metrics ADD CONSTRAINT fpm_product_sk_fkey FOREIGN KEY (product_sk) REFERENCES warehouse.product_dim(product_sk);