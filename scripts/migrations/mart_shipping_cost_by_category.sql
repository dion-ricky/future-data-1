DROP TABLE
	IF EXISTS public.mart_shipping_cost_by_category;

CREATE TABLE public.mart_shipping_cost_by_category (
	product_master_category varchar NULL,
	product_category varchar NULL,
	avg_shipping_cost float8 NULL,
	min_shipping_cost float8 NULL,
	max_shipping_cost float8 NULL,
	avg_price float8 NULL,
	min_price float8 NULL,
	max_price float8 NULL
);