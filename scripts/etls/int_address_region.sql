INSERT INTO staging.int_address_region (
    state,
    city,
    zip_code
)

SELECT
	DISTINCT customer_state AS state,
	customer_city AS city,
	customer_zip_code AS zip_code
FROM
	public."user" u
UNION
SELECT
	DISTINCT s.seller_state AS state,
	s.seller_city AS city,
	s.seller_zip_code AS zip_code
FROM
	public.seller s ;