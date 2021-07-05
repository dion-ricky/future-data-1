DROP TABLE
    IF EXISTS public.mart_shipping_cost_per_kg;

CREATE TABLE public.mart_shipping_cost_per_kg (
    state_id varchar NULL,
    state varchar NULL,
    min_shipping_cost float8 NULL,
    max_shipping_cost float8 NULL,
    avg_shipping_cost float8 NULL,
    avg_shipping_cost_per_kg float8 NULL
);