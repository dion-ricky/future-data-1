DROP TABLE
    IF EXISTS public.mart_customer_order_frequency;

CREATE TABLE public.mart_customer_order_frequency (
    user_name varchar NULL,
    avg_time_between_order interval NULL
);