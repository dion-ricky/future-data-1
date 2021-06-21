INSERT INTO
	mart_shipping_cost_by_category(
		product_master_category,
		product_category,
		avg_shipping_cost,
		min_shipping_cost,
		max_shipping_cost,
		avg_price,
		min_price,
		max_price
	)
SELECT 
	COALESCE(product_master_category, 'All Category') AS product_master_category ,
	COALESCE(product_category, 'All Subcategory') AS product_category ,
	avg_shipping_cost, min_shipping_cost,
	max_shipping_cost, avg_price, min_price,
	max_price
FROM (
	SELECT 
		COALESCE(pd.product_master_category,'NA') AS product_master_category ,
		COALESCE(pd.product_category,'NA') AS product_category,
		AVG(avg_shipping_cost) AS avg_shipping_cost,
		MIN(min_shipping_cost) AS min_shipping_cost,
		MAX(max_shipping_cost) AS max_shipping_cost,
		AVG(avg_price) AS avg_price,
		MIN(min_price) AS min_price,
		MAX(max_price) AS max_price 
	FROM
		fact_product_sales fpp 
	LEFT JOIN
		product_dim pd 
	ON pd.product_sk = fpp.product_sk 
	GROUP BY ROLLUP(1,2)
) AS f
ORDER BY 1,2;