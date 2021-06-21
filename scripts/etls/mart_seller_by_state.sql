TRUNCATE TABLE public.mart_seller_by_state
RESTART IDENTITY;

INSERT INTO
    public.mart_seller_by_state (
        seller_state_id,
        seller_state,
        seller_count
    )
SELECT
	seller_state_id,
	seller_state,
	count(distinct seller_key) AS seller_count
FROM 
    fact_seller_state
GROUP BY 1,2
ORDER BY 3 DESC;