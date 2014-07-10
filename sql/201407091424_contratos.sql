BEGIN;

CREATE TABLE contratos (
	id SERIAL PRIMARY KEY,
	cliente_id INTEGER REFERENCES clientes(id),
	tipos_contrato_id INTEGER REFERENCES tipos_contrato(id),
	funcionario_id INTEGER,
	validade TIMESTAMP,
	valor DECIAMAL(10,2),
	descricao TEXT,
	stituacao VARCHAR DEFAULT 'cotacao',
	status BOOLEAN DEFAULT false,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP
);

CREATE TABLE arquivos (
	id SERIAL PRIMARY KEY,
	contrato_id INTEGER REFERENCES contratos(id),
	contrato_bin BYTEA,
	created_at TIMESTAMP DEFAULT now()
);

COMMIT;