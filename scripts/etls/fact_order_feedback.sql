WITH feedback_date AS (
SELECT
	fd2.feedback_key,
	dd2.date_id AS feedback_answer_date
FROM
	feedback_dim fd2
LEFT JOIN date_dim dd2 ON
	date(fd2.feedback_answer_date) = dd2.full_date ),

order_date AS (
SELECT
	od.order_key,
	dd.date_id AS order_date
FROM
	order_dim od
LEFT JOIN date_dim dd ON
	date(od.order_date) = dd.full_date ),

feedback_scd_active AS (
SELECT
	*
FROM
	feedback_dim fd
WHERE
	fd.scd_active )

INSERT INTO public.fact_order_feedback (
    order_date,
    feedback_answer_date,
    order_sk,
    avg_feedback_response_time,
    min_feedback_score,
    max_feedback_score,
    avg_feedback_score
)

SELECT
	odt.order_date,
	fdt.feedback_answer_date,
	od.order_sk,
	avg(fd.feedback_answer_date - fd.feedback_form_sent_date) AS avg_feedback_response_time,
	min(fd.feedback_score) AS min_feedback_score,
	max(fd.feedback_score) AS max_feedback_score,
	avg(fd.feedback_score) AS avg_feedback_score
FROM
	order_dim od
LEFT JOIN feedback_scd_active fd ON
	od.order_key = fd.order_key
LEFT JOIN order_date odt ON
	od.order_key = odt.order_key
LEFT JOIN feedback_date fdt ON
	fd.feedback_key = fdt.feedback_key
GROUP BY
	ROLLUP(odt.order_date,
	fdt.feedback_answer_date,
	od.order_sk);