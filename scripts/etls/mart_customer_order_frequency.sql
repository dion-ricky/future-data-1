WITH clean_order AS (
	SELECT 
		*
	FROM order_dim od2 
	WHERE lower(trim(order_status)) NOT IN ('unavailable', 'canceled')
),
user_ordered_more_than_once AS (
	SELECT 
		co.user_name
	FROM 
		clean_order co
	GROUP BY 1
	HAVING count(DISTINCT co.order_key) > 1
)

INSERT INTO public.mart_customer_order_frequency (
	user_name,
	avg_time_between_order
)

SELECT 
	f.user_name,
	AVG(f.order_date - f.prev_order_date) AS avg_time_between_order
FROM (
	SELECT
		user_name,
		order_date,
		LAG(order_date) OVER(PARTITION BY user_name ORDER BY order_date) AS prev_order_date
	FROM 
		clean_order
	WHERE
		user_name IN (SELECT * FROM user_ordered_more_than_once)
) AS f
GROUP BY f.user_name;