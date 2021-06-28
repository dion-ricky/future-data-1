WITH customer_transaction AS (
	SELECT 
		fctc.user_name,
		fctc.order_count
	FROM 
		fact_customer_transaction_count fctc 
	WHERE
		fctc.order_date = 0 AND
		fctc.user_name <> 'All User'
)

INSERT INTO public.mart_customer_transaction_comparison (
    category,
    order_count
)

SELECT 
	'Only 1 order'::varchar AS category,
	sum(order_count) AS order_count 
FROM customer_transaction
WHERE order_count = 1
UNION
SELECT 
	'More than 1 order'::varchar AS category,
	sum(order_count) AS order_count
FROM customer_transaction 
WHERE order_count <> 1;