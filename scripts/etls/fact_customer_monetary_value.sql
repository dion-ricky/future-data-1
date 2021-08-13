TRUNCATE warehouse.fact_customer_monetary_value
RESTART IDENTITY;

INSERT INTO warehouse.fact_customer_monetary_value (
	order_legacy_id,
    order_date,
    order_time,
    location_sk,
    user_sk,
    total_spending,
    total_shipping_cost
)

WITH fact_order_clean AS (
SELECT
	*
FROM
	warehouse.fact_order fo
WHERE
	fo.order_status_sk NOT IN (-1, 2, 8) ),
fact_order_dedup AS (
SELECT
	order_date,
	order_time,
	order_legacy_id,
	seller_sk,
	user_sk,
	product_sk,
	seller_location_sk,
	customer_location_sk,
	order_status_sk,
	item_count
FROM
	(
	SELECT
		foc.*,
		ROW_NUMBER () OVER (PARTITION BY foc.order_legacy_id
	ORDER BY
		foc.order_status_sk DESC) AS status_rank
	FROM
		fact_order_clean foc ) f
WHERE
	status_rank = 1 )
SELECT
	fod.order_legacy_id,
	fod.order_date,
	fod.order_time,
	ld.location_sk,
	fod.user_sk,
	ts.total_spending,
	ts.total_shipping_cost
FROM
	fact_order_dedup fod
LEFT JOIN (
	SELECT
		fsc.order_legacy_id,
		sum(fsc.price) AS total_spending,
		sum(fsc.shipping_cost) AS total_shipping_cost
	FROM
		warehouse.fact_shipping_cost fsc
	GROUP BY
		1) ts ON
	fod.order_legacy_id = ts.order_legacy_id
LEFT JOIN warehouse.location_dim ld ON
	fod.customer_location_sk = ld.location_sk;