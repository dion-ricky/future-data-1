DROP TABLE IF EXISTS warehouse.location_dim CASCADE;

CREATE TABLE warehouse.location_dim (
    location_sk int4 null,
    pulau varchar null,
    state_id int4 null,
    state varchar null,
    state_iso varchar null,
    state_capital varchar null,
    state_flag varchar null,
    city varchar null,
    zip_code varchar null,
    slug varchar null,
    cartodb_id int4 null,
    country varchar null,
    lat float8 null,
    long float8 null,
    CONSTRAINT location_dim_pkey PRIMARY KEY(location_sk)
);