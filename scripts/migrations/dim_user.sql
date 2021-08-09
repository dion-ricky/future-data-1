CREATE SCHEMA IF NOT EXISTS warehouse;

DROP TABLE IF EXISTS warehouse.user_dim;

CREATE TABLE warehouse.user_dim (
    user_sk int4 null,
    user_legacy_id varchar null
);