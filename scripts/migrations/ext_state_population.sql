DROP TABLE
    IF EXISTS staging.ext_state_population;

CREATE TABLE staging.ext_state_population (
    state_id int4 NULL,
    "state" varchar NULL,
    predicted_population_2020 int8 NULL
);