CREATE SCHEMA IF NOT EXISTS warehouse;

DROP TABLE IF EXISTS warehouse.temp_master_category;

CREATE TABLE warehouse.temp_master_category (
    master_category varchar null,
    category varchar null
);