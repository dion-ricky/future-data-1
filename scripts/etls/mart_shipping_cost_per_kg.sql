WITH shipping_cost_per_kg AS (
SELECT
	sd.seller_state_id AS state_id,
	avg(oid2.shipping_cost / (COALESCE(NULLIF(pd.product_weight_g, 0), 1000) / 1000)) AS shipping_cost_per_kg
FROM
	seller_dim sd
LEFT JOIN order_item_dim oid2 ON
	sd.seller_key = oid2.seller_key
LEFT JOIN product_dim pd ON
	oid2.product_key = pd.product_key
GROUP BY
	1 )

INSERT INTO public.mart_shipping_cost_per_kg (
    state_id,
    state,
    min_shipping_cost,
    max_shipping_cost,
    avg_shipping_cost,
    avg_shipping_cost_per_kg
)

SELECT
	fsc.state_id,
	fsc.state,
	min_shipping_cost,
	max_shipping_cost,
	avg_shipping_cost,
	scpk.shipping_cost_per_kg AS avg_shipping_cost_per_kg
FROM
	fact_shipping_cost fsc
LEFT JOIN shipping_cost_per_kg scpk ON
	fsc.state_id = scpk.state_id
WHERE
	lower(trim(city)) = 'semua kabko'
	AND fsc.state_id IS NOT NULL;