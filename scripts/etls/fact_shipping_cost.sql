TRUNCATE warehouse.fact_shipping_cost;

INSERT INTO warehouse.fact_shipping_cost (
	order_legacy_id,
    order_date,
    order_time,
    product_sk,
    seller_sk,
    seller_location_sk,
    customer_location_sk,
	item_id,
    price,
    shipping_cost
)

WITH order_date AS (
SELECT
	o.order_id,
	dd.date_id AS order_date
FROM
	public."order" o
LEFT JOIN warehouse.date_dim dd ON
	date(o.order_date) = date(dd.full_date) ),
order_time AS (
SELECT
	o.order_id,
	td.time_id AS order_time
FROM
	public."order" o
LEFT JOIN warehouse.time_dim td ON
	o.order_date :: timestamp :: time = td."time" ),
seller_location AS (
SELECT
	DISTINCT 
	oi.seller_id,
	ld.location_sk AS seller_location_sk
FROM
	public."order" o2
LEFT JOIN public.order_item oi ON
	o2.order_id = oi.order_id
LEFT JOIN public.seller s ON
	oi.seller_id = s.seller_id
LEFT JOIN warehouse.location_dim ld ON
	s.seller_zip_code = ld.zip_code
	AND lower(s.seller_state) = lower(ld.state)
		AND lower(s.seller_city) = lower(ld.city) ),
customer_dedup AS (
SELECT
	user_name,
	customer_zip_code,
	customer_city,
	customer_state
FROM
	(
	SELECT
		DISTINCT *,
		RANK() OVER( PARTITION BY user_name
	ORDER BY
		customer_zip_code DESC) AS RANK
	FROM
		public.user u ) AS f
WHERE
	RANK = 1 ),
customer_location AS (
SELECT
	o2.order_id,
	ld.location_sk AS customer_location_sk
FROM
	public."order" o2
LEFT JOIN customer_dedup cdp ON
	o2.user_name = cdp.user_name
LEFT JOIN warehouse.location_dim ld ON
	cdp.customer_zip_code = ld.zip_code
	AND lower(cdp.customer_state) = lower(ld.state)
		AND lower(cdp.customer_city) = lower(ld.city) )
SELECT
	oi.order_id AS order_legacy_id,
	odt.order_date,
	ott.order_time,
	pd.product_sk,
	sd.seller_sk,
	slc.seller_location_sk,
	clc.customer_location_sk,
	oi.order_item_id AS item_id,
	oi.price,
	oi.shipping_cost
FROM
	public.order_item oi
LEFT JOIN order_date odt ON
	oi.order_id = odt.order_id
LEFT JOIN order_time ott ON
	oi.order_id = ott.order_id
LEFT JOIN seller_location slc ON
	oi.seller_id = slc.seller_id
LEFT JOIN public."order" o3 ON
	oi.order_id = o3.order_id
LEFT JOIN customer_location clc ON
	o3.order_id = clc.order_id
LEFT JOIN warehouse.product_dim pd ON
	oi.product_id = pd.product_legacy_id
LEFT JOIN warehouse.seller_dim sd ON
	oi.seller_id = sd.seller_legacy_id;