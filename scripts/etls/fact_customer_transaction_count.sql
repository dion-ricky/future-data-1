WITH order_date AS (
	SELECT 
		od.order_key AS order_key,
		dd.date_id AS order_date 
	FROM 
		order_dim od 
	LEFT JOIN
		date_dim dd 
	ON DATE(od.order_date) = dd.full_date
)

INSERT INTO public.mart_customer_transaction_count (
    user_name,
	order_date,
    order_count
)

SELECT
	COALESCE (od.user_name, 'All User') AS user_name,
	COALESCE (odt.order_date, 0) AS order_date,
	count(DISTINCT od.order_key) AS order_count
FROM 
	order_dim od
LEFT JOIN
	order_date odt
ON od.order_key = odt.order_key
GROUP BY CUBE(od.user_name, odt.order_date);