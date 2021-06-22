DROP TABLE
    IF EXISTS public.fact_average_customer_spending;

CREATE TABLE public.fact_average_customer_spending (
    state_id int4 NULL,
    "state" varchar NULL,
    order_date int4 NULL,
    avg_spending float8 NULL,
    highest_spending float8 NULL,
    lowest_spending float8 NULL,
    avg_shipping_cost_vs_price_ratio float8 NULL
);