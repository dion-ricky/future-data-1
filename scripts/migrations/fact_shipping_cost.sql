DROP TABLE
    IF EXISTS warehouse.fact_shipping_cost;

CREATE TABLE warehouse.fact_shipping_cost (
    order_legacy_id varchar,
    order_date int4,
    order_time int4,
    product_sk int4,
    seller_sk int4,
    seller_location_sk int4,
    customer_location_sk int4,
    item_id int2,
    price float8 null,
    shipping_cost float8 null,
    CONSTRAINT fact_shipping_cost_pkey PRIMARY KEY(order_legacy_id, order_date, order_time, product_sk, seller_sk, seller_location_sk, customer_location_sk, item_id)
);

ALTER TABLE warehouse.fact_shipping_cost ADD CONSTRAINT fss_order_date_fkey FOREIGN KEY (order_date) REFERENCES warehouse.date_dim(date_id);
ALTER TABLE warehouse.fact_shipping_cost ADD CONSTRAINT fss_order_time_fkey FOREIGN KEY (order_time) REFERENCES warehouse.time_dim(time_id);
ALTER TABLE warehouse.fact_shipping_cost ADD CONSTRAINT fss_product_sk_fkey FOREIGN KEY (product_sk) REFERENCES warehouse.product_dim(product_sk);
ALTER TABLE warehouse.fact_shipping_cost ADD CONSTRAINT fss_seller_sk_fkey FOREIGN KEY (seller_sk) REFERENCES warehouse.seller_dim(seller_sk);
ALTER TABLE warehouse.fact_shipping_cost ADD CONSTRAINT fss_seller_location_sk_fkey FOREIGN KEY (seller_location_sk) REFERENCES warehouse.location_dim(location_sk);
ALTER TABLE warehouse.fact_shipping_cost ADD CONSTRAINT fss_customer_location_sk_fkey FOREIGN KEY (customer_location_sk) REFERENCES warehouse.location_dim(location_sk);