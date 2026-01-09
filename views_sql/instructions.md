Exercício 1 – View simples

Crie uma view chamada view_users_over_25 que retorne todos os usuários com idade maior que 25 anos.
Objetivo: Praticar views simples com SELECT e WHERE.

Exercício 2 – View com join

Crie uma view chamada view_user_orders que retorne:

Nome do usuário (users.name)

Id do pedido (orders.id)

Total do pedido (orders.total)

Objetivo: Praticar joins dentro de views.

Exercício 3 – View agregada

Crie uma view chamada view_total_per_user que mostre, para cada usuário:

user_id

Nome do usuário

Total gasto em todos os pedidos (SUM(orders.total))

Objetivo: Praticar agregações (SUM, GROUP BY) em views.

Exercício 4 – View com subquery

Crie uma view chamada view_big_orders que retorne os pedidos cujo total seja maior que a média de todos os pedidos da tabela orders.
Objetivo: Praticar subqueries dentro de views.

Exercício 5 – View complexa com múltiplos joins e agregação

Crie uma view chamada view_product_sales que mostre, para cada produto:

product_id

Nome do produto

Quantidade total vendida (SUM(order_items.quantity))

Total de receita do produto (SUM(order_items.quantity * products.price))

Objetivo: Praticar múltiplos joins, agregações e cálculo dentro de uma view.