DROP TABLE IF EXISTS public.mart_transaction_value;

CREATE TABLE public.mart_transaction_value (
    state_id int4 NULL,
    "state" varchar NULL,
    avg_spending float8 NULL,
    highest_spending float8 NULL,
    lowest_spending float8 NULL,
    pdrb_2020 float8 NULL
);