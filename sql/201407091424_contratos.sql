BEGIN;

CREATE TABLE contratos (
	id SERIAL PRIMARY KEY,
	cliente_id INTEGER REFERENCES clientes(id),
	tipos_contrato_id INTEGER REFERENCES tipos_contrato(id),
	funcionario_id INTEGER,
	validade TIMESTAMP,
	valor NUMERIC(10,2),
	forma_pagamento_id INTEGER REFERENCES formas_pagamento(id),
	stituacao VARCHAR DEFAULT 'prospeccao',
	status BOOLEAN DEFAULT false,
	contrato_bin BYTEA,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP
);

COMMIT;