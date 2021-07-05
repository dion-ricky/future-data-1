INSERT INTO
    public.mart_shipping_cost_by_state (
        seller_state_id,
        seller_state,
        min_shipping_cost,
        max_shipping_cost,
        avg_shipping_cost
    )
SELECT
	state_id,
	state,
	min_shipping_cost,
	max_shipping_cost,
	avg_shipping_cost
FROM
	fact_shipping_cost fsc
WHERE
	lower(trim(city)) = 'semua kabko'
	AND state_id IS NOT NULL;