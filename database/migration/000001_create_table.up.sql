CREATE TABLE widgets (
   id INT not null auto_increment primary key,
   name TEXT not null,
   description TEXT,
   inventory_level INT,
   price INT,
   image TEXT,
   created_at TIMESTAMP default now(),
   updated_at TIMESTAMP default now()
);

CREATE TABLE orders (
   id INT not null auto_increment primary key,
   widget_id INT not null,
   transaction_id INT not null,
   customer_id INT,
   status_id INT not null,
   quantity INT,
   amount INT,
   created_at TIMESTAMP default now(),
   updated_at TIMESTAMP default now()
);

CREATE TABLE statuses (
   id INT not null auto_increment primary key,
   name TEXT,
   created_at TIMESTAMP default now(),
   updated_at TIMESTAMP default now()
);

CREATE TABLE transaction_statuses (
   id INT not null auto_increment primary key,
   name TEXT,
   created_at TIMESTAMP default now(),
   updated_at TIMESTAMP default now()
);

CREATE TABLE transactions (
   id INT not null auto_increment primary key,
   amount INT,
   currency TEXT,
   last_four TEXT,
   bank_return_code TEXT,
   expiry_month INT default 0,
   expiry_year INT default 0,
   transaction_status_id INT not null,
   created_at TIMESTAMP default now(),
   updated_at TIMESTAMP default now()
);

CREATE TABLE users (
   id INT not null auto_increment primary key,
   first_name TEXT,
   last_name TEXT,
   email TEXT,
   password TEXT,
   created_at TIMESTAMP default now(),
   updated_at TIMESTAMP default now()
);


CREATE TABLE customers (
   id INT not null auto_increment primary key,
   first_name TEXT,
   last_name TEXT,
   email TEXT,
   created_at TIMESTAMP default now(),
   updated_at TIMESTAMP default now()
);


ALTER TABLE orders ADD CONSTRAINT `fk_customer_id`
   FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE CASCADE;
