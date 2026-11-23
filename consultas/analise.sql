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


-- P2. Qual o faturamento total, o número de pedidos entregues e o ticket médio do semestre?


-- =====================================================
-- PARTE 2: TEMPO
-- =====================================================

-- P3. Qual o faturamento, o número de pedidos e o ticket médio de cada mês?
--     Dica: substr(data_pedido, 1, 7) extrai o "ano-mês" (ex.: '2026-05').
--     Qual mês vendeu mais pedidos? E qual faturou mais? É o mesmo mês?


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
