DROP TABLE IF EXISTS public."user" CASCADE;

CREATE TABLE public."user" (
	user_name varchar NOT NULL,
	customer_zip_code varchar NULL,
	customer_city varchar NULL,
	customer_state varchar NULL
);