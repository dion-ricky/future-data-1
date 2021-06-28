DROP TABLE
    IF EXISTS public.mart_customer_transaction_comparison;

CREATE TABLE public.mart_customer_transaction_comparison (
    category varchar NULL,
    order_count int4 NULL
);