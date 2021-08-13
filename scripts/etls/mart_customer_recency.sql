TRUNCATE warehouse.mart_customer_recency
RESTART IDENTITY;

WITH fact_order_clean AS (
SELECT
	*
FROM
	warehouse.fact_order fo
WHERE
	fo.order_status_sk NOT IN (-1, 2, 8) ),
lod AS (
SELECT
	max(dd.full_date) + INTERVAL '1' DAY AS last_order_date
FROM
	warehouse.fact_order fo
LEFT JOIN warehouse.date_dim dd ON
	fo.order_date = dd.date_id )

INSERT INTO warehouse.mart_customer_recency (
	user_sk,
	last_order_interval
)

SELECT
	f.user_sk,
	lod.last_order_date - f.last_order_date AS last_order_interval
FROM
	(
	SELECT
		foc.user_sk,
		max(dd2.full_date) AS last_order_date
	FROM
		fact_order_clean foc
	LEFT JOIN warehouse.date_dim dd2 ON
		foc.order_date = dd2.date_id
	GROUP BY
		1 ) AS f,
	lod ;