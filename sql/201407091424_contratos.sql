BEGIN;

CREATE TABLE tipos_pagamento_contrato (
	id SERIAL PRIMARY KEY,
	nome VARCHAR,
	created_at TIMESTAMP DEFAULT now()
);

INSERT INTO tipos_pagamento_contrato (nome) VALUES ('Mensal');
INSERT INTO tipos_pagamento_contrato (nome) VALUES ('Bimestral');
INSERT INTO tipos_pagamento_contrato (nome) VALUES ('Trimestral');
INSERT INTO tipos_pagamento_contrato (nome) VALUES ('Semestral');
INSERT INTO tipos_pagamento_contrato (nome) VALUES ('Anual');

CREATE TABLE contratos (
	id SERIAL PRIMARY KEY,
	cliente_id INTEGER REFERENCES clientes(id),
	tipos_contrato_id INTEGER REFERENCES tipos_contrato(id),
	tipo_pagamento_contrato_id INTEGER REFERENCES tipos_pagamento_contrato(id),
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
	content_type VARCHAR,
	filename VARCHAR,
	status BOOLEAN DEFAULT false,
	created_at TIMESTAMP DEFAULT now()
);

COMMIT;