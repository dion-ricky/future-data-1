INSERT INTO warehouse.fact_customer_report (
    location_sk,
    count_user
)

SELECT 
	ld.location_sk,
	count(DISTINCT u.user_name) AS count_user
FROM 
	public."user" u
LEFT JOIN warehouse.location_dim ld ON
	u.customer_zip_code = ld.zip_code AND 
	lower(u.customer_state) = lower(ld.state) AND 
	lower(u.customer_city) = lower(ld.city) 
GROUP BY 1;