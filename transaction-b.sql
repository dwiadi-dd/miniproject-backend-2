
-- masukkan data pesanan baru ke dalam tabel orders
INSERT INTO orders(order_id,order_date, status, user_id) VALUES 
(2,'2023-01-01 12:00:00', 'PENDING', 3)

-- masukan detail order ke dalam tabel ordered_products
INSERT INTO ordered_products(order_id,product_id,quantity) VALUES
(2,1,3)

START TRANSACTION;

-- ambil data user dan product yang diupdate
SELECT *
FROM users
WHERE id = 1 FOR UPDATE;

-- disini bisa melakukan pengecekan saldo
-- jika saldo user 0 bisa langsung ROLLBACK 

-- ambil data product yang diupdate
SELECT  name, stocks, price
FROM products
WHERE product_id = 1 FOR UPDATE;
-- disini bisa melakukan pengecekan stock barang 
-- jika stock produk kurang dari order maka transaksi bisa langsung dibatalkan dengan ROLLBACK 


-- update data stock product yang diorder
UPDATE products
SET stocks = stocks - (SELECT quantity FROM ordered_products WHERE product_id = 1 AND order_id = 2)
WHERE product_id = 1;


-- update balance user yang melakukan order
UPDATE users
SET balance = balance - (SELECT quantity FROM ordered_products WHERE product_id = 1) * (SELECT price FROM products WHERE product_id = 1)
WHERE id = (SELECT user_id FROM orders WHERE order_id = 2);

-- tampilkan detail order
SELECT p.name, op.quantity, p.price, op.quantity * p.price total
FROM ordered_products op
JOIN orders o ON op.order_id = o.order_id
JOIN products p ON op.product_id = p.product_id
WHERE o.order_id = 2;

-- tampilkan sisa balance user
SELECT name, balance
FROM users
WHERE id=3


COMMIT;