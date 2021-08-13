TRUNCATE warehouse.mart_customer_order_frequency
RESTART IDENTITY;

WITH fact_order_clean AS (
SELECT
	*
FROM
	warehouse.fact_order fo
WHERE
	fo.order_status_sk NOT IN (-1, 2, 8) )

INSERT INTO warehouse.mart_customer_order_frequency (
	user_sk,
	count_order
)

SELECT
	foc.user_sk,
	count(DISTINCT foc.order_legacy_id) AS count_order
FROM 
	fact_order_clean foc
GROUP BY 1;