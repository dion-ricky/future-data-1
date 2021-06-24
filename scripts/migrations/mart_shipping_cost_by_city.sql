DROP TABLE
    IF EXISTS public.mart_shipping_cost_by_city;

CREATE TABLE
    public.mart_shipping_cost_by_city (
        city varchar NULL,
        min_shipping_cost float8 NULL,
        max_shipping_cost float8 NULL,
        avg_shipping_cost float8 NULL
    );