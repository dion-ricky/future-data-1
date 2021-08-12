INSERT INTO warehouse.location_dim (
    location_sk,
    state_id,
    state,
    city,
    zip_code,
    slug,
    cartodb_id,
    country,
    lat,
    long
)

SELECT
	ROW_NUMBER () OVER(
	ORDER BY 1) AS location_sk,
	eig.id_1 AS state_id,
	iar.state,
	iar.city,
	iar.zip_code,
	eig.slug,
	eig.cartodb_id,
	eig.country,
	ellki.lat,
	ellki.long
FROM
	staging.int_address_region iar
LEFT JOIN staging.ext_indonesia_geoprops eig ON
	lower(iar.state) = lower(eig.state)
LEFT JOIN staging.ext_provinsi_pulau epp ON
	lower(iar.state) = lower(epp.provinsi)
LEFT JOIN staging.ext_lat_long_kabko_id ellki ON
	lower(iar.city) = lower(ellki.kabko);

INSERT INTO warehouse.location_dim (
    location_sk,
    state_id,
    state,
    city,
    zip_code,
    slug,
    cartodb_id,
    country,
    lat,
    long
)
VALUES (
	-1,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL
);