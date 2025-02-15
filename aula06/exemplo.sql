-- subqueries
SELECT product_id FROM (
SELECT product_id 
FROM (
	SELECT product_id, rank
	FROM (SELECT 
			product_id,
			SUM( det.quantity * det.unit_price * ( 1 - det.discount )) sold_value,
			RANK() OVER (ORDER BY SUM( det.quantity * det.unit_price * ( 1 - det.discount )) DESC) rank -- WINDOWS FUNCTION
		FROM order_details det
		GROUP BY det.product_id
		ORDER BY rank)
	WHERE rank <= 5 )
WHERE product_id BETWEEN 35 and 65 )
ORDER BY product_id DESC;

-- query acima com cte
WITH CalculatedValues AS (
-- Calcula o valor vendido e o rank para cada produto
SELECT 
    product_id,
    SUM(det.quantity * det.unit_price * (1 - det.discount)) AS sold_value,
    RANK() OVER (ORDER BY SUM(det.quantity * det.unit_price * (1 - det.discount)) DESC) AS rank
FROM order_details det
GROUP BY product_id
),
TopRankedProducts AS (
    -- Seleciona apenas os produtos com rank entre os top 5
    SELECT 
        product_id
    FROM CalculatedValues
    WHERE rank <= 5
),
FilteredProducts AS (
    -- Filtra os produtos com IDs entre 35 e 65
    SELECT 
        product_id
    FROM TopRankedProducts
    WHERE product_id BETWEEN 35 AND 65
)
-- Seleciona e ordena os produtos finais
SELECT product_id
FROM FilteredProducts
ORDER BY product_id DESC;


-- ctes

WITH TotalRevenues AS (
    SELECT 
        customers.company_name, 
        SUM(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) AS total
    FROM customers
    INNER JOIN orders ON customers.customer_id = orders.customer_id
    INNER JOIN order_details ON order_details.order_id = orders.order_id
    GROUP BY customers.company_name
)
SELECT * FROM TotalRevenues;