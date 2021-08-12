DROP TABLE IF EXISTS warehouse.time_dim CASCADE;

CREATE TABLE warehouse.time_dim (
    time_id int4 NULL,
    time time NULL,
    hour int4 NULL,
    minute int4 NULL,
    second int4 NULL,
    CONSTRAINT time_dim_pkey PRIMARY KEY(time_id)
);