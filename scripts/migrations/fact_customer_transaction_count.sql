DROP TABLE
    IF EXISTS public.fact_customer_transaction_count;

CREATE TABLE public.fact_customer_transaction_count (
    user_name varchar NULL,
    order_date int8 NULL,
    order_count int8 NULL
);