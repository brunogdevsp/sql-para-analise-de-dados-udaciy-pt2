-- JOINS 
-- Consulte apenas o nome da conta e as datas em que essa conta fez um pedido, mas nenhuma das outras colunas:
SELECT accounts.name,
       orders.occurred_at 
FROM orders
JOIN accounts ON orders.account_id = accounts.id;



-- Consulte todas as colunas da tabela de contas e pedidos:
SELECT * FROM orders
JOIN accounts ON orders.account_id = accounts.id;



-- Consulte todas as informações apenas da tabela de pedidos:
SELECT orders.*
FROM orders
JOIN accounts ON orders.account_id = accounts.id;



-- Retorne todos os dados da tabela accounts e todos os dados da tabela orders:
SELECT accounts.*, orders.*
FROM orders
JOIN Accounts ON orders.account_id = accounts.id;



-- Retorne standard_qty, gloss_qty e poster_qty da tabela orders, e website e primary_poc da tabela accounts:
SELECT orders.standard_qty, gloss_qty, poster_qty, accounts.website, primary_poc
FROM orders
JOIN accounts ON orders.account_id = accounts.id;



-- Retorne todas as colunas das tabelas web_events, accounts e orders:
SELECT *
FROM web_events
JOIN accounts ON web_events.account_id = accounts.id
JOIN orders ON accounts.id = orders.account_id



-- Retorne a coluna channel de web_events, name de accounts e total de orders:
SELECT web_events.channel, accounts.name, orders.total

--------------------------------------------------------------------------------

-- ALIAS
-- Forneça uma tabela com todos os web_events associados ao nome da conta Walmart.
-- A tabela deve conter três colunas obrigatórias: primary_poc, event_time, channel
-- Opcionalmente, você pode adicionar uma quarta coluna para garantir que apenas eventos do Walmart sejam incluídos.
SELECT a.primary_poc,
	   we.occurred_at,
	   we.channel,
	   a.name as Nome_cliente
FROM web_events we
JOIN accounts a ON we.account_id = a.id
WHERE a.name = 'Walmart'



-- Retorne uma tabela que forneça a região de cada sales_rep junto com suas contas associadas. Sua tabela final deve incluir três colunas: o nome da 
-- região, o nome do representante de vendas e o nome da conta. Classifique as contas em ordem alfabética (A-Z) de acordo com o nome da conta.
SELECT r.name regiao, sal.name nome_representante, acc.name nome_conta
FROM sales_reps sal
JOIN region r
ON sal.region_id = r.id
JOIN accounts acc
ON sal.id = acc.sales_rep_id
order by acc.name ASC;


-- Forneça o nome de cada região para cada pedido, bem como o nome da conta e o preço unitário pago (total_amt_usd/total) pelo pedido.
-- Sua mesa final deve ter 3 colunas: nome da região, nome da conta e preço unitário. Algumas contas têm 0 para o total, então dividi 
-- por (total + 0,01) para garantir que não divida por zero.
SELECT r.name nome_regiao,
		acc.name nome_da_conta,
		ord.total_amt_usd/(total+0.01) AS proco_unitario
FROM region r
JOIN sales_reps sal ON r.id = sal.region_id
JOIN accounts acc ON sal.id = acc.sales_rep_id
JOIN orders ord ON acc.id = ord.account_id



-- Forneça uma tabela que forneça a região de cada sales_rep junto com suas contas associadas. Desta vez apenas para a região Midwest.
-- Sua tabela final deve incluir três colunas: o nome da região, o nome do representante de vendas e o nome da conta. Classifique as 
-- contas em ordem alfabética (A-Z) de acordo com o nome da conta.
SELECT 
    r.name AS nome_regiao,
    sal.name AS nome_representante,
    acc.name AS nome_conta
FROM accounts acc
JOIN sales_reps sal ON acc.sales_rep_id = sal.id
JOIN region r ON sal.region_id = r.id
WHERE r.name = 'Midwest'
ORDER BY acc.name ASC;



-- Forneça uma tabela que forneça a região de cada sales_rep junto com suas contas associadas. Desta vez, apenas para contas em que o representante 
-- de vendas tem um primeiro nome começando com S e na região Midwest. Sua tabela final deve incluir três colunas: o nome da região, o nome do representante 
-- de vendas e o nome da conta. Classifique as contas em ordem alfabética (A-Z) de acordo com o nome da conta. 
SELECT R.name AS região,
	   sal.name AS representante,
	   a.name AS cliente
FROM accounts a
JOIN sales_reps sal ON a.sales_rep_id = sal.id
JOIN region r ON sal.region_id = r.id
WHERE r.name = 'Midwest' AND sal.name LIKE 'S%'
ORDER BY a.name ASC;



