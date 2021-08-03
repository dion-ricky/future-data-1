INSERT INTO warehouse.product_dim (
    product_key,
    product_master_category,
    product_category,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)

SELECT
	product_id AS product_key,
	tmc.master_category AS product_master_category,
	product_category,
	product_name_lenght,
	product_description_lenght,
	product_photos_qty,
	product_weight_g,
	product_length_cm,
	product_height_cm,
	product_width_cm
FROM
	public.product
LEFT JOIN warehouse.temp_master_category tmc ON
	product_category = tmc.category;