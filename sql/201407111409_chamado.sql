BEGIN;

	CREATE TABLE chamados (
		id SERIAL PRIMARY KEY,
		cliente_id INTEGER REFERENCES cliente(id),
		servico_id INTEGER REFERENCES servicos(id),
		funcionario_id INTEGER REFERENCES funcionarios(id),
		descricao VARCHAR,
		hora_saida TIMESTAMP,
		hora_chegada TIMESTAMP,
		status BOOLEAN DEFAULT false,
		created_at TIMESTAMP DEFAULT now();
		updated_at TIMESTAMP,
	);

	CREATE TABLE historico_chamados(
		id SERIAL PRIMARY KEY,
		chamado_id REFERENCES chamados(id)
		funcionario_id REFERENCES funcionarios(id)
		historico TEXT,
		created_at TIMESTAMP DEFAULT now()
	);

COMMIT;