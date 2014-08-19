BEGIN;

CREATE TABLE clientes (
id SERIAL PRIMARY KEY,
nome VARCHAR(100),
nome_mae VARCHAR(100),
nome_pai VARCHAR(100),
sexo CHAR(1),
dt_nascimento VARCHAR,
cpf VARCHAR,
rg VARCHAR(15),
ssp CHAR(2),
naturalidade VARCHAR,
nome_responsavel VARCHAR(100),
cnpj VARCHAR,
ie VARCHAR(9),
cep varchar,
endereco VARCHAR(100),
numero INTEGER,
complemento VARCHAR(50),
bairro VARCHAR(60),
cidade VARCHAR(60),
estado CHAR(2),
telefone1 VARCHAR(15),
telefone2 VARCHAR(15),
telefone3 VARCHAR(15),
celular VARCHAR(15),
email VARCHAR(80),
tp_cliente BOOLEAN,
status BOOLEAN DEFAULT false,
inativo BOOLEAN DEFAULT false,
created_at TIMESTAMP DEFAULT now(),
updated_at TIMESTAMP
);

CREATE TABLE servicos(
	id SERIAL PRIMARY KEY,
	nome VARCHAR,
	descricao VARCHAR,
	preco decimal(10,2),
	status BOOLEAN DEFAULT false,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP
);

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

CREATE TABLE tipos_contrato(
	id SERIAL PRIMARY KEY,
	nome VARCHAR,
	descricao VARCHAR,
	status BOOLEAN DEFAULT false,
	created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE contratos (
	id SERIAL PRIMARY KEY,
	cliente_id INTEGER REFERENCES clientes(id),
	tipos_contrato_id INTEGER REFERENCES tipos_contrato(id),
	tipo_pagamento_contrato_id INTEGER REFERENCES tipos_pagamento_contrato(id),
	funcionario_id INTEGER,
	validade TIMESTAMP,
	valor DECIMAL(10,2),
	descricao TEXT,
	situacao VARCHAR DEFAULT 'cotacao',
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

	CREATE TABLE cargos (
	id SERIAL PRIMARY KEY,
	nome VARCHAR,
	descricao VARCHAR,
	status BOOLEAN DEFAULT false,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP
);

CREATE TABLE funcionarios (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100),
	nome_mae VARCHAR(100),
	nome_pai VARCHAR(100),
	sexo CHAR(1),
	dt_nascimento VARCHAR,
	cpf VARCHAR,
	rg VARCHAR(15),
	ssp CHAR(2),
	naturalidade VARCHAR,
	cep varchar,
	endereco VARCHAR(100),
	numero INTEGER,
	complemento VARCHAR(50),
	bairro VARCHAR(60),
	cidade VARCHAR(60),
	estado CHAR(2),
	telefone VARCHAR(15),
	celular VARCHAR(15),
	email VARCHAR(80),
	status BOOLEAN DEFAULT false,
	cargo_id integer REFERENCES cargos(id),
	dt_admissao TIMESTAMP,
	usuario VARCHAR,
	senha VARCHAR,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP
);

INSERT INTO funcionarios (name , usuario , senha) VALUES ('Administrador' , 'admin' , 'c93ccd78b2076528346216b3b2f701e6');

COMMIT;