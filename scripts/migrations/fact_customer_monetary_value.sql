DROP TABLE
    IF EXISTS public.fact_customer_monetary_value;

CREATE TABLE public.fact_customer_monetary_value (
    state_id int4 NULL,
    "state" varchar NULL,
    user_sk int8 NULL,
    order_date int4 NULL,
    avg_spending float8 NULL,
    highest_spending float8 NULL,
    lowest_spending float8 NULL,
    avg_shipping_cost_vs_price_ratio float8 NULL
);