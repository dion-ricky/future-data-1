INSERT INTO public.mart_customer_loyalty (
    state_id,
    order_date,
    count_user,
    avg_order_count,
    avg_spending,
    avg_time_between_order,
    avg_day_between_order
)

SELECT
	f.customer_state_id AS state_id,
	f.order_date,
	count(DISTINCT f.user_sk) AS count_user,
	avg(f.order_count) AS avg_order_count,
	avg(fcmv.avg_spending) AS avg_spending,
	avg(mcof.avg_time_between_order) AS avg_time_between_order,
	avg(EXTRACT(epoch FROM mcof.avg_time_between_order / 86400)) AS avg_day_between_order
FROM
	(
	SELECT
		ud.*,
		fctc.order_date,
		fctc.order_count
	FROM
		fact_customer_transaction_count fctc
	LEFT JOIN user_dim ud ON
		ud.user_name = fctc.user_name
	WHERE
		fctc.user_name IS NOT NULL
		AND fctc.order_date <> 0
		AND fctc.order_count > 1 ) f
LEFT JOIN (
	SELECT
		*
	FROM
		fact_customer_monetary_value
	WHERE
		order_date IS NULL ) fcmv ON
	f.user_sk = fcmv.user_sk
LEFT JOIN mart_customer_order_frequency mcof ON
	f.user_name = mcof.user_name
GROUP BY
	f.customer_state_id,
	ROLLUP(f.order_date);