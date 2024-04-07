CREATE DATABASE bangkitmart;


USE bangkitmart;


CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR (255) NOT NULL,
    address TEXT NOT NULL,
    balance INTEGER
)

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR (255) NOT NULL,
    stocks INT DEFAULT 0,
    price INT NOT NULL
)

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
)

CREATE TABLE ordered_products (
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    quantity INT
)

