-- CLIENTS table

DROP TABLE IF EXISTS clients;

CREATE TABLE IF NOT EXISTS clients (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    limite INTEGER NOT NULL,
    saldo INTEGER NOT NULL,
    CHECK (saldo >= -limite),
	CHECK (limite > 0)
);

SELECT * FROM clients;

INSERT INTO clients (limite, saldo)
VALUES
    (10000, 0),
    (80000, 0),
    (1000000, 0),
    (10000000, 0),
    (500000, 0);

SELECT * FROM clients;

UPDATE clients
SET saldo = saldo - 80000
WHERE id = '696bf0bd-3b36-4814-8108-d361a4ee8ff6'; -- Substitua pelo ID do cliente desejado

-- como a transacao é maior que o limite disponivel em conta, ela nao sera processada
SELECT * FROM clients;
SELECT * FROM transactions;
--TRUNCATE TABLE transactions;
