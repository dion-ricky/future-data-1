DROP TABLE
    IF EXISTS warehouse.mart_customer_order_frequency;

CREATE TABLE warehouse.mart_customer_order_frequency (
    user_sk int4,
    count_order int8 NULL,
    CONSTRAINT mart_customer_order_frequency_pkey PRIMARY KEY (user_sk)
);

ALTER TABLE warehouse.mart_customer_order_frequency ADD CONSTRAINT mcof_user_sk_fkey FOREIGN KEY (user_sk) REFERENCES warehouse.user_dim(user_sk);