INSERT INTO
    public.mart_shipping_cost_by_city (
        city,
        min_shipping_cost,
        max_shipping_cost,
        avg_shipping_cost
    )
SELECT 
	city,
	min_shipping_cost,
	max_shipping_cost,
	avg_shipping_cost
FROM 
	fact_shipping_cost fsc
WHERE
	city != 'Semua KabKo' AND
	state_id IS NOT NULL;