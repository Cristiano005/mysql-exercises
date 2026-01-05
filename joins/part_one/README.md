🧠 Exercícios de JOIN com CONTEXTO (MySQL)
📘 Contexto geral das tabelas
users(id, name)
orders(id, user_id, total)
payments(id, order_id, status)

products(id, name)
order_items(id, order_id, product_id)

employees(id, name, department_id)
departments(id, name)

professionals(id, name)
appointments(id, professional_id, status)

1️⃣ Relatório de vendas (básico, mas conceitual)

Contexto:
O financeiro precisa de um relatório contendo:

nome do usuário

valor do pedido

⚠️ Importante:
Pedidos só existem se estiverem vinculados a um usuário válido.

📌 Gere a consulta solicitada.

2️⃣ Usuários inativos

Contexto:
O time de marketing quer listar todos os usuários do sistema, inclusive:

os que nunca fizeram pedidos

Para cada usuário, mostrar:

nome

id do pedido (se existir)

📌 Gere a consulta.

3️⃣ Auditoria de pagamentos

Contexto:
O time financeiro quer ver:

todos os pedidos

e, se houver, o status do pagamento

⚠️ Existem pedidos que ainda não foram pagos.

Mostrar:

id do pedido

total

status do pagamento (ou NULL)

📌 Gere a consulta.

4️⃣ Produtos encalhados

Contexto:
O estoque quer saber quais produtos nunca foram vendidos.

📌 Gere a consulta que retorne somente esses produtos.

5️⃣ Funcionários e seus setores

Contexto:
O RH precisa de um relatório com:

nome do funcionário

nome do setor

⚠️ Todos os funcionários devem estar associados a um setor.

📌 Gere a consulta.

6️⃣ Setores vazios

Contexto:
A diretoria quer listar todos os setores da empresa, incluindo:

setores que ainda não têm funcionários

Mostrar:

nome do setor

nome do funcionário (se existir)

📌 Gere a consulta.

7️⃣ Profissionais com agenda ativa

Contexto:
O sistema precisa mostrar apenas profissionais que possuem ao menos um agendamento.

Mostrar:

nome do profissional

quantidade de agendamentos

📌 Gere a consulta.

8️⃣ Profissionais sem atendimentos realizados

Contexto:
A coordenação quer identificar profissionais que:

nunca tiveram um agendamento com status = 'success'

📌 Gere a consulta.

9️⃣ Relatório crítico (JOIN + regra de negócio)

Contexto:
Um pedido só é considerado válido se:

existir

tiver pagamento com status = 'paid'

Mostrar:

id do pedido

nome do usuário

total

📌 Gere a consulta.

🔟 Diagnóstico de dados (nível avançado real)

Contexto:
Existe um problema no sistema:
alguns registros de appointments apontam para profissionais que não existem mais.

A equipe de dados precisa listar:

id do agendamento

professional_id inválido

📌 Gere a consulta que encontre apenas esses registros inconsistentes.