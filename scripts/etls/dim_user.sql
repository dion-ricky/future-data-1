INSERT INTO warehouse.user_dim (
    "user_name",
    customer_zip_code,
    customer_city,
    customer_state,
    customer_state_id
)

SELECT
	"user_name",
    customer_zip_code,
    customer_city,
    customer_state,
	tig.id_1 AS customer_state_id
FROM
	public."user" u
LEFT JOIN warehouse.temp_indonesia_geoprops tig ON
	lower(trim(u.customer_state)) = lower(trim(tig.state));