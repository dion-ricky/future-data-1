DROP TABLE IF EXISTS public.seller CASCADE;

CREATE TABLE public.seller (
	seller_id varchar NOT NULL,
	seller_zip_code varchar NULL,
	seller_city varchar NULL,
	seller_state varchar NULL,
	CONSTRAINT seller_pkey PRIMARY KEY (seller_id)
);