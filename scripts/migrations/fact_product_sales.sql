DROP TABLE
	IF EXISTS warehouse.fact_product_sales;

CREATE TABLE warehouse.fact_product_sales (
	order_legacy_id varchar,
	order_item_legacy_id int4,
	order_date int4,
	product_sk int4,
	user_sk int4,
	seller_sk int4,
	customer_location_sk int4,
	seller_location_sk int4,
	price float8 NULL,
	shipping_cost float8 NULL,
	CONSTRAINT fact_product_sales_pkey PRIMARY KEY (order_legacy_id, order_item_legacy_id,
													order_date, product_sk, user_sk, seller_sk,
													customer_location_sk, seller_location_sk)
);

-- public.fct_penjualan_produk foreign keys
ALTER TABLE warehouse.fact_product_sales
	ADD CONSTRAINT fact_product_sales_product_sk_fkey
		FOREIGN KEY (product_sk) REFERENCES warehouse.product_dim(product_sk);

ALTER TABLE warehouse.fact_product_sales
	ADD CONSTRAINT fact_product_sales_order_date_fkey
		FOREIGN KEY (order_date) REFERENCES warehouse.date_dim(date_id);

ALTER TABLE warehouse.fact_product_sales
	ADD CONSTRAINT fact_product_sales_user_sk_fkey
		FOREIGN KEY (user_sk) REFERENCES warehouse.user_dim(user_sk);

ALTER TABLE warehouse.fact_product_sales
	ADD CONSTRAINT fact_product_sales_seller_sk_fkey
		FOREIGN KEY (seller_sk) REFERENCES warehouse.seller_dim(seller_sk);

ALTER TABLE warehouse.fact_product_sales
	ADD CONSTRAINT fact_product_sales_customer_location_sk_fkey
		FOREIGN KEY (customer_location_sk) REFERENCES warehouse.location_dim(location_sk);

ALTER TABLE warehouse.fact_product_sales
	ADD CONSTRAINT fact_product_sales_seller_location_sk_fkey
		FOREIGN KEY (seller_location_sk) REFERENCES warehouse.location_dim(location_sk);