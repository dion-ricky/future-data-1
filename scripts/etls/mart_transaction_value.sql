TRUNCATE public.mart_transaction_value
RESTART IDENTITY;

INSERT INTO public.mart_transaction_value (
    state_id,
    "state",
    avg_spending,
    highest_spending,
    lowest_spending,
    pdrb_2020
)

SELECT
	fcmv.state_id,
	fcmv.state,
	avg_spending,
	highest_spending,
	lowest_spending,
	epi.pdrb_2020
FROM
	fact_customer_monetary_value fcmv
LEFT JOIN ext_pdrb_id epi ON
	lower(trim(fcmv.state)) = lower(trim(epi.state))
WHERE
	user_sk IS NULL
	AND state_id IS NOT NULL
ORDER BY
	avg_spending DESC;