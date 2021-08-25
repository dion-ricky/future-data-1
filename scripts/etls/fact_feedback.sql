INSERT INTO warehouse.fact_feedback (
	feedback_answer_date,
	feedback_sk,
    order_legacy_id,
    is_using_voucher,
    response_time,
    feedback_score
)

WITH feedback_active AS (
SELECT
	*
FROM
	warehouse.feedback_dim fd
WHERE
	fd.scd_active ),
op_check_voucher AS (
SELECT
	o.order_id,
	cv.is_using_voucher
FROM
	public."order" o
LEFT JOIN LATERAL (
	SELECT
		CASE
			WHEN count(DISTINCT p.payment_sequential) > 0 THEN TRUE
			ELSE FALSE
		END AS is_using_voucher
	FROM
		public.payment p
	WHERE
		p.order_id = o.order_id
		AND lower(p.payment_type) = 'voucher' ) AS cv ON
	TRUE ),
feedback_answer_date AS (
SELECT
	fd.feedback_legacy_id,
	dd.date_id AS feedback_answer_date
FROM
	warehouse.feedback_dim fd
LEFT JOIN warehouse.date_dim dd ON
	date(fd.feedback_answer_date) = dd.full_date
WHERE
	fd.scd_active ),
feedback_dedup AS (
SELECT
	feedback_id,
	order_id,
	feedback_score,
	feedback_form_sent_date,
	feedback_answer_date
FROM
	(
	SELECT
		ROW_NUMBER() OVER (PARTITION BY f.feedback_id,
		f.order_id
	ORDER BY
		f.feedback_answer_date DESC) AS window_fn_id,
		f.*
	FROM
		public.feedback f ) g
WHERE
	window_fn_id = 1 )
SELECT
	fad.feedback_answer_date,
	fa.feedback_sk,
	fa.order_legacy_id,
	ocv.is_using_voucher,
	fa.feedback_answer_date - fa.feedback_form_sent_date AS response_time,
	f.feedback_score
FROM
	feedback_active fa
LEFT JOIN feedback_answer_date fad ON
	fa.feedback_legacy_id = fad.feedback_legacy_id
LEFT JOIN feedback_dedup f ON
	fa.order_legacy_id = f.order_id
	AND fa.feedback_legacy_id = f.feedback_id
LEFT JOIN op_check_voucher ocv ON
	fa.order_legacy_id = ocv.order_id;