### Schema de Banco de Dados para um E-commerce

Aqui está o schema que criei para uma loja de e-commerce simples. Ele inclui as principais tabelas necessárias para gerenciar clientes, produtos, categorias, pedidos e itens de pedidos.

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50),
    join_date DATE
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2),
    status VARCHAR(20) DEFAULT 'pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
```

### Dados de Exemplo

Para praticar, você pode inserir dados de exemplo (categorias, produtos, clientes e pedidos gerados aleatoriamente):

```sql
INSERT INTO categories (category_name) VALUES ('Eletrônicos'), ('Roupas'), ('Livros'), ('Casa e Cozinha'), ('Esportes');

INSERT INTO products (product_name, category_id, price, stock) VALUES
('Smartphone XYZ', 1, 1299.99, 50),
('Fone de Ouvido Bluetooth', 1, 199.90, 100),
('Camiseta Básica', 2, 49.90, 200),
('Calça Jeans', 2, 159.90, 80),
('Livro Python Avançado', 3, 89.90, 120),
('Panela Antiaderente', 4, 79.90, 60),
('Bola de Futebol', 5, 99.90, 40),
('Notebook Gamer', 1, 4999.99, 20),
('Moletom', 2, 119.90, 150),
('Romance Best-Seller', 3, 39.90, 300);

INSERT INTO customers (name, email, city, join_date) VALUES
('Ana Silva', 'ana@email.com', 'São Paulo', '2024-01-15'),
('Bruno Santos', 'bruno@email.com', 'Rio de Janeiro', '2024-02-20'),
('Carla Oliveira', 'carla@email.com', 'Belo Horizonte', '2024-03-10'),
('Diego Costa', 'diego@email.com', 'São Paulo', '2024-04-05'),
('Elena Ferreira', 'elena@email.com', 'Curitiba', '2024-05-12'),
('Felipe Almeida', 'felipe@email.com', 'Rio de Janeiro', '2024-06-18'),
('Gabriela Lima', 'gabriela@email.com', 'São Paulo', '2024-07-22'),
('Hugo Mendes', 'hugo@email.com', 'Salvador', '2024-08-30'),
('Isabela Rocha', 'isabela@email.com', 'Fortaleza', '2024-09-15'),
('João Pereira', 'joao@email.com', 'São Paulo', '2024-10-01');

INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(1, '2024-01-20', 1499.89, 'completed'),
(2, '2024-02-25', 249.80, 'completed'),
(3, '2024-03-15', 89.90, 'completed'),
(4, '2024-04-10', 5079.89, 'shipped'),
(5, '2024-05-18', 279.70, 'completed'),
(6, '2024-06-22', 199.80, 'completed'),
(7, '2024-07-28', 1419.88, 'pending'),
(8, '2024-09-05', 159.80, 'completed'),
(9, '2024-09-20', 329.70, 'shipped'),
(10, '2024-10-10', 6119.87, 'pending'),
(1, '2024-11-01', 169.80, 'completed'),
(3, '2024-11-15', 279.70, 'shipped'),
(5, '2024-12-01', 49.90, 'pending'),
(7, '2024-12-10', 1299.99, 'completed'),
(9, '2024-12-20', 239.70, 'shipped');

-- Populando a tabela order_items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
-- Pedido 1
(1, 1, 1, 1299.99),
(1, 2, 1, 199.90),
-- Pedido 2
(2, 3, 5, 49.90),
-- Pedido 3
(3, 5, 1, 89.90),
-- Pedido 4
(4, 8, 1, 4999.99),
(4, 6, 1, 79.90),
-- Pedido 5
(5, 2, 1, 199.90),
(5, 6, 1, 79.90),
-- Pedido 6
(6, 7, 2, 99.90),
-- Pedido 7
(7, 1, 1, 1299.99),
(7, 9, 1, 119.90),
-- Pedido 8
(8, 4, 1, 159.90),
-- Pedido 9
(9, 10, 3, 39.90),
(9, 5, 1, 89.90),
(9, 2, 1, 199.90),
-- Pedido 10
(10, 8, 1, 4999.99),
(10, 1, 1, 1299.99),
(10, 3, 4, 49.90),
(10, 10, 5, 39.90),
(10, 9, 2, 119.90),
-- Pedido 11
(11, 4, 1, 159.90),
(11, 10, 1, 39.90),
-- Pedido 12
(12, 2, 1, 199.90),
(12, 6, 1, 79.90),
-- Pedido 13
(13, 3, 1, 49.90),
-- Pedido 14
(14, 1, 1, 1299.99),
-- Pedido 15
(15, 7, 1, 99.90),
(15, 5, 1, 89.90),
(15, 3, 1, 49.90);
```

### 20 Exercícios de SQL com Progressão de Dificuldade

Todos os exercícios usam o schema acima. A dificuldade aumenta gradualmente: básicos (SELECT simples), intermediários (JOINs, agregações), avançados (subqueries, window functions, etc.).

1. **Liste todos os produtos com seu nome e preço.**

2. **Liste os clientes de 'São Paulo', mostrando nome e email.**

3. **Encontre todas as categorias ordenadas alfabeticamente.**

4. **Liste os produtos da categoria 'Eletrônicos' (use JOIN com categories).**

5. **Mostre os pedidos (order_id, order_date) feitos em 2024 após o mês de junho.**

6. **Calcule o total de estoque de todos os produtos.**

7. **Encontre o produto mais caro (nome e preço).**

8. **Liste o número de clientes por cidade, ordenado do maior para o menor.**

9. **Mostre os itens de um pedido específico (ex: order_id = 1), com nome do produto e quantidade.**

10. **Calcule o valor total vendido (soma de quantity \* unit_price em order_items) para pedidos 'completed'.**

11. **Liste os clientes que fizeram pelo menos um pedido, com nome do cliente e número de pedidos.**

12. **Encontre os produtos que nunca foram vendidos (não aparecem em order_items).**

13. **Mostre o faturamento por categoria (soma de vendas de produtos daquela categoria).**

14. **Liste os 3 clientes que gastaram mais (soma de total_amount em orders), com nome e total gasto.**

15. **Para cada pedido, mostre o order_id, nome do cliente e o número de itens no pedido.**

16. **Encontre produtos com estoque baixo (menos de 50 unidades) e preço acima de 100.**

17. **Usando subquery, liste pedidos cujo total_amount é maior que a média de todos os pedidos.**

18. **Calcule o ranking dos produtos por quantidade total vendida (use window function RANK() ou ROW_NUMBER()).**

19. **Mostre o mês com maior faturamento em 2024 (agrupe por mês de order_date, some total_amount de pedidos completed).**

20. **Encontre clientes que compraram produtos de mais de 2 categorias diferentes (use GROUP BY e HAVING).**
