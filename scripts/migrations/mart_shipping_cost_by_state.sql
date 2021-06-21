DROP TABLE
    IF EXISTS public.mart_shipping_cost_by_state;

CREATE TABLE
    public.mart_shipping_cost_by_state (
        seller_state_id int4 NULL,
        seller_state varchar NULL,
        avg_shipping_cost float8 NULL
    );