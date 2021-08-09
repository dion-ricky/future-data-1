DROP TABLE IF EXISTS warehouse.time_dim;

CREATE TABLE warehouse.time_dim (
    time_id int4 NULL,
    time time NULL,
    hour int4 NULL,
    minute int4 NULL,
    second int4 NULL
);