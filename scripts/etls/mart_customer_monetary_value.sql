INSERT INTO warehouse.mart_customer_monetary_value (
    user_sk,
    total_spending,
    total_shipping_cost
)

SELECT 
	fcmv.user_sk,
	sum(fcmv.total_spending),
	sum(fcmv.total_shipping_cost)
FROM 
	warehouse.fact_customer_monetary_value fcmv
LEFT JOIN warehouse.location_dim ld ON
	fcmv.location_sk = ld.location_sk
GROUP BY 1;