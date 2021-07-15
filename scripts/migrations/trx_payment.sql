DROP TABLE IF EXISTS public.payment CASCADE;

CREATE TABLE public.payment (
	order_id varchar NOT NULL,
	payment_sequential int4 NOT NULL,
	payment_type varchar NULL,
	payment_installments int4 NULL,
	payment_value float8 NULL,
	CONSTRAINT payment_pkey PRIMARY KEY (order_id, payment_sequential)
);

ALTER TABLE public.payment ADD CONSTRAINT payment_order_id_fkey FOREIGN KEY (order_id) REFERENCES public."order"(order_id);