DROP TABLE
    IF EXISTS public.mart_order_by_state;

CREATE TABLE public.mart_order_by_state (
    pulau varchar NULL,
    state_id int4 NULL,
    "state" varchar NULL,
    order_count int8 NULL
);