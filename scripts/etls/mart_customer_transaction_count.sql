INSERT INTO public.mart_customer_transaction_count (
    user_name,
    order_count
)
SELECT 
	od.user_name,
	count(DISTINCT od.order_key) AS order_count
FROM 
	order_dim od 
GROUP BY 1
ORDER BY 2 DESC;