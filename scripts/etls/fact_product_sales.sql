TRUNCATE warehouse.fact_product_sales
RESTART IDENTITY;

INSERT INTO warehouse.fact_product_sales(
    order_legacy_id,
	order_item_legacy_id,
	order_date,
	product_sk,
	user_sk,
	seller_sk,
	customer_location_sk,
	seller_location_sk,
	price,
	shipping_cost
)

SELECT 
	fo.order_legacy_id,
	oi.order_item_id AS order_item_legacy_id,
	fo.order_date,
	pd.product_sk,
	fo.user_sk,
	fo.seller_sk,
	fo.customer_location_sk,
	fo.seller_location_sk,
	oi.price,
	oi.shipping_cost
FROM 
	warehouse.product_dim pd
LEFT JOIN public.order_item oi ON
	pd.product_legacy_id = oi.product_id
LEFT JOIN warehouse.fact_order fo ON
	oi.order_id = fo.order_legacy_id
	AND pd.product_sk = fo.product_sk
WHERE pd.product_sk <> -1;