INSERT INTO fact_product_sales(
    product_sk,
    order_date,
    avg_shipping_cost,
    min_shipping_cost,
    max_shipping_cost,
    avg_price,
    min_price,
    max_price,
    total_order
)
SELECT 
	pd.product_sk AS product_sk,
	dd.date_id AS order_date,
	avg(oid2.shipping_cost) AS avg_shipping_cost,
	min(oid2.shipping_cost) AS min_shipping_cost,
	max(oid2.shipping_cost) AS max_shipping_cost,
	avg(oid2.price) AS avg_price,
	min(oid2.price) AS min_price,
	max(oid2.price) AS max_price,
	count(oid2.product_key) AS total_order
FROM 
	product_dim pd
LEFT JOIN
	order_item_dim oid2 
ON pd.product_key = oid2.product_key 
LEFT JOIN 
	order_dim od 
ON oid2.order_key = od.order_key
INNER JOIN
	date_dim dd
ON date(od.order_date) = dd.full_date 
GROUP BY pd.product_sk, dd.date_id;