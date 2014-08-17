BEGIN;

	CREATE TABLE chamados (
		id SERIAL PRIMARY KEY,
		cliente_id INTEGER REFERENCES clientes(id),
		servico_id INTEGER REFERENCES servicos(id),
		funcionario_id INTEGER REFERENCES funcionarios(id),
		atribuido_para INTEGER REFERENCES funcionarios(id),
		descricao VARCHAR,
		hora_saida TIMESTAMP,
		hora_chegada TIMESTAMP,
		solicitante VARCHAR,
		tel_contato VARCHAR,
		status BOOLEAN DEFAULT false,
		valor_total DECIMAL(10,2),
		agendamento BOOLEAN,
		created_at TIMESTAMP DEFAULT now(),
		updated_at TIMESTAMP
	);

	CREATE TABLE historico_chamados(
		id SERIAL PRIMARY KEY,
		chamado_id INTEGER REFERENCES chamados(id),
		funcionario_id INTEGER REFERENCES funcionarios(id),
		historico TEXT,
		created_at TIMESTAMP DEFAULT now()
	);

COMMIT;