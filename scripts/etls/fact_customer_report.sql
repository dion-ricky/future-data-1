INSERT INTO warehouse.fact_customer_report (
	date_id,
    location_sk,
    count_user
)

SELECT 
	dd.date_id,
	ld.location_sk,
	count(DISTINCT u.user_name) AS count_user
FROM 
	public."user" u
LEFT JOIN warehouse.location_dim ld ON
	u.customer_zip_code = ld.zip_code AND 
	lower(u.customer_state) = lower(ld.state) AND 
	lower(u.customer_city) = lower(ld.city) 
LEFT JOIN warehouse.date_dim dd ON
	EXTRACT(YEAR FROM current_date) - 1 = dd."year" AND 
	dd."month" = 1 AND dd."date" = 1
GROUP BY 1, 2;