DROP TABLE
	IF EXISTS public.fact_seller_state;
	
CREATE TABLE public.fact_seller_state(
	seller_state_id int4 NULL,
	seller_state varchar NULL,
	order_date int4 NULL,
	seller_count int4 NULL,
	avg_shipping_cost float8 NULL,
	sales_count int4 NULL
);

ALTER TABLE public.fact_seller_state
	ADD CONSTRAINT fact_seller_state_order_date_fkey
		FOREIGN KEY (order_date) REFERENCES public.date_dim(date_id);