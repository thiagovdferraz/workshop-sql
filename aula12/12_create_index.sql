CREATE INDEX first_name_index ON pessoas(first_name);

SELECT first_name FROM pessoas WHERE first_name = 'aa';

EXPLAIN SELECT first_name FROM pessoas WHERE first_name LIKE 'aa%';

EXPLAIN SELECT * FROM pessoas;

EXPLAIN SELECT * FROM pessoas ORDER BY id;

EXPLAIN SELECT * FROM pessoas ORDER BY last_name;
