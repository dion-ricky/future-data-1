CREATE SCHEMA IF NOT EXISTS warehouse;

DROP TABLE IF EXISTS staging.ext_indonesia_geoprops;

CREATE TABLE staging.ext_indonesia_geoprops (
    cartodb_id smallint null,
    country varchar null,
    id_1 smallint null,
    slug varchar null,
    "state" varchar null
);