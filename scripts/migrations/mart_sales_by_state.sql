DROP TABLE
    IF EXISTS public.mart_sales_by_state;

CREATE TABLE
    public.mart_sales_by_state (
        seller_state_id int4 NULL,
        seller_state varchar NULL,
        sales_count int4 NULL
    );