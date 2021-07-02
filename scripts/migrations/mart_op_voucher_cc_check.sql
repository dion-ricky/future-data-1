DROP TABLE
    IF EXISTS public.mart_op_voucher_cc_check;

CREATE TABLE public.mart_op_voucher_cc_check (
    order_sk int8 NULL,
    is_using_voucher boolean NULL,
    is_using_credit_card boolean NULL
);