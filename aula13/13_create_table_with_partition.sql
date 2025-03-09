--DROP TABLE pessoas_partition;

CREATE TABLE pessoas_partition (
    id SERIAL,
    first_name VARCHAR(3),
    last_name VARCHAR(3),
    estado VARCHAR(3),
    PRIMARY KEY (id, estado)
) PARTITION BY LIST (estado);

select * from pessoas_partition;

-- Criar as partições
CREATE TABLE pessoas_sp PARTITION OF pessoas_partition FOR VALUES IN ('SP');
CREATE TABLE pessoas_rj PARTITION OF pessoas_partition FOR VALUES IN ('RJ');
CREATE TABLE pessoas_mg PARTITION OF pessoas_partition FOR VALUES IN ('MG');
CREATE TABLE pessoas_es PARTITION OF pessoas_partition FOR VALUES IN ('ES');
CREATE TABLE pessoas_df PARTITION OF pessoas_partition FOR VALUES IN ('DF');

select * from pessoas_partition;

INSERT INTO pessoas_partition (first_name, last_name, estado)
   SELECT 
      substring(md5(random()::text), 0, 3),
      substring(md5(random()::text), 0, 3),
      random_estado()
   FROM 
      generate_series(1, 10000000);

select * from pessoas_partition;
select count(*) from pessoas_partition where estado = 'RJ';