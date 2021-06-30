DROP TABLE
    IF EXISTS public.mart_product_photos_qty_comparison_by_popularity;

CREATE TABLE public.mart_product_photos_qty_comparison_by_popularity (
    popularity varchar NULL,
    product_master_category varchar NULL,
    avg_photos_qty float8 NULL
);