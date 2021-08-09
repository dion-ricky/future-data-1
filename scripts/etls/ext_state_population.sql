INSERT INTO
    staging.fact_state_population (
        state_id,
        "state",
        predicted_population_2020
    )
SELECT
    fss.seller_state_id AS state_id,
    tpp.provinsi AS "state",
    tpp.populasi_2020 AS predicted_population_2020    
FROM
    public.temp_provinsi_pulau tpp
LEFT JOIN
    public.fact_seller_state fss
ON
    lower(trim(tpp.provinsi)) = lower(trim(fss.seller_state))
GROUP BY 1,2,3
ORDER BY 3 DESC;
