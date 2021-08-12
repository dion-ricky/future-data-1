INSERT INTO warehouse.fact_seller_report (
    location_sk,
    count_seller
)

SELECT 
	ld.location_sk,
	count(DISTINCT s.seller_id) AS count_seller
FROM 
	public.seller s
LEFT JOIN warehouse.location_dim ld ON
	s.seller_zip_code = ld.zip_code AND 
	lower(s.seller_state) = lower(ld.state) AND 
	lower(s.seller_city) = lower(ld.city) 
GROUP BY 1;