DROP TABLE
    IF EXISTS public.mart_customer_by_state;

CREATE TABLE
    public.mart_customer_by_state (
        customer_state_id int8 NULL,
        customer_state varchar NULL,
        customer_count int8 NULL
    );