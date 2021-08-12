INSERT INTO warehouse.user_dim (
	user_sk,
    user_legacy_id
)

WITH user_name AS (
SELECT
	DISTINCT user_name AS user_legacy_id
FROM
	public."user" u )
SELECT
	ROW_NUMBER () OVER (
	ORDER BY 1) AS user_sk,
	*
FROM
	user_name un;

-- Null user
INSERT INTO warehouse.user_dim (
	user_sk,
    user_legacy_id
)
VALUES (-1, null);