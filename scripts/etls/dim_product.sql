INSERT INTO warehouse.product_dim (
	product_sk,
    product_key,
    product_master_category,
    product_category
)

WITH temp_product AS (
SELECT
	p.product_id AS product_key,
	emc.master_category AS product_master_category,
	p.product_category
FROM
	public.product p
LEFT JOIN staging.ext_master_category emc ON
	lower(p.product_category) = lower(emc.category) )
SELECT
	ROW_NUMBER() OVER (
	ORDER BY 1) AS product_sk,
	tp.*
FROM
	temp_product tp;