-- Forneça uma tabela que forneça a região de cada sales_rep junto com suas contas associadas. Desta vez, apenas para contas em que o representante de vendas
-- tem um sobrenome começando com k e na região Midwest. Sua tabela final deve incluir três colunas: o nome da região, o nome do representante de vendas e o nome da 
-- conta. Classifique as contas em ordem alfabética (A-Z) de acordo com o nome da conta.
SELECT r.name AS região,
	   sal.name AS nome_representante,
	   ac.name AS Nome_Conta
FROM accounts ac
JOIN sales_reps sal ON ac.sales_rep_id = sal.id
JOIN region r ON sal.region_id = r.id
WHERE r.name = 'Midwest'
AND SPLIT_PART(sal.name, ' ',2) ILIKE 'k%' 
ORDER BY ac.name ASC



-- Forneça o nome de cada região para cada pedido, bem como o nome da conta e o preço unitário pago (total_amt_usd/total) pelo pedido. No entanto, você só 
-- deve fornecer os resultados se a quantidade padrão do pedido exceder . Sua mesa final deve ter 3 colunas: nome da região, nome da conta e preço unitário.
-- Para evitar uma divisão por erro zero, adicionar 0,01 ao denominador aqui é útil total_amt_usd/(total+0,01).100
SELECT r.name AS região,
	   ac.name AS nome_conta,
	   o.total_amt_usd/(o.total+0.01)*100 AS preço_Unitario
FROM region r
JOIN sales_reps sal ON r.id = sal.region_id
JOIN accounts ac ON sal.id = ac.sales_rep_id
JOIN orders o ON ac.id = o.account_id
WHERE o.standard_qty > 0



-- Forneça o nome de cada região para cada pedido, bem como o nome da conta e o preço unitário pago (total_amt_usd/total) pelo pedido. No entanto, você só deve
-- fornecer os resultados se a quantidade padrão do pedido exceder 100 e a quantidade do pedido do pôster exceder 50 . Sua mesa final deve ter 3 colunas: nome da 
-- região, nome da conta e preço unitário. Classifique primeiro o menor preço unitário. Para evitar um erro de divisão por zero, adicionar 0,01 ao denominador
-- aqui é útil (total_amt_usd/(total+0,01).
SELECT r.name AS regiao,
	   ac.name AS conta,
	   o.total_amt_usd/(o.total+0.01) AS preco_unitario
FROM region r
JOIN sales_reps sal ON r.id = sal.region_id
JOIN accounts ac ON sal.id = ac.sales_rep_id
JOIN orders o ON ac.id = o.account_id
WHERE o.standard_amt_usd > 100 AND o.poster_amt_usd > 50
ORDER BY preco_unitario ASC




-- Forneça o nome de cada região para cada pedido, bem como o nome da conta e o preço unitário pago (total_amt_usd/total) pelo pedido. No entanto, você só deve
-- fornecer os resultados se a quantidade padrão do pedido exceder 100 e a quantidade do pedido do pôster exceder 50 . Sua mesa final deve ter 3 colunas: nome da região,
-- nome da conta e preço unitário. Classifique primeiro o maior preço unitário. Para evitar um erro de divisão por zero, adicionar 0,01 ao denominador aqui é 
-- útil (total_amt_usd/(total+0,01).
SELECT r.name AS regiao,
	   ac.name AS conta,
	   o.total_amt_usd/(o.total+0.01) AS preco_unitario
FROM region r
JOIN sales_reps sal ON r.id = sal.region_id
JOIN accounts ac ON sal.id = ac.sales_rep_id
JOIN orders o ON ac.id = o.account_id
WHERE o.standard_amt_usd > 100 AND o.poster_amt_usd > 50
ORDER BY preco_unitario DESC



-- Quais são os diferentes canais usados pelo ID da conta 1001? Sua mesa final deve ter apenas 2 colunas: nome da conta e os diferentes canais. Você pode tentar SELECT
-- DISTINCT para restringir os resultados apenas aos valores exclusivos.
SELECT DISTINCT web.channel AS canais, acc.name AS nome_conta
FROM web_events web
JOIN accounts acc ON web.account_id = acc.id
WHERE acc.id = 1001



-- Encontre todos os pedidos que ocorreram no ano 2015. Sua mesa final deve ter 4 colunas: occurred_at, nome da conta, total do pedido e total_amt_usd do pedido.
SELECT o.occurred_at AS data,
	   acc.name AS conta,
	   o.total AS total_do_pedido,
	   o.total_amt_usd AS total_pedido_USD
FROM orders o
JOIN accounts acc ON o.account_id = acc.id
WHERE o.occurred_at BETWEEN '2015-01-01' AND '2015-12-31'


