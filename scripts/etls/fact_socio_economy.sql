INSERT INTO warehouse.fact_socio_economy (
    date_id,
    state_id,
    state_area,
    state_pop_per_square_km,
    state_population_est,
    state_budget_est,
    state_pdrb_est,
    state_pdrb_per_capita_est,
    state_ipm_est
)

WITH dedupe_state AS (
SELECT 
	DISTINCT state_iso,
	state_id,
	state
FROM 
	warehouse.location_dim ld
WHERE state_id IS NOT NULL
)
SELECT
	dd.date_id,
	ds.state_id,
	epp.luas_total AS state_area,
	epp.populasi_per_luas AS state_pop_per_square_km,
	epp.populasi_2020 AS state_population_est,
	(epp.apbd_2020 * 1000) AS state_budget_est,
	(epp.pdrb_2020 * 1000000) AS state_pdrb_est,
	epp.pdrb_per_kapita_2020 AS state_pdrb_per_capita_est,
	epp.ipm_2020 AS state_ipm_est
FROM 
	dedupe_state ds
LEFT JOIN staging.ext_provinsi_pulau epp ON
	lower(ds.state_iso) = lower(epp.iso)
LEFT JOIN warehouse.date_dim dd ON
	EXTRACT(YEAR FROM current_date) - 1 = dd."year" AND 
	dd."month" = 1 AND dd."date" = 1;