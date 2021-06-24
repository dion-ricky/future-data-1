INSERT INTO public.mart_order_by_state (
    pulau,
    state_id,
    "state",
    order_count
)
SELECT 
	pulau,
	state_id,
	"state",
	order_count
FROM 
	fact_order_geo fog 
WHERE
	fog.city IS NULL AND
	fog.order_date IS NULL AND
	fog.state IS NOT NULL;