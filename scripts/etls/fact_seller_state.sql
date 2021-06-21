TRUNCATE TABLE public.mart_seller_by_state
RESTART IDENTITY;

INSERT INTO
    fact_seller_state(
        seller_state_id,
        seller_state,
        order_date,
        seller_key,
        shipping_cost,
        sales_count
    )
SELECT 
	sd.seller_state_id,
	sd.seller_state,
	dd.date_id AS order_date,
	sd.seller_key AS seller_key,
	oid2.shipping_cost AS shipping_cost,
	oid2.order_item_sk AS sales_count
FROM 
	order_item_dim oid2 
LEFT JOIN
	seller_dim sd 
ON oid2.seller_key = sd.seller_key
LEFT JOIN 
	order_dim od 
ON oid2.order_key = od.order_key 
INNER JOIN 
	date_dim dd 
ON date(od.order_date) = dd.full_date;