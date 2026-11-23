-- =====================================================
-- Mini-projeto 1: Análise de vendas da Loja TechNordeste
-- Autor: (seu nome)
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
-- Achado: 91,67% dos pedidos foram entregues. 8,33% não geraram receita
-- (5,95% cancelados e 2,38% devolvidos). Vale investigar o que causa os cancelamentos (ver P6).


-- P2. Qual o faturamento total, o número de pedidos entregues e o ticket médio do semestre?
-- Achado: no semestre, a loja faturou R$ 275.885,73 com 385 pedidos entregues,
-- um ticket médio de R$ 716,59 por pedido.

-- =====================================================
-- PARTE 2: TEMPO
-- =====================================================

-- P3. Qual o faturamento, o número de pedidos e o ticket médio de cada mês?
--     Dica: substr(data_pedido, 1, 7) extrai o "ano-mês" (ex.: '2026-05').
--     Qual mês vendeu mais pedidos? E qual faturou mais? É o mesmo mês?
-- Achado: maio foi o melhor mês em pedidos (91, cerca de 34% a mais que junho, o 2º colocado)
-- e em faturamento (R$ 54.885,64), mas teve o MENOR ticket médio do semestre (R$ 603,14).
-- Hipótese: o Dia das Mães aumentou as compras de presentes de menor valor (a testar no desafio D2).
-- Fevereiro foi o pior mês (R$ 37.751,10), possivelmente pelos gastos de fim de ano e carnaval.
-- Obs.: fevereiro tem só 28 dias; por dia, a queda em relação a janeiro é menor (1,75 vs 1,9 pedido/dia).


-- =====================================================
-- PARTE 3: PRODUTOS
-- =====================================================

-- P4. Quais os 5 produtos que mais faturaram? (dica: LIMIT 5 no final)


-- P5. Para cada categoria: faturamento, lucro e margem (%) = lucro / faturamento * 100.
--     A categoria que mais fatura é a que mais lucra?


-- P6. Taxa de cancelamento por produto (% de pedidos cancelados sobre o total de pedidos do produto).
--     Aqui considere TODOS os status. Algum produto chama atenção?


-- =====================================================
-- PARTE 4: CLIENTES
-- =====================================================

-- P7. Faturamento por estado, do maior para o menor.


-- P8. Ticket médio por canal de aquisição (Instagram, Google, Indicação, TikTok).


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
