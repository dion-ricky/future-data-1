INSERT INTO
	mart_product_sales_by_category(
		product_master_category,
		product_category,
		total_order
	)
SELECT
	COALESCE(product_master_category, 'All Category') AS product_master_category,
	COALESCE(product_category, 'All Subcategory') AS product_category,
	total_order
FROM (
	SELECT 
		COALESCE(pd.product_master_category, 'NA') AS product_master_category ,
		COALESCE(pd.product_category, 'NA') AS product_category ,
		SUM(fpp.total_order) AS total_order
	FROM
		fact_product_sales fpp 
	LEFT JOIN
		product_dim pd 
	ON pd.product_sk = fpp.product_sk
	GROUP BY ROLLUP(1,2)
)AS f;