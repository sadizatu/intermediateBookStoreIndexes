--1
SELECT * FROM customers LIMIT 10;
SELECT * FROM orders LIMIT 10;
SELECT * FROM books LIMIT 10;
--2
SELECT * FROM pg_indexes WHERE tablename = 'customers';
SELECT * FROM pg_indexes WHERE tablename = 'books';
SELECT * FROM pg_indexes WHERE tablename = 'orders';
--3
EXPLAIN ANALYZE SELECT customer_id FROM customers; 
EXPLAIN ANALYZE SELECT quantity FROM orders WHERE quantity > 18;
--4
SELECT pg_size_pretty (pg_total_relation_size('books'));
--5

--6
ALTER TABLE customers
  ADD CONSTRAINT customers_pkey
    PRIMARY KEY (customer_id);

EXPLAIN ANALYZE SELECT *
FROM customers
WHERE customer_id < 100;

--7
--CLUSTER customers;
--ALTER TABLE customers ADD PRIMARY KEY (customer_id);
--8
CREATE INDEX customer_id_book_id_idx ON orders( customer_id, book_id);
--9 
DROP INDEX IF EXISTS customer_id_book_id_idx;
CREATE INDEX customer_id_book_id_quantity_idx ON orders( customer_id, book_id, quantity);
--10


--11
--EXPLAIN ANALYZE SELECT quantity FROM orders WHERE total_price (quantity * price_base);

--12
CREATE INDEX orders_shipping_delay_idx ON orders ((ship_date - order_date));
--13
EXPLAIN ANALYZE SELECT quantity FROM orders WHERE quantity > 18;
--14
SELECT *
FROM pg_indexes
WHERE tablename IN ('customers', 'books', 'orders')
ORDER BY tablename, indexname;

DROP INDEX IF EXISTS books_author_idx;
DROP INDEX IF EXISTS orders_customer_id_quantity;
CREATE INDEX customers_last_name_first_name_email_address ON customers (last_name, first_name, email_address);
SELECT *
FROM pg_indexes
WHERE tablename IN ('customers', 'books', 'orders')
ORDER BY tablename, indexname;







