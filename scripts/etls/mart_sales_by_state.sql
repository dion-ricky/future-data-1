INSERT INTO
    public.mart_sales_by_state (
        seller_state_id,
        seller_state,
        sales_count
    )
SELECT 
	seller_state_id,
	seller_state,
	count(DISTINCT sales_count) AS sales_count
FROM 
	fact_seller_state fss 
GROUP BY 1,2
ORDER BY 3 DESC;