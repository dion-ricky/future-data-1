DROP TABLE
    IF EXISTS staging.ext_provinsi_pulau;

CREATE TABLE staging.ext_provinsi_pulau (
    pulau varchar NULL,
    provinsi varchar NULL,
    iso varchar(10) NULL,
    ibukota varchar NULL,
    tanggal_diresmikan varchar NULL,
    populasi_2020 float8 NULL, -- FACT
    luas_total float8 NULL, -- FACT
    populasi_per_luas float8 NULL, -- FACT
    apbd_2020 float8 NULL, -- FACT
    pdrb_2020 float8 NULL, -- FACT
    pdrb_per_kapita_2020 float8 NULL, -- FACT
    ipm_2020 float8 NULL, -- FACT
    agama_2020 varchar NULL,
    flag varchar NULL
);