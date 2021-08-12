DROP TABLE IF EXISTS warehouse.fact_seller_report;

CREATE TABLE warehouse.fact_seller_report (
    location_sk int4,
    count_seller int4 null,
    CONSTRAINT fact_seller_report_pkey PRIMARY KEY(location_sk)
);

ALTER TABLE warehouse.fact_seller_report ADD CONSTRAINT fsr_location_sk_fkey FOREIGN KEY (location_sk) REFERENCES warehouse.location_dim(location_sk);