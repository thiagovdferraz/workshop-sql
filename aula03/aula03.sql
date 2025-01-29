-- 1. Cria um relatório para todos os pedidos de 1996 e seus clientes (152 linhas)
SELECT *
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1996; -- EXTRACT(part FROM date) part pode ser YEAR, MONTH, DAY, etc

-- 2. Cria um relatório que mostra o número de funcionários e clientes de cada cidade que tem funcionários (5 linhas)
SELECT e.city, COUNT(DISTINCT employee_id) qtde_emp, COUNT(DISTINCT c.customer_id) qtde_clientes
FROM employees e
LEFT JOIN customers c ON c.city = e.city
GROUP BY 1;

-- 3. Cria um relatório que mostra o número de funcionários e clientes de cada cidade que tem clientes (69 linhas)
SELECT c.city, COUNT(DISTINCT employee_id) qtde_emp, COUNT(DISTINCT c.customer_id) qtde_clientes
FROM customers c
LEFT JOIN employees e ON c.city = e.city
GROUP BY 1;

-- 4.Cria um relatório que mostra o número de funcionários e clientes de cada cidade (71 linhas)
SELECT COALESCE(c.city, e.city), COUNT(DISTINCT employee_id) qtde_emp, COUNT(DISTINCT c.customer_id) qtde_clientes
FROM customers c
FULL JOIN employees e ON c.city = e.city
GROUP BY 1;

-- 5. Cria um relatório que mostra a quantidade total de produtos encomendados.
SELECT SUM(quantity) qtde_produtos FROM order_details;

-- Mostra apenas registros para produtos para os quais a quantidade encomendada é menor que 200 (5 linhas)
SELECT product_id, SUM(quantity) qtde_produtos FROM order_details
GROUP BY 1
HAVING SUM(quantity) < 200;

-- 6. Cria um relatório que mostra o total de pedidos por cliente desde 31 de dezembro de 1996.
SELECT customer_id, COUNT(order_id) qtde_pedidos FROM orders
WHERE order_date >= '1996-12-31'
GROUP BY 1;

-- O relatório deve retornar apenas linhas para as quais o total de pedidos é maior que 15 (5 linhas)
SELECT customer_id, COUNT(order_id) qtde_pedidos FROM orders
WHERE order_date >= '1996-12-31'
GROUP BY 1
HAVING COUNT(order_id) > 15;