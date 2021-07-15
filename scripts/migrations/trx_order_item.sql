DROP TABLE IF EXISTS public.order_item CASCADE;

CREATE TABLE public.order_item (
	order_id varchar NOT NULL,
	order_item_id int4 NOT NULL,
	product_id varchar NULL,
	seller_id varchar NULL,
	pickup_limit_date timestamp NULL,
	price float8 NULL,
	shipping_cost float8 NULL,
	CONSTRAINT order_item_pkey PRIMARY KEY (order_id, order_item_id)
);

ALTER TABLE public.order_item ADD CONSTRAINT order_item_order_id_fkey FOREIGN KEY (order_id) REFERENCES public."order"(order_id);
ALTER TABLE public.order_item ADD CONSTRAINT order_item_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id);
ALTER TABLE public.order_item ADD CONSTRAINT order_item_seller_id_fkey FOREIGN KEY (seller_id) REFERENCES public.seller(seller_id);