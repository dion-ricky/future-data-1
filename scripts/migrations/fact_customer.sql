DROP TABLE
    IF EXISTS public.fact_customer;

CREATE TABLE public.fact_customer (
    pulau varchar NULL,
    customer_state_id int8 NULL,
    customer_state varchar NULL,
    customer_city varchar NULL,
    customer_count int8 NULL
);