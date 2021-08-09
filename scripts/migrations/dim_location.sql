DROP TABLE IF EXISTS warehouse.location_dim;

CREATE TABLE warehouse.location_dim (
    location_sk int4 null,
    state_id int4 null,
    state varchar null,
    city varchar null,
    zip_code varchar null,
    slug varchar null,
    cartodb_id int4 null,
    country varchar null,
    lat float8 null,
    long float8 null
);