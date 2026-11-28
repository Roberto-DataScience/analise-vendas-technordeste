-- =====================================================
-- Mini-projeto 1: Análise de vendas da Loja TechNordeste
-- Autor: Pedro Roberto Menezes da Silva
-- Período analisado: janeiro a junho de 2026
-- =====================================================
-- REGRA DE NEGÓCIO: faturamento, lucro e ticket médio consideram
-- APENAS pedidos com status = 'Entregue' (cancelados e devolvidos não geram receita).
--
-- Fórmulas:
--   faturamento  = quantidade * preco_unitario
--   lucro        = quantidade * (preco_unitario - custo)
--   ticket médio = faturamento / número de pedidos
-- =====================================================


-- =====================================================
-- PARTE 1: VISÃO GERAL
-- =====================================================

-- P1. Quantos pedidos existem em cada status (Entregue, Cancelado, Devolvido)?
--     E qual a porcentagem de cada um sobre o total?
SELECT status,
       COUNT(*) AS qtd_pedidos,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM pedidos), 2) AS percentual
FROM pedidos
GROUP BY status
ORDER BY qtd_pedidos DESC;
-- Achado: 91,67% dos pedidos foram entregues. 8,33% não geraram receita
-- (5,95% cancelados e 2,38% devolvidos). Vale investigar o que causa os cancelamentos (ver P6).


-- P2. Qual o faturamento total, o número de pedidos entregues e o ticket médio do semestre?
SELECT ROUND(SUM(quantidade * preco_unitario), 2) AS faturamento,
       COUNT(*) AS qtd_pedidos,
       ROUND(SUM(quantidade * preco_unitario) / COUNT(*), 2) AS ticket_medio
FROM pedidos
WHERE status = 'Entregue';
-- Achado: no semestre, a loja faturou R$ 275.885,73 com 385 pedidos entregues,
-- um ticket médio de R$ 716,59 por pedido.


-- =====================================================
-- PARTE 2: TEMPO
-- =====================================================

-- P3. Qual o faturamento, o número de pedidos e o ticket médio de cada mês?
--     Qual mês vendeu mais pedidos? E qual faturou mais? É o mesmo mês?
SELECT substr(data_pedido, 1, 7) AS mes,
       ROUND(SUM(quantidade * preco_unitario), 2) AS faturamento,
       COUNT(*) AS qtd_pedidos,
       ROUND(SUM(quantidade * preco_unitario) / COUNT(*), 2) AS ticket_medio
FROM pedidos
WHERE status = 'Entregue'
GROUP BY substr(data_pedido, 1, 7)
ORDER BY mes;
-- Achado: maio foi o melhor mês em pedidos (91, cerca de 34% a mais que junho, o 2º colocado)
-- e em faturamento (R$ 54.885,64), mas teve o MENOR ticket médio do semestre (R$ 603,14).
-- Hipótese: o Dia das Mães aumentou as compras de presentes de menor valor (a testar no desafio D2).
-- Fevereiro foi o pior mês (R$ 37.751,10), possivelmente pelos gastos de fim de ano e carnaval.
-- Obs.: fevereiro tem só 28 dias; por dia, a queda em relação a janeiro é menor (1,75 vs 1,9 pedido/dia).


-- =====================================================
-- PARTE 3: PRODUTOS
-- =====================================================

-- P4. Quais os 5 produtos que mais faturaram?
SELECT p.nome_produto,
       ROUND(SUM(pe.quantidade * pe.preco_unitario), 2) AS faturamento
FROM pedidos AS pe
JOIN produtos AS p
  ON pe.id_produto = p.id_produto
WHERE pe.status = 'Entregue'
GROUP BY p.nome_produto
ORDER BY faturamento DESC
LIMIT 5;
-- Achado: o Notebook Inspire 15 lidera com folga (R$ 67.257,75), quase o dobro do 2º lugar.
-- O Monitor 24 Full HD (2º) superou o Monitor 27 4K graças ao volume (45 x 18 unidades).
-- O Notebook Gamer Raptor, produto mais caro da loja, teve só 3 vendas no semestre.


-- P5. Para cada categoria: faturamento, lucro e margem (%) = lucro / faturamento * 100.
--     A categoria que mais fatura é a que mais lucra?
SELECT p.categoria,
       ROUND(SUM(pe.quantidade * pe.preco_unitario), 2) AS faturamento,
       ROUND(SUM(pe.quantidade * (pe.preco_unitario - p.custo)), 2) AS lucro,
       ROUND(SUM(pe.quantidade * (pe.preco_unitario - p.custo)) * 100.0 / SUM(pe.quantidade * pe.preco_unitario), 2) AS margem
