DROP TABLE
    IF EXISTS public.temp_provinsi_pulau;

CREATE TABLE public.temp_provinsi_pulau (
    pulau varchar NULL,
    provinsi varchar NULL,
    iso varchar(10) NULL,
    ibukota varchar NULL,
    tanggal_diresmikan varchar NULL,
    populasi_2020 varchar NULL,
    luas_total varchar NULL,
    populasi_per_luas varchar NULL,
    apbd_2020 varchar NULL,
    pdrb_2020 varchar NULL,
    pdrb_per_kapita_2020 varchar NULL,
    ipm_2020 varchar NULL,
    agama_2020 varchar NULL,
    flag varchar NULL
);