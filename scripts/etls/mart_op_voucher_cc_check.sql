TRUNCATE public.mart_op_voucher_cc_check;

INSERT INTO public.mart_op_voucher_cc_check (
    order_sk,
    is_using_voucher,
    is_using_credit_card
)
SELECT
	od.order_sk,
	cv.is_using_voucher,
	ccc.is_using_credit_card
FROM
	order_dim od
LEFT JOIN LATERAL (
	SELECT
		CASE
			WHEN count(DISTINCT pd2.payment_sk) > 0 THEN TRUE
			ELSE FALSE
		END AS is_using_voucher
	FROM
		payment_dim pd2
	WHERE
		pd2.order_key = od.order_key
		AND lower(trim(pd2.payment_type)) = 'voucher' ) AS cv ON
	TRUE
LEFT JOIN LATERAL (
	SELECT
		CASE
			WHEN count(DISTINCT pd2.payment_sk) > 0 THEN TRUE
			ELSE FALSE
		END AS is_using_credit_card
	FROM
		payment_dim pd2
	WHERE
		pd2.order_key = od.order_key
		AND lower(trim(pd2.payment_type)) = 'credit_card' ) AS ccc ON
	TRUE
ORDER BY
	od.order_sk;