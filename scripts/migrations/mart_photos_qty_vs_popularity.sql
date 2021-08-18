DROP TABLE
    IF EXISTS warehouse.mart_photos_qty_vs_popularity;

CREATE TABLE warehouse.mart_photos_qty_vs_popularity (
    popularity varchar NULL,
    product_master_category varchar NULL,
    avg_photos_qty float8 NULL
);