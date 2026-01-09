1️⃣ Receita confiável

Contexto:
O financeiro só considera receita quando:

pedido existe

pagamento tem status = 'paid'

pedido não está cancelado

📌 Liste:

nome do usuário

valor total pago

2️⃣ Usuários que “quase converteram”

Contexto:
Marketing quer usuários que:

fizeram pedidos

nunca tiveram pagamento aprovado

📌 Liste:

usuário

quantidade de pedidos

3️⃣ Pedidos com inconsistência crítica

Contexto:
Auditoria detectou pedidos onde:

há pagamento paid

mas não existem itens associados

📌 Liste os pedidos.

4️⃣ Profissionais problemáticos

Contexto:
A clínica quer profissionais que:

possuem agendamentos

nenhum com status success

estão marcados como ativos

📌 Liste os profissionais.

5️⃣ Produtos “fantasma”

Contexto:
Estoque suspeita que alguns produtos:

estão ativos

nunca foram vendidos

pertencem a categorias existentes

📌 Liste esses produtos.

6️⃣ Departamentos ineficientes

Contexto:
A diretoria quer departamentos que:

possuem funcionários

salário médio acima da média geral

menos funcionários que a média

📌 Liste os departamentos.

7️⃣ Usuários silenciosos

Contexto:
Compliance quer usuários que:

possuem pedidos pagos

não possuem nenhum log

📌 Liste esses usuários.

8️⃣ Pedidos multissetoriais

Contexto:
Alguns pedidos possuem produtos de múltiplas categorias.
Esses pedidos exigem revisão.

📌 Liste:

id do pedido

quantidade de categorias distintas

9️⃣ Profissionais confiáveis

Contexto:
Um profissional é confiável quando:

está ativo

possui taxa de sucesso ≥ 80%

tem pelo menos 10 agendamentos

📌 Liste os profissionais.

🔟 Diagnóstico de integridade (nível sênior)

Contexto:
Existem registros inválidos no sistema.

Liste:

pedidos com user_id inexistente

pagamentos com order_id inexistente

logs com user_id inexistente

📌 Gere um relatório único, identificando:

tipo do problema

id do registro inválido