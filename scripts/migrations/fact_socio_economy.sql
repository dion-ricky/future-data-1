DROP TABLE IF EXISTS warehouse.fact_socio_economy;

CREATE TABLE warehouse.fact_socio_economy (
    date_id int4,
    location_sk int4,
    state_area float8 null,
    state_pop_per_square_km float8 null,
    state_population_est float8 null,
    state_budget_est float8 null,
    state_pdrb_est float8 null,
    state_pdrb_per_capita_est float8 null,
    state_ipm_est float8 null,
    CONSTRAINT fact_socio_economy_pkey PRIMARY KEY (date_id, location_sk)
);

ALTER TABLE warehouse.fact_socio_economy ADD CONSTRAINT fse_location_sk_fkey FOREIGN KEY (location_sk) REFERENCES warehouse.location_dim(location_sk);