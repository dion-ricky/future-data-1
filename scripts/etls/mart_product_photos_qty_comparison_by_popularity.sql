TRUNCATE public.mart_product_photos_qty_comparison_by_popularity;

INSERT INTO public.mart_product_photos_qty_comparison_by_popularity (
    popularity,
    product_master_category,
    avg_photos_qty
)

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
			ROW_NUMBER() OVER(PARTITION BY pd.product_master_category
		ORDER BY
			fps.total_order DESC) AS window_row_number,
			pd.product_master_category,
			pd.product_key,
			pd.product_photos_qty,
			fps.total_order
		FROM
			fact_product_sales fps
		LEFT JOIN product_dim pd ON
			fps.product_sk = pd.product_sk
		WHERE
			fps.order_date IS NULL
			AND pd.product_master_category IS NOT NULL
		ORDER BY
			pd.product_master_category ) AS f
	WHERE
		f.window_row_number <= 10 ) AS g
GROUP BY
	g.product_master_category
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
			ROW_NUMBER() OVER(PARTITION BY pd.product_master_category
		ORDER BY
			fps.total_order) AS window_row_number,
			pd.product_master_category,
			pd.product_key,
			pd.product_photos_qty,
			fps.total_order
		FROM
			fact_product_sales fps
		LEFT JOIN product_dim pd ON
			fps.product_sk = pd.product_sk
		WHERE
			fps.order_date IS NULL
			AND pd.product_master_category IS NOT NULL
		ORDER BY
			pd.product_master_category ) AS f
	WHERE
		f.window_row_number <= 10 ) AS g
GROUP BY
	g.product_master_category
ORDER BY
	product_master_category,
	popularity DESC;