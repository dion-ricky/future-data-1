CREATE SCHEMA
	IF NOT EXISTS
	shipping;

CREATE TABLE
	IF NOT EXISTS
shipping."time" (
	time_id SERIAL PRIMARY KEY,
	"year" SMALLINT,
	"quarter" SMALLINT,
	"month" SMALLINT,
	"date" DATE
);

CREATE TABLE
	IF NOT EXISTS
shipping.seller (
  seller_id SERIAL PRIMARY KEY,
  seller_zip_code VARCHAR,
  seller_city VARCHAR,
  seller_state VARCHAR
);

CREATE TABLE
	IF NOT EXISTS
shipping.customer (
  customer_id SERIAL PRIMARY KEY,
  user_name VARCHAR NOT NULL,
  customer_zip_code VARCHAR,
  customer_city VARCHAR,
  customer_state VARCHAR
);

CREATE TABLE
	IF NOT EXISTS
shipping.shipping_fact (
	shipping_fact_id SERIAL PRIMARY KEY,
	time_id INTEGER,
	seller_id INTEGER,
	customer_id INTEGER,
	order_id VARCHAR,
	shipping_cost FLOAT8,
	shipping_time INTEGER,
	estimated_delivery_accuracy INTEGER,
	pickup_time INTEGER,
	shipping_cost_ratio FLOAT8,
	FOREIGN KEY (time_id)
		REFERENCES "time"(time_id),
	FOREIGN KEY (seller_id)
		REFERENCES seller(seller_id),
	FOREIGN KEY (customer_id)
		REFERENCES customer(customer_id)
);
