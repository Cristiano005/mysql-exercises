-- Active: 1766198979246@@127.0.0.1@3306@test_joins

INSERT INTO users (name) VALUES ("Cristiano")

SELECT * FROM users;

SELECT users.name, orders.id AS orderId FROM users LEFT JOIN orders 
    ON orders.user_id = users.id