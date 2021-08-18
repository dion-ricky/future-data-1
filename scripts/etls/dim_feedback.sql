INSERT INTO warehouse.feedback_dim (
    feedback_legacy_id,
    order_legacy_id,
    feedback_form_sent_date,
    feedback_answer_date,
    scd_start,
    scd_end,
    scd_active
)

SELECT 
	feedback_id AS feedback_legacy_id,
    order_id AS order_legacy_id,
    feedback_form_sent_date,
    feedback_answer_date,
    feedback_answer_date AS scd_start,
    NULL AS scd_end,
    TRUE AS scd_active
FROM
	public.feedback f;