DROP TABLE
    IF EXISTS public.ext_lat_long_city_id;

CREATE TABLE public.ext_lat_long_city_id (
    city varchar NULL,
    lat float8 NULL,
    long float8 NULL,
    country varchar NULL,
    country_iso2 varchar NULL,
    admin_name varchar NULL,
    capital varchar NULL,
    pop int8 NULL,
    pop_proper int8 NULL
);