DROP TABLE IF EXISTS warehouse.order_status_dim CASCADE;

CREATE TABLE warehouse.order_status_dim (
    order_status_sk int4 null,
    order_status varchar null,
    CONSTRAINT order_status_dim_pkey PRIMARY KEY(order_status_sk)
);