-- metodo criar tabela com primary key sequencial (nao recomendado)
CREATE TABLE IF NOT EXISTS 	clients (
	id SERIAL PRIMARY KEY NOT NULL,
	saldo INTEGER NOT NULL,
	limite INTEGER NOT NULL
);

INSERT INTO clients (limite, saldo)
VALUES
    (10000, 0),
    (80000, 0),
    (1000000, 0),
    (10000000, 0),
    (500000, 0);

DROP TABLE clients;

-- tabela definitiva com uuid em vez de sequencial
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS clients (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    limite INTEGER NOT NULL,
    saldo INTEGER NOT NULL
);

INSERT INTO clients (limite, saldo)
VALUES
    (10000, 0),
    (80000, 0),
    (1000000, 0),
    (10000000, 0),
    (500000, 0);

SELECT * FROM clients;

-- transation table
CREATE TABLE IF NOT EXISTS transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tipo CHAR(1) NOT NULL,
    descricao VARCHAR(10) NOT NULL,
    valor INTEGER NOT NULL,
    cliente_id UUID NOT NULL,
    realizada_em TIMESTAMP NOT NULL DEFAULT NOW()
);

SELECT * FROM transactions;

-- fazer uma transacao bancaria no cliente 3f33fb65-5d4b-4abf-943a-fe53952a203b
INSERT INTO transactions (tipo, descricao, valor, cliente_id)
VALUES ('d', 'Carro', 80000, '3f33fb65-5d4b-4abf-943a-fe53952a203b');

SELECT * FROM transactions;

-- alterar saldo final
UPDATE clients
SET saldo = saldo - 80000
WHERE id = '3f33fb65-5d4b-4abf-943a-fe53952a203b'; -- Substitua pelo ID do cliente desejado

SELECT * FROM clients;