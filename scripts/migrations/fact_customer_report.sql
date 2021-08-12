DROP TABLE IF EXISTS warehouse.fact_customer_report;

CREATE TABLE warehouse.fact_customer_report (
    location_sk int4,
    count_user int4 null,
    CONSTRAINT fact_customer_report_pkey PRIMARY KEY (location_sk)
);

ALTER TABLE warehouse.fact_customer_report ADD CONSTRAINT fcr_location_sk_fkey FOREIGN KEY (location_sk) REFERENCES warehouse.location_dim(location_sk);