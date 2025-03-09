-- FUNCTION
CREATE OR REPLACE FUNCTION random_estado()
RETURNS VARCHAR(3) AS $$
BEGIN
   RETURN CASE floor(random() * 5)
         WHEN 0 THEN 'SP'
         WHEN 1 THEN 'RJ'
         WHEN 2 THEN 'MG'
         WHEN 3 THEN 'ES'
         ELSE 'DF'
         END;
END;
$$ LANGUAGE plpgsql;

-- Inserir dados na tabela pessoas com estados aleatórios
INSERT INTO pessoas (first_name, last_name, estado)
SELECT 
   substring(md5(random()::text), 0, 3),
   substring(md5(random()::text), 0, 3),
   random_estado()
FROM 
   generate_series(1, 10000000);