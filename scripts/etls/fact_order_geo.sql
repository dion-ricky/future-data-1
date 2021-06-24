TRUNCATE public.fact_order_geo;

WITH order_date AS (
	SELECT 
		dd.date_id AS order_date,
		od.order_key
	FROM 
		order_dim od, date_dim dd
	WHERE DATE(od.order_date) = dd.full_date
)

INSERT INTO public.fact_order_geo (
    pulau,
    state_id,
    "state",
    city,
    order_date,
    order_count
)

SELECT 
	tpp.pulau,
	ud.customer_state_id,
	ud.customer_state,
	ud.customer_city,
	odt.order_date,
	count(DISTINCT od.order_key) AS order_count
FROM 
	order_dim od
LEFT JOIN
	order_date odt
ON od.order_key = odt.order_key
LEFT JOIN
	user_dim ud 
ON od.user_name = ud.user_name
LEFT JOIN 
	temp_provinsi_pulau tpp
ON lower(trim(ud.customer_state)) = lower(trim(tpp.provinsi))
GROUP BY 1, ROLLUP ((ud.customer_state_id, ud.customer_state), ud.customer_city, odt.order_date);