WITH order_date AS (
	SELECT 
		od.order_key AS order_key,
		dd.date_id AS date_id,
		dd.full_date AS full_date
	FROM 
		order_dim od 
	LEFT JOIN
		date_dim dd 
	ON date(od.order_date) = dd.full_date 
)

INSERT INTO
    public.fact_average_customer_spending (
        state_id,
        "state",
        order_date,
        avg_spending,
        highest_spending,
        lowest_spending,
        avg_shipping_cost_vs_price_ratio
    )

SELECT 
	ud.customer_state_id AS state_id,
	ud.customer_state AS state,
	odt.date_id AS order_date,
	avg(ts.total_spending) AS avg_spending,
	max(ts.total_spending) AS highest_spending,
	min(ts.total_spending) AS lowest_spending,
	avg(ts.shipping_cost_vs_price_ratio) AS avg_shipping_cost_vs_price_ratio
FROM 
	order_dim od 
LEFT JOIN
	(
	SELECT 
		order_key,
		sum(price + shipping_cost) AS total_spending,
		avg(shipping_cost/price) AS shipping_cost_vs_price_ratio
	FROM 
		order_item_dim oid2
	GROUP BY 1
	) AS ts
ON od.order_key = ts.order_key
LEFT JOIN
	user_dim ud 
ON od.user_name = ud.user_name
LEFT JOIN 
	order_date odt
ON od.order_key = odt.order_key
GROUP BY 1,2,3;