INSERT INTO warehouse.seller_dim (
    seller_key,
    seller_zip_code,
    seller_city,
    seller_state,
    seller_state_id
)

SELECT
    seller_id AS seller_key,
    seller_zip_code,
    seller_city,
    seller_state,
	tig.id_1 AS seller_state_id
FROM
    public.seller
LEFT JOIN warehouse.temp_indonesia_geoprops tig ON
	lower(trim(seller_state)) = lower(trim(tig.state));