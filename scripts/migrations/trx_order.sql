DROP TABLE IF EXISTS public."order" CASCADE;

CREATE TABLE public."order" (
	order_id varchar NOT NULL,
	user_name varchar NULL,
	order_status varchar NULL,
	order_date timestamp NULL,
	order_approved_date timestamp NULL,
	pickup_date timestamp NULL,
	delivered_date timestamp NULL,
	estimated_time_delivery timestamp NULL,
	CONSTRAINT order_pkey PRIMARY KEY (order_id)
);