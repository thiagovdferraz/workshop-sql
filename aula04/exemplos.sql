-- Calcular: Quantos produtos únicos existem? Quantos produtos no total? Qual é o valor total pago?
SELECT order_id,
       COUNT(DISTINCT product_id) AS total_unique_product,
       SUM(quantity) AS total_quantity,
       SUM(unit_price * quantity) AS total_price
FROM order_details
GROUP BY order_id
ORDER BY order_id;

-- mesmo problema com windows function
SELECT DISTINCT order_id,
   COUNT(product_id) OVER (PARTITION BY order_id) AS total_unique_product,
   SUM(quantity) OVER (PARTITION BY order_id) AS total_quantity,
   SUM(unit_price * quantity) OVER (PARTITION BY order_id) AS total_price
FROM order_details
ORDER BY order_id;

-- Quais são os valores mínimo, máximo e médio de frete pago por cada cliente? (tabela orders)
EXPLAIN ANALYZE
SELECT customer_id,
   MIN(freight) AS min_freight,
   MAX(freight) AS max_freight,
   AVG(freight) AS avg_freight
FROM orders
GROUP BY customer_id
ORDER BY customer_id;

-- mesmo problema com windows function
EXPLAIN ANALYZE
SELECT DISTINCT customer_id,
   MIN(freight) OVER (PARTITION BY customer_id) AS min_freight,
   MAX(freight) OVER (PARTITION BY customer_id) AS max_freight,
   AVG(freight) OVER (PARTITION BY customer_id) AS avg_freight
FROM orders
ORDER BY customer_id;

-- RANK(), DENSE_RANK() e ROW_NUMBER()

--RANK(): Atribui um rank único a cada linha, deixando lacunas em caso de empates.
--DENSE_RANK(): Atribui um rank único a cada linha, com ranks contínuos para linhas empatadas.
--ROW_NUMBER(): Atribui um número inteiro sequencial único a cada linha, independentemente de empates, sem lacunas.

-- ex: o mesmo produto pode ficar em primeiro por ter vendido muito por ORDER e depois ficar em segundo por ter vendido muito por ORDER
SELECT DISTINCT
  o.order_id, 
  p.product_name, 
  (o.unit_price * o.quantity) AS sales_total,
  ROW_NUMBER() OVER (ORDER BY (o.unit_price * o.quantity) DESC) AS order_row_number, 
  RANK() OVER (ORDER BY (o.unit_price * o.quantity) DESC) AS order_rank, 
  DENSE_RANK() OVER (ORDER BY (o.unit_price * o.quantity) DESC) AS order_dense_rank
FROM  
  order_details o
JOIN 
  products p ON p.product_id = o.product_id
  ORDER BY order_row_number ASC;

-- por produto
  SELECT DISTINCT
  p.product_name, 
  (sum(o.unit_price * o.quantity)) AS sales_total,
  ROW_NUMBER() OVER (ORDER BY (sum(o.unit_price * o.quantity)) DESC) AS order_row_number, 
  RANK() OVER (ORDER BY (sum(o.unit_price * o.quantity)) DESC) AS order_rank, 
  DENSE_RANK() OVER (ORDER BY (sum(o.unit_price * o.quantity)) DESC) AS order_dense_rank
FROM  
  order_details o
JOIN 
  products p ON p.product_id = o.product_id
  GROUP BY p.product_name
  ORDER BY order_row_number ASC;

-- Funções PERCENT_RANK() e CUME_DIST()
-- Ambos retornam um valor entre 0 e 1

-- PERCENT_RANK(): Calcula o rank relativo de uma linha específica dentro do conjunto de resultados como uma porcentagem. É computado usando a seguinte fórmula:
-- RANK é o rank da linha dentro do conjunto de resultados.
-- N é o número total de linhas no conjunto de resultados.
-- PERCENT_RANK = (RANK - 1) / (N - 1)
-- CUME_DIST(): Calcula a distribuição acumulada de um valor no conjunto de resultados. Representa a proporção de linhas que são menores ou iguais à linha atual. A fórmula é a seguinte:
-- CUME_DIST = (Número de linhas com valores <= linha atual) / (Número total de linhas)
-- Ambas as funções PERCENT_RANK() e CUME_DIST() são valiosas para entender a distribuição e posição de pontos de dados dentro de um conjunto de dados, particularmente em cenários onde você deseja comparar a posição de um valor específico com a distribuição geral de dados.

SELECT  
  order_id, 
  unit_price * quantity AS total_sale,
  ROUND(CAST(PERCENT_RANK() OVER (PARTITION BY order_id 
    ORDER BY (unit_price * quantity) DESC) AS numeric), 2) AS order_percent_rank,
  ROUND(CAST(CUME_DIST() OVER (PARTITION BY order_id 
    ORDER BY (unit_price * quantity) DESC) AS numeric), 2) AS order_cume_dist
FROM  
  order_details;

-- A função NTILE() no SQL é usada para dividir o conjunto de resultados em um número especificado 
-- de partes aproximadamente iguais ou "faixas" e atribuir um número de grupo ou "bucket" a cada linha com base em sua posição dentro do conjunto de resultados ordenado.
-- Exemplo: Listar funcionários dividindo-os em 3 grupos
  SELECT first_name, last_name, title,
   NTILE(3) OVER (ORDER BY first_name) AS group_number
FROM employees;

-- LAG(), LEAD()

-- LAG(): Permite acessar o valor da linha anterior dentro de um conjunto de resultados. Isso é particularmente útil para fazer comparações com a linha atual ou identificar tendências ao longo do tempo.
-- LEAD(): Permite acessar o valor da próxima linha dentro de um conjunto de resultados, possibilitando comparações com a linha subsequente.
-- Exemplo: Ordenando os custos de envio pagos pelos clientes de acordo com suas datas de pedido:

SELECT 
  customer_id, 
  TO_CHAR(order_date, 'YYYY-MM-DD') AS order_date, 
  shippers.company_name AS shipper_name,
  freight AS order_freight,
  LAG(freight) OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS previous_order_freight, 
  LEAD(freight) OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS next_order_freight
FROM 
  orders
JOIN 
  shippers ON shippers.shipper_id = orders.ship_via;