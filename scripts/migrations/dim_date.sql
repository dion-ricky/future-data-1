CREATE SCHEMA IF NOT EXISTS warehouse;

DROP TABLE IF EXISTS warehouse.date_dim CASCADE;

CREATE TABLE warehouse.date_dim (
    date_id INT4,
    full_date DATE NULL,
    "date" SMALLINT NULL,
    "month" SMALLINT NULL,
    quarter SMALLINT NULL,
    "year" SMALLINT NULL,
    day_of_week SMALLINT NULL,
    day_name VARCHAR NULL,
    day_abbrev VARCHAR NULL,
    weekday_flag BOOLEAN NULL,
    week_num_in_year SMALLINT NULL,
    month_name VARCHAR NULL,
    month_abbrev VARCHAR NULL,
    yearmo INT4 NULL,
    CONSTRAINT date_dim_pkey PRIMARY KEY(date_id)
);