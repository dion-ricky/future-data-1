WITH lod AS (
	SELECT 
		max(od.order_date) + INTERVAL '1' DAY AS last_order_date
	FROM 
		order_dim od 
)

INSERT INTO public.mart_customer_recency (
    user_sk,
    last_order_interval
)

SELECT 
	f.user_sk,
	lod.last_order_date - f.last_order AS last_order_interval
FROM (
	SELECT 
		ud.user_sk,
		max(od.order_date) AS last_order
	FROM 
		order_dim od
	LEFT JOIN
		user_dim ud
	ON od.user_name = ud.user_name 
	GROUP BY 1
) AS f, lod;