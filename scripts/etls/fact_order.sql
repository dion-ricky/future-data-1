INSERT INTO warehouse.fact_order (
    order_date,
    order_time,
    seller_sk,
    user_sk,
    product_sk,
    seller_location_sk,
    customer_location_sk,
    order_status_sk,
    order_count,
    item_count
)

WITH order_date AS (
SELECT
	order_id,
	dd.date_id AS order_date
FROM
	public."order" o
LEFT JOIN warehouse.date_dim dd ON
	date(o.order_date) = dd.full_date ),
order_time AS (
SELECT
	o.order_id,
	td.time_id AS order_time
FROM
	public."order" o
LEFT JOIN warehouse.time_dim td ON
	o.delivered_date :: timestamp :: time = td."time" ),
seller_location AS (
SELECT 
	DISTINCT
	o2.order_id,
	ld.location_sk AS seller_location
FROM 
	public."order" o2 
LEFT JOIN public.order_item oi ON
	o2.order_id = oi.order_id
LEFT JOIN public.seller s ON
	oi.seller_id = s.seller_id
LEFT JOIN warehouse.location_dim ld ON
	s.seller_zip_code = ld.zip_code AND
	lower(s.seller_state) = lower(ld.state) AND
	lower(s.seller_city) = lower(ld.city)
),
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
	RANK = 1
),
customer_location AS (
SELECT
	o2.order_id,
	ld.location_sk AS customer_location
FROM 
	public."order" o2
LEFT JOIN customer_dedup cdp ON
	o2.user_name = cdp.user_name
LEFT JOIN warehouse.location_dim ld ON
	cdp.customer_zip_code = ld.zip_code AND
	lower(cdp.customer_state) = lower(ld.state) AND
	lower(cdp.customer_city) = lower(ld.city)
)
SELECT 
	odt.order_date,
	ott.order_time,
	COALESCE (sd.seller_sk, -1),
	COALESCE (ud.user_sk, -1),
	COALESCE (pd.product_sk, -1),
	COALESCE (slc.seller_location, -1),
	COALESCE (clc.customer_location, -1),
	COALESCE (osd.order_status_sk, -1),
	count(DISTINCT o.order_id) AS order_count,
	count(DISTINCT oi.order_item_id) AS item_count
FROM 
	public."order" o
LEFT JOIN order_date odt ON
	o.order_id = odt.order_id
LEFT JOIN order_time ott ON
	o.order_id = ott.order_id
LEFT JOIN seller_location slc ON
	o.order_id = slc.order_id
LEFT JOIN customer_location clc ON
	o.order_id = clc.order_id
LEFT JOIN warehouse.user_dim ud ON
	o.user_name = ud.user_legacy_id 
LEFT JOIN warehouse.order_status_dim osd ON
	lower(o.order_status) = lower(osd.order_status)
LEFT JOIN public.order_item oi ON
	o.order_id = oi.order_id 
LEFT JOIN warehouse.seller_dim sd ON
	oi.seller_id = sd.seller_legacy_id
LEFT JOIN warehouse.product_dim pd ON
	oi.product_id = pd.product_legacy_id
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8;