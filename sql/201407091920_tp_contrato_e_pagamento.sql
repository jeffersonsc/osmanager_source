BEGIN;

CREATE TABLE tipos_contrato(
	id SERIAL PRIMARY KEY,
	nome VARCHAR,
	descricao VARCHAR,
	status BOOLEAN DEFAULT false,
	created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE formas_pagamento(
	id SERIAL PRIMARY KEY,
	nome VARCHAR,
	quantidade INTEGER,
	descricao VARCHAR,
	status BOOLEAN DEFAULT false,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP
);

COMMIT;