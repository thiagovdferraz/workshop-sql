-- Select
SELECT * FROM customers;
select contact_name, city from customers;

-- Distinct
select country from customers;
select distinct country from customers;
select count(distinct country) from customers;

-- WHERE
-- Seleciona todos os clientes do México
SELECT * FROM customers WHERE country='Mexico';
-- Seleciona clientes com ID específico
SELECT * FROM customers WHERE customer_id='ANATR';
-- Utiliza AND para múltiplos critérios
SELECT * FROM customers WHERE country='Germany' AND city='Berlin';
-- Utiliza OR para mais de uma cidade
SELECT * FROM customers WHERE city='Berlin' OR city='Aachen';
-- Utiliza NOT para excluir a Alemanha
SELECT * FROM customers WHERE country<>'Germany';
-- Combina AND, OR e NOT
SELECT * FROM customers WHERE country='Germany' AND (city='Berlin' OR city='Aachen');
-- Exclui clientes da Alemanha e EUA
SELECT * FROM customers WHERE country<>'Germany' AND country<>'USA';

-- Seleciona todos os produtos com preço menor que 20
SELECT * FROM products
WHERE unit_price < 20;

-- Seleciona todos os produtos com preço maior que 100
SELECT * FROM products
WHERE unit_price > 100;

-- Seleciona todos os produtos com preço menor ou igual a 50
SELECT * FROM products
WHERE unit_price <= 50;

-- Seleciona todos os produtos com quantidade em estoque maior ou igual a 10
SELECT * FROM products
WHERE units_in_stock >= 10;

-- Seleciona todos os produtos cujo preço não é 30
SELECT * FROM products
WHERE unit_price <> 30;

-- Seleciona todos os produtos com preço entre 50 e 100 (exclusive)
SELECT * FROM products
WHERE unit_price >= 50 AND unit_price < 100;

-- Seleciona todos os produtos com preço fora do intervalo 20 a 40
SELECT * FROM products
WHERE unit_price < 20 OR unit_price > 40;

SELECT * FROM customers
WHERE region is Null;

SELECT * FROM customers
WHERE region is not null;

-- Nome do cliente começando com "a":
SELECT * FROM customers
WHERE contact_name LIKE 'A%';

SELECT * FROM customers
WHERE LOWER(contact_name) LIKE 'a%';

SELECT * FROM customers
WHERE UPPER(contact_name) LIKE 'A%';

-- Nome do cliente terminando com "a":
SELECT * FROM customers
WHERE contact_name LIKE '%a';

-- Nome do cliente terminando com "a":
SELECT * FROM customers
WHERE contact_name ILIKE '%a';

-- Nome do cliente que possui "or" em qualquer posição:
SELECT * FROM customers
WHERE contact_name LIKE '%or%';

-- Nome do cliente com "r" na segunda posição:
SELECT * FROM customers
WHERE contact_name LIKE '_r%';

-- Nome do cliente que começa com "A" e tem pelo menos 3 caracteres de comprimento:
SELECT * FROM customers
WHERE contact_name LIKE 'A_%_%';

-- Nome do contato que começa com "A" e termina com "o":
SELECT * FROM customers
WHERE contact_name LIKE 'A%o';

-- Nome do cliente que NÃO começa com "a":
SELECT * FROM customers
WHERE contact_name NOT LIKE 'A%';

-- Usando o curinga [charlist] (SQL server)
SELECT * FROM customers
WHERE city LIKE '[BSP]%';

-- Usando o curinga Similar To (Postgres)
SELECT * FROM customers
WHERE city SIMILAR TO '(B|S|P)%';

-- Usando o MySQL (coitado, tem nada)
SELECT * FROM customers
WHERE (city LIKE 'B%' OR city LIKE 'S%' OR city LIKE 'P%');

-- localizado na "Alemanha", "França" ou "Reino Unido":
SELECT * FROM customers
WHERE country IN ('Germany', 'France', 'UK');

-- NÃO localizado na "Alemanha", "França" ou "Reino Unido":
SELECT * FROM customers
WHERE country NOT IN ('Germany', 'France', 'UK');

-- Só para dar um gostinho de uma subqueyr... Seleciona todos os clientes que são dos mesmos países que os fornecedores:

SELECT * FROM customers
WHERE country IN (SELECT country FROM suppliers);

-- Exemplo com BETWEEN
SELECT * FROM products
WHERE unit_price BETWEEN 10 AND 20;

-- Exemplo com NOT BETWEEN
SELECT * FROM products
WHERE unit_price NOT BETWEEN 10 AND 20;

-- Seleciona todos os produtos com preço ENTRE 10 e 20. Adicionalmente, não mostra produtos com CategoryID de 1, 2 ou 3:
SELECT * FROM products
WHERE (unit_price BETWEEN 10 AND 20) AND category_id NOT IN (1, 2, 3);

--selects todos os produtos entre 'Carnarvon Tigers' e 'Mozzarella di Giovanni':
select * from products
where product_name between 'Carnarvon Tigers' and 'Mozzarella di Giovanni'
order by product_name;

--Selecione todas as ordens BETWEEN '04-July-1996' e '09-July-1996':
select * from orders
where order_date between '07/04/1996' and '07/09/1996';

-- SQL SERVER
-- Usando CONVERT
SELECT CONVERT(VARCHAR, order_date, 120) FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';

-- Usando FORMAT
SELECT FORMAT(order_date, 'yyyy-MM-dd') FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';

-- MY SQL
SELECT DATE_FORMAT(order_date, '%Y-%m-%d') FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';

-- ORACLE
SELECT TO_CHAR(order_date, 'YYYY-MM-DD') FROM orders
WHERE order_date BETWEEN TO_DATE('1996-04-07', 'YYYY-MM-DD') AND TO_DATE('1996-09-07', 'YYYY-MM-DD');

-- SQL LITE
SELECT strftime('%Y-%m-%d', order_date) FROM orders
WHERE order_date BETWEEN '1996-04-07' AND '1996-09-07';

-- AGREGAÇÕES
-- Exemplo de MIN()
SELECT MIN(unit_price) AS preco_minimo
FROM products;

-- Exemplo de MAX()
SELECT MAX(unit_price) AS preco_maximo
FROM products;

-- Exemplo de COUNT()
SELECT COUNT(*) AS total_de_produtos
FROM products;

-- Exemplo de AVG()
SELECT AVG(unit_price) AS preco_medio
FROM products;

-- Exemplo de SUM()
SELECT SUM(quantity) AS quantidade_total_de_order_details
FROM order_details;

-- Calcula o menor preço unitário de produtos em cada categoria
SELECT category_id, MIN(unit_price) AS preco_minimo
FROM products
GROUP BY category_id;

-- Calcula o maior preço unitário de produtos em cada categoria
SELECT category_id, MAX(unit_price) AS preco_maximo
FROM products
GROUP BY category_id;

-- Conta o número total de produtos em cada categoria
SELECT category_id, COUNT(*) AS total_de_produtos
FROM products
GROUP BY category_id;

-- Calcula o preço médio unitário de produtos em cada categoria
SELECT category_id, AVG(unit_price) AS preco_medio
FROM products
GROUP BY category_id;

-- Calcula a quantidade total de produtos pedidos por pedido
SELECT order_id, SUM(quantity) AS quantidade_total_por_pedido
FROM order_details
GROUP BY order_id;