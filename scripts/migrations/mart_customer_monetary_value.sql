DROP TABLE IF EXISTS warehouse.mart_customer_monetary_value;

CREATE TABLE warehouse.mart_customer_monetary_value (
    user_sk int4,
    total_spending float8 null,
    total_shipping_cost float8 null,
    CONSTRAINT mart_customer_monetary_value_pkey PRIMARY KEY (user_sk)
);

ALTER TABLE warehouse.mart_customer_monetary_value ADD CONSTRAINT mcmv_user_sk_fkey FOREIGN KEY (user_sk) REFERENCES warehouse.user_dim(user_sk);