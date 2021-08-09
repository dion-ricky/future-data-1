DROP TABLE IF EXISTS warehouse.order_status_dim;

CREATE TABLE warehouse.order_status_dim (
    order_status_sk int4 null,
    order_status varchar null
);