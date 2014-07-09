BEGIN;

CREATE TABLE servicos(
	id SERIAL PRIMARY KEY,
	nome VARCHAR,
	descricao VARCHAR,
	preco decimal(10,2),
	status BOOLEAN DEFAULT false,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP
);

COMMIT;