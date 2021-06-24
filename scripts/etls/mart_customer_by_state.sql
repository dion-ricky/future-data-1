INSERT INTO public.mart_customer_by_state (
    customer_state_id,
    customer_state,
    customer_count
)
SELECT 
	customer_state_id,
	customer_state,
	customer_count
FROM 
	fact_customer fc 
WHERE
	fc.customer_city = 'Semua KabKo'
	AND customer_state_id IS NOT NULL
ORDER BY 3 DESC;