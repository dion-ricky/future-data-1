DROP TABLE
    IF EXISTS warehouse.mart_customer_recency;

CREATE TABLE warehouse.mart_customer_recency (
    user_sk int4,
    last_order_interval interval NULL,
    CONSTRAINT mart_customer_recency_pkey PRIMARY KEY (user_sk)
);

ALTER TABLE warehouse.mart_customer_recency ADD CONSTRAINT mcr_user_sk_fkey FOREIGN KEY (user_sk) REFERENCES warehouse.user_dim(user_sk);