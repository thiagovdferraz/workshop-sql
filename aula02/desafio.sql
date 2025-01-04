-- 1. Obter todas as colunas das tabelas Clientes, Pedidos e Fornecedores
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM suppliers;

-- 2. Obter todos os Clientes em ordem alfabética por país e nome
SELECT * FROM customers
ORDER BY country, contact_name ASC;

-- 3. Obter os 5 pedidos mais antigos
SELECT * FROM orders
ORDER BY order_date ASC
LIMIT 5;


-- 4. Obter a contagem de todos os Pedidos feitos durante 1997
SELECT COUNT(*) AS qtde_pedidos FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 1997;

-- 5. Obter os nomes de todas as pessoas de contato onde a pessoa é um gerente, em ordem alfabética
SELECT DISTINCT * FROM customers
WHERE contact_title ILIKE '%manager%'
ORDER BY contact_name;


-- 6. Obter todos os pedidos feitos em 19 de maio de 1997
SELECT * FROM orders
WHERE order_date = '1997-05-19';
