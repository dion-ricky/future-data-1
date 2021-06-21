DROP TABLE
	IF EXISTS public.mart_product_sales_by_category;

CREATE TABLE public.mart_product_sales_by_category (
	product_master_category varchar NULL,
	product_category varchar NULL,
	total_order int4 NULL
);