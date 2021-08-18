DROP TABLE
	IF EXISTS warehouse.fact_product_sales;

CREATE TABLE warehouse.fact_product_sales (
	product_sales_sk serial,
	order_legacy_id varchar NUlL,
	order_item_id int4 NULL,
	order_date int4 NULL,
	product_sk int4 NULL,
	price float8 NULL,
	shipping_cost float8 NULL,
	CONSTRAINT fact_product_sales_pkey PRIMARY KEY (product_sales_sk)
);

-- public.fct_penjualan_produk foreign keys
ALTER TABLE warehouse.fact_product_sales
	ADD CONSTRAINT fact_product_sales_product_sk_fkey
		FOREIGN KEY (product_sk) REFERENCES warehouse.product_dim(product_sk);

ALTER TABLE warehouse.fact_product_sales
	ADD CONSTRAINT fact_product_sales_order_date_fkey
		FOREIGN KEY (order_date) REFERENCES warehouse.date_dim(date_id);