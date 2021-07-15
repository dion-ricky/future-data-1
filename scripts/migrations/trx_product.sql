DROP TABLE IF EXISTS public.product CASCADE;

CREATE TABLE public.product (
	product_id varchar NOT NULL,
	product_category varchar NULL,
	product_name_lenght int4 NULL,
	product_description_lenght int4 NULL,
	product_photos_qty int4 NULL,
	product_weight_g float8 NULL,
	product_length_cm float8 NULL,
	product_height_cm float8 NULL,
	product_width_cm float8 NULL,
	CONSTRAINT product_pkey PRIMARY KEY (product_id)
);