FROM pedidos AS pe
JOIN produtos AS p
  ON pe.id_produto = p.id_produto
WHERE pe.status = 'Entregue'
GROUP BY p.categoria
ORDER BY faturamento DESC;
-- Achado: a categoria que mais fatura NÃO é a que mais lucra.
-- Computadores lideram o faturamento (R$ 106.622,95), mas têm a menor margem (17,33%).
-- Periféricos faturam menos da metade (R$ 45.282,15), mas geram o MAIOR lucro (R$ 24.144,15).
-- Acessórios têm a maior margem (58,52%).
-- Recomendação: estimular a venda casada de periféricos e acessórios junto com computadores.


-- P6. Taxa de cancelamento por produto (% de pedidos cancelados sobre o total de pedidos do produto).
--     Aqui considere TODOS os status. Algum produto chama atenção?
SELECT p.nome_produto,
       COUNT(*) AS total_pedidos,
       SUM(CASE WHEN pe.status = 'Cancelado' THEN 1 ELSE 0 END) AS cancelados,
       ROUND(SUM(CASE WHEN pe.status = 'Cancelado' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS taxa_cancelamento
FROM pedidos AS pe
JOIN produtos AS p
  ON pe.id_produto = p.id_produto
GROUP BY p.nome_produto
ORDER BY taxa_cancelamento DESC;
-- Achado: o Headset Gamer tem taxa de cancelamento de 31,82% (7 de 22 pedidos),
-- quase 3 vezes a do 2º colocado (Webcam Full HD, 12,5%). A maioria dos produtos fica abaixo de 10%.
-- Recomendação: investigar a causa (falta de estoque, prazo de entrega, descrição do produto ou preço).
-- Obs.: produtos com poucos pedidos (ex.: Notebook Gamer Raptor, 4 pedidos) têm taxas pouco confiáveis.

-- =====================================================
-- PARTE 4: CLIENTES
-- =====================================================


-- P7. Faturamento por estado, do maior para o menor.
SELECT c.estado,
       ROUND(SUM(pe.quantidade * pe.preco_unitario), 2) AS faturamento,
       COUNT(DISTINCT c.id_cliente) AS qtd_clientes
FROM pedidos AS pe
JOIN clientes AS c
  ON pe.id_cliente = c.id_cliente
WHERE pe.status = 'Entregue'
GROUP BY c.estado
ORDER BY faturamento DESC;
-- Achado: a Bahia lidera (R$ 78.552,72, com 14 clientes), seguida de Pernambuco (R$ 63.303,61).
-- Surpresa: Sergipe é o 3º estado em faturamento (R$ 57.793,56) com apenas 8 clientes,
-- puxado por 3 clientes que gastaram mais de R$ 10 mil cada.
-- O Piauí tem só 1 cliente ativo e faturou R$ 1.450,71: mercado pouco explorado.


-- P8. Ticket médio por canal de aquisição (Instagram, Google, Indicação, TikTok).
       ROUND(SUM(pe.quantidade * pe.preco_unitario), 2) AS faturamento,
       COUNT(*) AS qtd_pedidos,
       ROUND(SUM(pe.quantidade * pe.preco_unitario) / COUNT(*), 2) AS ticket_medio
FROM pedidos AS pe
JOIN clientes AS c
  ON pe.id_cliente = c.id_cliente
WHERE pe.status = 'Entregue'
GROUP BY c.canal
ORDER BY ticket_medio DESC;
-- Achado: o Instagram traz o maior ticket médio (R$ 827,30), seguido da Indicação (R$ 784,97).
-- O Google gera o maior faturamento total (R$ 82.690,90) por volume de pedidos (123),
-- mas com ticket médio menor (R$ 672,28). O TikTok tem o menor ticket (R$ 637,77).
-- Recomendação: Google e TikTok trazem volume; Instagram e Indicação trazem pedidos de maior valor.

-- P9. Quantos clientes cadastrados nunca fizeram nenhum pedido? Quem são?


-- P10. Classifique cada cliente pelo total gasto:
--      'VIP' (10.000 ou mais), 'Regular' (2.000 ou mais), 'Ocasional' (o resto).
--      Quantos clientes há em cada classificação e quanto cada grupo faturou?


-- =====================================================
-- DESAFIO (opcional)
-- =====================================================

-- D1. Quais produtos têm faturamento ACIMA da média de faturamento dos produtos?


-- D2. Em uma tabela com uma linha por categoria, mostre o faturamento de cada mês em colunas
--     (jan, fev, mar, abr, mai, jun). Dica: SUM(CASE WHEN ...).