INSERT INTO
    public.mart_shipping_cost_by_state (
        seller_state_id,
        seller_state,
        avg_shipping_cost
    )
SELECT 
	fss.seller_state_id ,
	fss.seller_state ,
	avg(fss.shipping_cost) AS avg_shipping_cost
FROM 
	fact_seller_state fss
GROUP BY 1,2
ORDER BY 3 ASC;