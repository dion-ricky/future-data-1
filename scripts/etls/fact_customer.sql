TRUNCATE public.fact_customer;

INSERT INTO public.fact_customer (
    pulau,
    customer_state_id,
    customer_state,
    customer_city,
    customer_count
)
SELECT
	tpp.pulau,
	ud.customer_state_id,
	COALESCE(ud.customer_state, 'Semua Provinsi') AS customer_state,
	COALESCE(ud.customer_city, 'Semua KabKo') AS customer_city,
	count(DISTINCT user_sk) AS customer_count
FROM 
	user_dim ud
LEFT JOIN
	temp_provinsi_pulau tpp
ON lower(trim(ud.customer_state)) = lower(trim(tpp.provinsi))
GROUP BY 1, ROLLUP((ud.customer_state_id, ud.customer_state), ud.customer_city);