DROP TABLE
    IF EXISTS public.fact_shipping_cost;

CREATE TABLE public.fact_shipping_cost (
    pulau varchar NULL,
    state_id int8 NULL,
    "state" varchar NULL,
    city varchar NULL,
    min_shipping_cost float8 NULL,
    max_shipping_cost float8 NULL,
    avg_shipping_cost float8 NULL
);