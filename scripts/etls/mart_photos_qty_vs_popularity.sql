TRUNCATE warehouse.mart_photos_qty_vs_popularity;

INSERT INTO warehouse.mart_photos_qty_vs_popularity (
    popularity,
    product_master_category,
    avg_photos_qty
)

WITH product_sales AS (
SELECT
	fps.product_sk ,
	count(DISTINCT fps.order_legacy_id) AS total_order
FROM
	warehouse.fact_product_sales fps
WHERE
	fps.product_sk NOT IN (-1)
GROUP BY
	1 )
SELECT
	'Most popular'::varchar AS popularity,
	g.product_master_category,
	avg(g.product_photos_qty) AS avg_photos_qty
FROM
	(
	SELECT 
		f.*
	FROM
		(
		SELECT
			ROW_NUMBER() OVER (PARTITION BY pd.product_master_category
		ORDER BY
			ps.total_order DESC) AS window_row_number,
			pd.product_sk,
			pd.product_master_category,
			fpm.product_photos_qty,
			ps.total_order
		FROM
			product_sales ps
		LEFT JOIN warehouse.product_dim pd ON
			ps.product_sk = pd.product_sk
		LEFT JOIN warehouse.fact_product_metrics fpm ON
			ps.product_sk = fpm.product_sk	
		WHERE pd.product_master_category IS NOT NULL
		) f
	WHERE f.window_row_number <= 10 ) g
GROUP BY g.product_master_category
UNION
SELECT
	'Least popular'::varchar AS popularity,
	g.product_master_category,
	avg(g.product_photos_qty) AS avg_photos_qty
FROM
	(
	SELECT 
		f.*
	FROM
		(
		SELECT
			ROW_NUMBER() OVER (PARTITION BY pd.product_master_category
		ORDER BY
			ps.total_order) AS window_row_number,
			pd.product_sk,
			pd.product_master_category,
			fpm.product_photos_qty,
			ps.total_order
		FROM
			product_sales ps
		LEFT JOIN warehouse.product_dim pd ON
			ps.product_sk = pd.product_sk
		LEFT JOIN warehouse.fact_product_metrics fpm ON
			ps.product_sk = fpm.product_sk	
		WHERE pd.product_master_category IS NOT NULL
		) f
	WHERE f.window_row_number <= 10 ) g
GROUP BY g.product_master_category;