INSERT INTO warehouse.fact_feedback (
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
WHERE fd.scd_active
),
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
	WHERE p.order_id = o.order_id AND 
		lower(p.payment_type) = 'voucher'
) AS cv ON TRUE
)
SELECT 
	fa.feedback_sk,
	fa.order_legacy_id,
	ocv.is_using_voucher,
	fa.feedback_answer_date - fa.feedback_form_sent_date AS response_time,
	f.feedback_score
FROM 
	feedback_active fa
LEFT JOIN public.feedback f ON
	fa.order_legacy_id = f.order_id AND
	fa.feedback_legacy_id = f.feedback_id 
LEFT JOIN op_check_voucher ocv ON
	fa.order_legacy_id = ocv.order_id;