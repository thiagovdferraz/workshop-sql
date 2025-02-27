BEGIN;
SELECT nome, COUNT(nome) FROM exemplo
GROUP BY nome;

SELECT * FROM exemplo;

ROLLBACK;

-- cada sessão é isolada da outra
-- se eu dá um insert into em outra sessão, aqui continuará
-- com a tabela "congelada"
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN;
SELECT nome, count(nome) FROM exemplo
GROUP by nome;
SELECT * FROM exemplo;
COMMIT;


-- Configuração para Serializable
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN;
SELECT * FROM exemplo;

-- Voltar pro T1
INSERT INTO exemplo (nome) VALUES ('A');
COMMIT;

-- Voltar pro T2
INSERT INTO exemplo (nome) VALUES ('A');
COMMIT;