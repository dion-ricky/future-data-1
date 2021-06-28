DROP TABLE
    IF EXISTS public.mart_customer_recency;

CREATE TABLE public.mart_customer_recency (
    user_name varchar NULL,
    last_order_interval interval NULL
);