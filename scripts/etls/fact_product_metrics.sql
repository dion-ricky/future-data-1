INSERT INTO warehouse.fact_product_metrics (
    product_sk,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)

SELECT 
	pd.product_sk,
	p.product_name_lenght AS product_name_length,
	p.product_description_lenght AS product_description_length,
	p.product_photos_qty,
	p.product_weight_g,
	p.product_length_cm,
	p.product_height_cm,
	p.product_width_cm
FROM 
	warehouse.product_dim pd
LEFT JOIN public.product p ON
	pd.product_legacy_id = p.product_id;