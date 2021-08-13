INSERT INTO warehouse.fact_socio_economy (
    date_id,
    location_sk,
    state_area,
    state_pop_per_square_km,
    state_population_est,
    state_budget_est,
    state_pdrb_est,
    state_pdrb_per_capita_est,
    state_ipm_est
)

SELECT
	dd.date_id,
	ld.location_sk,
	epp.luas_total AS state_area,
	epp.populasi_per_luas AS state_pop_per_square_km,
	epp.populasi_2020 AS state_population_est,
	(epp.apbd_2020 * 1000) AS state_budget_est,
	(epp.pdrb_2020 * 1000000) AS state_pdrb_est,
	epp.pdrb_per_kapita_2020 AS state_pdrb_per_capita_est,
	epp.ipm_2020 AS state_ipm_est
FROM 
	warehouse.location_dim ld
LEFT JOIN staging.ext_provinsi_pulau epp ON
	lower(ld.state_iso) = lower(epp.iso)
LEFT JOIN warehouse.date_dim dd ON
	EXTRACT(YEAR FROM current_date) - 1 = dd."year" AND 
	dd."month" = 1 AND dd."date" = 1;