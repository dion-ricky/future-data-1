DROP TABLE IF EXISTS public.mart_customer_loyalty;

CREATE TABLE public.mart_customer_loyalty (
    state_id int4 NULL,
    order_date int8 NULL,
    count_user int4 NULL,
    avg_order_count int4 NULL,
    avg_spending float8 NULL,
    avg_time_between_order interval NULL,
    avg_day_between_order float8 NULL
);