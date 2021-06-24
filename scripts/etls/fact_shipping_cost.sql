TRUNCATE public.fact_shipping_cost;

INSERT INTO public.fact_shipping_cost (
    pulau,
    state_id,
    "state",
    city,
    min_shipping_cost,
    max_shipping_cost,
    avg_shipping_cost
)
SELECT 
	tpp.pulau,
	sd.seller_state_id AS state_id,
	COALESCE (sd.seller_state, 'Semua Provinsi') AS "state",
	COALESCE (sd.seller_city, 'Semua KabKo') AS city,
	min(oid2.shipping_cost) AS min_shipping_cost,
	max(oid2.shipping_cost) AS max_shipping_cost,
	avg(oid2.shipping_cost) AS avg_shipping_cost
FROM 
	order_item_dim oid2
LEFT JOIN
	seller_dim sd
ON oid2.seller_key = sd.seller_key 
LEFT JOIN 
	temp_provinsi_pulau tpp
ON lower(trim(sd.seller_state)) = lower(trim(tpp.provinsi))
GROUP BY 1, ROLLUP ((sd.seller_state_id, sd.seller_state), sd.seller_city);