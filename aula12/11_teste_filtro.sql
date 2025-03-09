SELECT id FROM pessoas WHERE id = 100000;
SELECT * FROM pessoas WHERE id = 100000;
SELECT * FROM pessoas WHERE first_name = '26';

EXPLAIN ANALYZE SELECT id FROM pessoas WHERE id = 100000;

SELECT first_name FROM pessoas WHERE first_name = 'aa';

SELECT first_name FROM pessoas WHERE first_name LIKE '%a%';