TRUNCATE warehouse.fact_product_sales
RESTART IDENTITY;

INSERT INTO warehouse.fact_product_sales(
    order_legacy_id,
	order_item_id,
	order_date,
	product_sk,
	price,
	shipping_cost
)

SELECT 
	fo.order_legacy_id,
	oi.order_item_id,
	fo.order_date,
	pd.product_sk,
	oi.price,
	oi.shipping_cost
FROM 
	warehouse.product_dim pd
LEFT JOIN public.order_item oi ON
	pd.product_legacy_id = oi.product_id
LEFT JOIN warehouse.fact_order fo ON
	oi.order_id = fo.order_legacy_id;