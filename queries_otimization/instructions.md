1️⃣ Índice simples em coluna de busca frequente
🔍 Consulta
SELECT * 
FROM users 
WHERE email = 'user50000@email.com';

🎯 Desafio

Crie um índice para otimizar essa busca

Compare:

Sem índice

Com índice

💡 Conceito treinado

Índice B-Tree

Busca por igualdade (=)

2️⃣ Índice em coluna usada em filtro + ordenação

🔍 Consulta

`SELECT id, name FROM users WHERE status = 'active'
 ORDER BY created_at DESC LIMIT 20 `

🎯 Desafio

Crie 1 índice composto

Faça o MySQL não usar filesort

💡 Conceito treinado

Ordem das colunas no índice

Índice composto

WHERE + ORDER BY

3️⃣ Índice para JOIN simples (FK)

🔍 Consulta

`SELECT o.*
FROM orders o
JOIN users u ON u.id = o.user_id
WHERE u.status = 'active'`;

🎯 Desafio

Criar os índices corretos em ambas as tabelas

Ver se o plano muda de ALL para ref ou eq_ref

💡 Conceito treinado

Índices em colunas de JOIN

Cardinalidade

4️⃣ Índice composto com filtro seletivo
🔍 Consulta
SELECT *
FROM orders
WHERE status = 'paid'
AND created_at >= '2025-01-01';

🎯 Desafio

Criar índice composto

Testar a ordem das colunas

(status, created_at)

(created_at, status)

💡 Conceito treinado

Seletividade

Regra do prefixo mais seletivo

5️⃣ Índice para COUNT com filtro

🔍 Consulta

`SELECT COUNT(*) FROM orders WHERE user_id = 12345`;

🎯 Desafio

Criar índice mínimo possível

Ver diferença no custo da query

💡 Conceito treinado

Índice cobrindo (covering index)

Leitura apenas do índice

6️⃣ Índice para JOIN em tabela grande (order_items)
🔍 Consulta
SELECT SUM(oi.quantity * oi.price)
FROM order_items oi
JOIN orders o ON o.id = oi.order_id
WHERE o.created_at >= '2025-01-01';

🎯 Desafio

Criar índices em:

order_items.order_id

orders.created_at

Observar impacto no tempo

💡 Conceito treinado

JOIN em tabelas grandes

Índices em cascata

7️⃣ Índice composto cobrindo a query
🔍 Consulta
SELECT order_id, quantity, price
FROM order_items
WHERE order_id = 98765;

🎯 Desafio

Criar um índice que evite acesso à tabela

Confirmar no EXPLAIN:

Using index

💡 Conceito treinado

Covering Index

Redução de I/O

8️⃣ Índice inútil (anti-padrão)
🔍 Consulta
SELECT *
FROM users
WHERE name LIKE '%silva%';

🎯 Desafio

Criar um índice em name

Ver por que não funciona

Explicar o motivo técnico

💡 Conceito treinado

Limitações do B-Tree

LIKE '%valor%'

9️⃣ Índice parcial “na prática” (simulado)
🔍 Consulta
SELECT *
FROM orders
WHERE status = 'pending';

🎯 Desafio

Criar índice simples em status

Analisar:

Se a cardinalidade é baixa

Se o índice realmente compensa

💡 Conceito treinado

Baixa seletividade

Quando o índice atrapalha

🔟 Índice errado vs índice certo (caso clássico)

🔍 Consulta

`
SELECT *
FROM orders
WHERE user_id = 555
ORDER BY created_at DESC
LIMIT 10; `

🎯 Desafio

Criar índice errado:

(created_at, user_id)


Criar índice correto:

(user_id, created_at)


Comparar planos

💡 Conceito treinado

Ordem das colunas no índice

Uso de índice para ORDER BY