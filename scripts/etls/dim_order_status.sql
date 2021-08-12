INSERT INTO warehouse.order_status_dim(
    order_status_sk,
    order_status
)

WITH order_status AS (
SELECT
	DISTINCT order_status
FROM
	public."order" o )
SELECT
	ROW_NUMBER () OVER(
	ORDER BY 1) AS order_status_sk,
	*
FROM
	order_status os;

-- Null order_status
INSERT INTO warehouse.order_status_dim(
    order_status_sk,
    order_status
)
VALUES (-1, NULL);