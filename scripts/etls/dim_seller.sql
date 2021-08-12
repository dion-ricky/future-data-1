INSERT INTO warehouse.seller_dim (
	seller_sk,
    seller_legacy_id
)

WITH seller_key AS (
SELECT
	DISTINCT seller_id AS seller_legacy_id
FROM
	public.seller s )
SELECT
	ROW_NUMBER () OVER (
	ORDER BY 1) AS seller_sk,
	*
FROM
	seller_key sk;

-- Null seller
INSERT INTO warehouse.seller_dim (
	seller_sk,
	seller_legacy_id
)
VALUES (-1, null);