-- create a index on first name column
CREATE INDEX first_name_index ON pessoas(first_name);

-- test a count row on a column with index
SELECT COUNT(*) FROM pessoas WHERE first_name = 'aa';

-- a column without index 
SELECT COUNT(*) FROM pessoas WHERE last_name = 'aa'