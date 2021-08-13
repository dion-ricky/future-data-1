DROP TABLE IF EXISTS warehouse.fact_order;

CREATE TABLE warehouse.fact_order (
    order_date int4,
    order_time int4,
    order_legacy_id varchar,
    seller_sk int4,
    user_sk int4,
    product_sk int4,
    seller_location_sk int4,
    customer_location_sk int4,
    order_status_sk int4,
    item_count int4 null,
    CONSTRAINT fact_order_pkey PRIMARY KEY (
                                order_date, order_time,
                                order_legacy_id, seller_sk,
                                user_sk, product_sk,
                                seller_location_sk,
                                customer_location_sk,
                                order_status_sk)
);

ALTER TABLE warehouse.fact_order ADD CONSTRAINT fact_order_order_date_fkey FOREIGN KEY (order_date) REFERENCES warehouse.date_dim(date_id);
ALTER TABLE warehouse.fact_order ADD CONSTRAINT fact_order_order_time_fkey FOREIGN KEY (order_time) REFERENCES warehouse.time_dim(time_id);
ALTER TABLE warehouse.fact_order ADD CONSTRAINT fact_order_seller_sk_fkey FOREIGN KEY (seller_sk) REFERENCES warehouse.seller_dim(seller_sk);
ALTER TABLE warehouse.fact_order ADD CONSTRAINT fact_order_user_sk_fkey FOREIGN KEY (user_sk) REFERENCES warehouse.user_dim(user_sk);
ALTER TABLE warehouse.fact_order ADD CONSTRAINT fact_order_product_sk_fkey FOREIGN KEY (product_sk) REFERENCES warehouse.product_dim(product_sk);
ALTER TABLE warehouse.fact_order ADD CONSTRAINT fact_order_seller_location_sk_fkey FOREIGN KEY (seller_location_sk) REFERENCES warehouse.location_dim(location_sk);
ALTER TABLE warehouse.fact_order ADD CONSTRAINT fact_order_customer_location_sk_fkey FOREIGN KEY (customer_location_sk) REFERENCES warehouse.location_dim(location_sk);
ALTER TABLE warehouse.fact_order ADD CONSTRAINT fact_order_order_status_sk_fkey FOREIGN KEY (order_status_sk) REFERENCES warehouse.order_status_dim(order_status_sk);
