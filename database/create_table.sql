CREATE TABLE products (
  product_id VARCHAR NOT NULL,
  product_category VARCHAR,
  product_name_lenght INTEGER,
  product_description_lenght INTEGER,
  product_photos_qty INTEGER,
  product_weight_g FLOAT8,
  product_length_cm FLOAT8,
  product_height_cm FLOAT8,
  product_width_cm FLOAT8,
  PRIMARY KEY(product_id)
);

CREATE TABLE "user" (
  user_name VARCHAR NOT NULL,
  customer_zip_code VARCHAR,
  customer_city VARCHAR,
  customer_state VARCHAR,
  PRIMARY KEY(user_name),
  UNIQUE (user_name, customer_zip_code, customer_city, customer_state)
);

CREATE TABLE seller (
  seller_id VARCHAR NOT NULL,
  seller_zip_code VARCHAR,
  seller_city VARCHAR,
  seller_state VARCHAR,
  PRIMARY KEY(seller_id)
);

CREATE TABLE "order" (
  order_id VARCHAR NOT NULL,
  user_name VARCHAR,
  order_status VARCHAR,
  order_date TIMESTAMP,
  order_approved_date TIMESTAMP,
  pickup_date TIMESTAMP,
  delivered_date TIMESTAMP,
  estimated_time_delivery TIMESTAMP,
  PRIMARY KEY(order_id),
  FOREIGN KEY (user_name)
  	REFERENCES "user"(user_name)
);

CREATE TABLE payment (
  order_id VARCHAR NOT NULL,
  payment_sequential INTEGER NOT NULL,
  payment_type VARCHAR,
  payment_installments INTEGER,
  payment_value FLOAT8,
  PRIMARY KEY(order_id, payment_sequential),
  FOREIGN KEY (order_id)
  	REFERENCES "order"(order_id)
);

CREATE TABLE feedback (
  feedback_id VARCHAR NOT NULL,
  order_id VARCHAR NOT NULL,
  feedback_score INTEGER,
  feedback_form_sent_date TIMESTAMP,
  feedback_answer_date TIMESTAMP,
  PRIMARY KEY(feedback_id, order_id),
  FOREIGN KEY (order_id)
  	REFERENCES "order"(order_id)
);

CREATE TABLE order_item (
  order_id VARCHAR NOT NULL,
  order_item_id INTEGER NOT NULL,
  product_id VARCHAR,
  seller_id VARCHAR,
  pickup_limit_date TIMESTAMP,
  price FLOAT8,
  shipping_cost FLOAT8,
  PRIMARY KEY(order_id, order_item_id),
  FOREIGN KEY (order_id)
  	REFERENCES "order"(ORDER_ID),
  FOREIGN KEY (product_id)
  	REFERENCES products(product_id),
  FOREIGN KEY (seller_id)
  	REFERENCES seller(seller_id)
);
