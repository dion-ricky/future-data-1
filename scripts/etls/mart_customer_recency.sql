TRUNCATE public.mart_customer_recency
RESTART IDENTITY;

WITH lod AS (
SELECT
	max(od.order_date) + INTERVAL '1' DAY AS last_order_date
FROM
	order_dim od ),
clean_order AS (
SELECT
	*
FROM
	order_dim od2
WHERE
	lower(trim(order_status)) NOT IN ('unavailable', 'canceled', 'created') )

INSERT INTO
	public.mart_customer_recency ( user_name,
	last_order_interval )

SELECT
	f.user_name,
	lod.last_order_date - f.last_order AS last_order_interval
FROM
	(
	SELECT
		ud.user_name,
		max(od.order_date) AS last_order
	FROM
		clean_order od
	LEFT JOIN user_dim ud ON
		od.user_name = ud.user_name
	GROUP BY
		1 ) AS f,
	lod;