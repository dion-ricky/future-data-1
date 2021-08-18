DROP TABLE IF EXISTS warehouse.fact_socio_economy;

CREATE TABLE warehouse.fact_socio_economy (
    date_id int4,
    state_id int4,
    state_area float8 null,
    state_pop_per_square_km float8 null,
    state_population_est float8 null,
    state_budget_est float8 null,
    state_pdrb_est float8 null,
    state_pdrb_per_capita_est float8 null,
    state_ipm_est float8 null,
    CONSTRAINT fact_socio_economy_pkey PRIMARY KEY (date_id, state_id)
);

ALTER TABLE warehouse.fact_socio_economy
    ADD CONSTRAINT fse_date_id_fkey
    FOREIGN KEY (date_id)
        REFERENCES warehouse.date_dim(date_id);