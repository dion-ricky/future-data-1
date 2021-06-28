DROP TABLE
    IF EXISTS public.mart_customer_recency;

CREATE TABLE public.mart_customer_recency (
    user_sk int8 NULL,
    last_order_interval interval NULL
);