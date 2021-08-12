CREATE SCHEMA IF NOT EXISTS warehouse;

DROP TABLE IF EXISTS warehouse.user_dim CASCADE;

CREATE TABLE warehouse.user_dim (
    user_sk int4 null,
    user_legacy_id varchar null,
    CONSTRAINT user_dim_pkey PRIMARY KEY(user_sk)
);