DROP TABLE
    IF EXISTS staging.ext_lat_long_kabko_id;

CREATE TABLE staging.ext_lat_long_kabko_id (
    kabko varchar NULL,
    lat float8 NULL,
    long float8 NULL
);