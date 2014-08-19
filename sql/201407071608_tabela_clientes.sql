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

COMMIT;