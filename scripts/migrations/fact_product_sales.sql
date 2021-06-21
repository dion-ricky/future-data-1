DROP TABLE
	IF EXISTS public.fact_product_sales;

CREATE TABLE public.fact_product_sales (
	product_sales_id serial,
	product_sk int4 NULL,
	order_date int4 NULL,
	avg_shipping_cost float8 NULL,
	min_shipping_cost float8 NULL,
	max_shipping_cost float8 NULL,
	avg_price float8 NULL,
	min_price float8 NULL,
	max_price float8 NULL,
	total_order int4 NULL,
	CONSTRAINT fact_product_sales_pkey PRIMARY KEY (product_sales_id)
);

-- public.fct_penjualan_produk foreign keys
ALTER TABLE public.fact_product_sales
	ADD CONSTRAINT fact_product_sales_product_sk_fkey
		FOREIGN KEY (product_sk) REFERENCES public.product_dim(product_sk);

ALTER TABLE public.fact_product_sales
	ADD CONSTRAINT fact_product_sales_order_date_fkey
		FOREIGN KEY (order_date) REFERENCES public.date_dim(date_id);