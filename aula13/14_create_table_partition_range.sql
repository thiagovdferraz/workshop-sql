drop table pessoas_part_range;

CREATE TABLE pessoas_part_range (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(3),
	last_name VARCHAR(3),
	estado VARCHAR(3)
) PARTITION BY RANGE (id);

select * from pessoas_part_range;

CREATE TABLE pessoas_part1 PARTITION OF pessoas_part_range FOR VALUES FROM (MINVALUE) TO (2000001);
CREATE TABLE pessoas_part2 PARTITION OF pessoas_part_range FOR VALUES FROM (2000001) TO (4000001);
CREATE TABLE pessoas_part3 PARTITION OF pessoas_part_range FOR VALUES FROM (4000001) TO (6000001);
CREATE TABLE pessoas_part4 PARTITION OF pessoas_part_range FOR VALUES FROM (6000001) TO (8000001);
CREATE TABLE pessoas_part5 PARTITION OF pessoas_part_range FOR VALUES FROM (8000001) TO (MAXVALUE);

INSERT INTO pessoas_part_range (first_name, last_name, estado)
SELECT 
  substring(md5(random()::text), 0, 3),
  substring(md5(random()::text), 0, 3),
  random_estado()
FROM 
  generate_series(1, 10000000);


select * from pessoas_part_range where id = 1545;