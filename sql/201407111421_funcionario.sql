BEGIN;

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


COMMIT;