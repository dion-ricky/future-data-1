TRUNCATE public.mart_customer_order_frequency
RESTART IDENTITY;

WITH clean_order AS (
SELECT
	*
FROM
	order_dim od2
WHERE
	lower(trim(order_status)) NOT IN ('unavailable', 'canceled', 'created') ),
user_ordered_more_than_once AS (
SELECT
	co.user_name
FROM
	clean_order co
GROUP BY
	1
HAVING
	count(DISTINCT co.order_key) > 1 )

INSERT INTO public.mart_customer_order_frequency (
	user_name,
	order_count,
	avg_time_between_order
)

SELECT
	e.user_name,
	e.order_count,
	COALESCE (g.avg_time_between_order,
	make_interval(0)) AS avg_time_between_order
FROM
	(
	SELECT
		co.user_name,
		count(DISTINCT co.order_sk) AS order_count
	FROM
		clean_order co
	GROUP BY
		co.user_name ) e
LEFT JOIN (
	SELECT
		f.user_name,
		AVG(f.order_date - f.prev_order_date) AS avg_time_between_order
	FROM
		(
		SELECT
			user_name,
			order_date,
			LAG(order_date) OVER(PARTITION BY user_name
		ORDER BY
			order_date) AS prev_order_date
		FROM
			clean_order
		WHERE
			user_name IN (
			SELECT
				*
			FROM
				user_ordered_more_than_once) ) AS f
	GROUP BY
		f.user_name )g ON
	e.user_name = g.user_name;