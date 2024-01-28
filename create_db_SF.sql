create warehouse transforming;
create database raw;
create database analytics;
create schema raw.jaffle_shop;

-- create this one directly in the schema
create table raw.jaffle_shop.customers (
    id int,
    first_name varchar,
    last_name varchar
);

copy into raw.jaffle_shop.customers (id, first_name, last_name)
    from 's3://dbt-tutorial-public/jaffle_shop_customers.csv'
        file_format = (
        type = 'csv'
        field_delimiter = ','
        skip_header = 1
        )
;
select * from raw.jaffle_shop.customers;

create table raw.jaffle_shop.orders (
    id int,
    user_id int,
    order_date date,
    status varchar,
    _etl_loaded_at timestamp default current_timestamp
);

copy into raw.jaffle_shop.orders (id, user_id, order_date, status)
    from 's3://dbt-tutorial-public/jaffle_shop_orders.csv'
        file_format = (
        type = 'csv'
        field_delimiter = ','
        skip_header = 1
        )
;
select * from raw.jaffle_shop.orders;

create schema raw.stripe;

create table raw.stripe.payment (
    id int,
    orderid int,
    paymentmethod varchar,
    status varchar,
    amount int,
    created date,
    _batched_at timestamp default current_timestamp
);

copy into raw.stripe.payment (id, orderid, paymentmethod, status, amount, created)
    from 's3://dbt-tutorial-public/stripe_payments.csv'
        file_format = (
        type = 'csv'
        field_delimiter = ','
        skip_header = 1
        )
;
select * from raw.stripe.payment;



