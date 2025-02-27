-- para os exercícios abaixo, desmarque a opção de auto commit do banco

-- atomicidade: Uma transação tem que ser "indivisivel"
-- Ou seja, todas as "queries" em uma transação precisam ter sucesso

-- Criar tabela
CREATE TABLE exemplo (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50)
);

-- Inserir dados
INSERT INTO exemplo (nome) VALUES ('A'), ('B'), ('C');

SELECT * FROM exemplo;

BEGIN;
INSERT INTO exemplo (nome) VALUES ('G'), ('H'), ('I');
COMMIT;

BEGIN;
DELETE FROM exemplo; -- deletei sem querer
SELECT * FROM exemplo; -- nao ha dados
ROLLBACK; -- dei rollback
SELECT * FROM exemplo; -- dados voltaram


DELETE FROM exemplo WHERE nome IN ('D', 'E', 'F');
SELECT * FROM exemplo;
COMMIT;
SELECT * FROM exemplo;