DROP TABLE
    IF EXISTS public.ext_penetrasi_internet_state;

CREATE TABLE
    public.ext_penetrasi_internet_state (
        wilayah varchar NULL,
        kontribusi_penetrasi_internet float8 NULL
    );