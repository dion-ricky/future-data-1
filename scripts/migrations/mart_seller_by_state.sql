DROP TABLE
    IF EXISTS public.mart_seller_by_state;

CREATE TABLE public.mart_seller_by_state (
    seller_state_id int4 NULL,
    seller_state varchar NULL,
    seller_count int4 NULL
);