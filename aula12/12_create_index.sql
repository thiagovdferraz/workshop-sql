CREATE INDEX first_name_index ON pessoas(first_name);

SELECT first_name FROM pessoas WHERE first_name = 'aa';

SELECT first_name FROM pessoas WHERE first_name LIKE '%aa%';
