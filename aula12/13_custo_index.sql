-- custo do indice em mb
SELECT pg_size_pretty(pg_relation_size('first_name_index'));

-- tamanho total da coluna
SELECT pg_size_pretty(pg_column_size(first_name)::bigint) AS tamanho_total
FROM pessoas;

-- tamanho total de todas as colunas
SELECT pg_size_pretty(SUM(pg_column_size(first_name)::bigint)) AS tamanho_total
FROM pessoas;