DROP TABLE
    IF EXISTS public.fact_order_geo;

CREATE TABLE public.fact_order_geo (
    pulau varchar NULL,
    state_id int8 NULL,
    "state" varchar NULL,
    city varchar NULL,
    order_date int8 NULL,
    order_count int8 NULL
);