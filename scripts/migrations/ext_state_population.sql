DROP TABLE
    IF EXISTS public.ext_state_population;

CREATE TABLE public.ext_state_population (
    state_id int4 NULL,
    "state" varchar NULL,
    predicted_population_2020 int8 NULL
);