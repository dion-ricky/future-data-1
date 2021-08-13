DROP TABLE
    IF EXISTS warehouse.fact_customer_monetary_value;

CREATE TABLE warehouse.fact_customer_monetary_value (
    order_legacy_id varchar,
    order_date int4,
    order_time int4,
    location_sk int4,
    user_sk int4,
    total_spending float8 null,
    total_shipping_cost float8 null,
    CONSTRAINT fact_customer_monetary_value_pkey PRIMARY KEY (
                                                    order_legacy_id, order_date,
                                                    order_time, location_sk,
                                                    user_sk)
);

ALTER TABLE warehouse.fact_customer_monetary_value ADD CONSTRAINT fcmv_order_date_fkey FOREIGN KEY (order_date) REFERENCES warehouse.date_dim(date_id);
ALTER TABLE warehouse.fact_customer_monetary_value ADD CONSTRAINT fcmv_order_time_fkey FOREIGN KEY (order_time) REFERENCES warehouse.time_dim(time_id);
ALTER TABLE warehouse.fact_customer_monetary_value ADD CONSTRAINT fcmv_location_sk_fkey FOREIGN KEY (location_sk) REFERENCES warehouse.location_dim(location_sk);
ALTER TABLE warehouse.fact_customer_monetary_value ADD CONSTRAINT fcmv_user_sk_fkey FOREIGN KEY (user_sk) REFERENCES warehouse.user_dim(user_sk);