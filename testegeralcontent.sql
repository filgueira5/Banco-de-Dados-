-- Deleta as tabelas caso existam
DROP TABLE IF EXISTS geralcontent;
DROP TABLE IF EXISTS aeroporto;
DROP TABLE IF EXISTS tipo_seguro;
DROP TABLE IF EXISTS seguradora;
DROP TABLE IF EXISTS concessao;
DROP TABLE IF EXISTS apolice;
DROP TABLE IF EXISTS vigencia;

-- Criação da tabela geralcontent
CREATE TABLE geralcontent (
    id SERIAL PRIMARY KEY, 
    concessao VARCHAR(45) NULL,
    aeroporto VARCHAR(45) NULL,
    sigla_aeroporto VARCHAR(25) NULL,
    abrangencia_seguro VARCHAR(45) NOT NULL,
    tipo_do_seguro VARCHAR(100),
    numero_apolice VARCHAR(100) NOT NULL,
    seguradora VARCHAR(75),
    inicio_vigencia date NOT NULL,
    fim_vigencia date NOT NULL
);

-- Importação dos dados do arquivo CSV para a tabela geralcontent
COPY geralcontent
    FROM '/tmp/dadosaeroportuarios.csv'
    CSV HEADER DELIMITER ';' QUOTE '"';

-- Criação da tabela aeroporto
CREATE TABLE aeroporto (
    id SERIAL PRIMARY KEY, 
    seguradora VARCHAR(75),
    aeroporto VARCHAR(45),
    sigla_aeroporto VARCHAR(25),
    UNIQUE(aeroporto, sigla_aeroporto)
);

-- Inserção dos dados da tabela geralcontent para a tabela aeroporto
INSERT INTO aeroporto (seguradora, aeroporto, sigla_aeroporto)
    SELECT seguradora, aeroporto, sigla_aeroporto
    FROM geralcontent;

-- Criação da tabela tipo_seguro
CREATE TABLE tipo_seguro (
    id SERIAL PRIMARY KEY,
    aeroporto VARCHAR(45),
    tipo_do_seguro VARCHAR(100),
    FOREIGN KEY (aeroporto) REFERENCES aeroporto(aeroporto)
);

-- Inserção dos dados da tabela geralcontent para a tabela tipo_seguro
INSERT INTO tipo_seguro (aeroporto, tipo_do_seguro)
    SELECT aeroporto, tipo_do_seguro
    FROM geralcontent;

-- Criação da tabela seguradora
CREATE TABLE seguradora (
    id SERIAL PRIMARY KEY,
    aeroporto VARCHAR(45),
    seguradora VARCHAR(75),
    FOREIGN KEY (aeroporto) REFERENCES aeroporto(aeroporto)
);

-- Inserção dos dados da tabela geralcontent para a tabela seguradora
INSERT INTO seguradora (aeroporto, seguradora)
    SELECT aeroporto, seguradora
    FROM geralcontent;
    
-- Criação da tabela concessao
CREATE TABLE concessao (
    id SERIAL PRIMARY KEY,
    concessao VARCHAR(45),
    aeroporto VARCHAR(45),
    FOREIGN KEY (aeroporto) REFERENCES aeroporto(aeroporto)
);

-- Inserção dos dados da tabela geralcontent para a tabela concessao
INSERT INTO concessao (concessao, aeroporto)
    SELECT concessao, aeroporto
    FROM geralcontent;

-- Criação da tabela apolice
CREATE TABLE apolice (
    id SERIAL PRIMARY KEY,
    aeroporto VARCHAR(45),
    seguradora VARCHAR(75),
    numero_apolice VARCHAR(100),
    FOREIGN KEY (aeroporto) REFERENCES aeroporto(aeroporto),
    FOREIGN KEY (seguradora) REFERENCES seguradora(seguradora)
);

-- Inserção dos dados da tabela geralcontent para a tabela apolice
INSERT INTO apolice (aeroporto, seguradora, numero_apolice)
    SELECT aeroporto, seguradora, numero_apolice
    FROM geralcontent;

-- Criação da tabela vigencia
CREATE TABLE vigencia (
    id SERIAL PRIMARY KEY,
    inicio_vigencia date,
    fim_vigencia date,
    aeroporto VARCHAR(45),
    FOREIGN KEY (aeroporto) REFERENCES aeroporto(aeroporto)
);

-- Inserção dos dados da tabela geralcontent para a tabela vigencia
INSERT INTO vigencia (inicio_vigencia, fim_vigencia, aeroporto)
    SELECT inicio_vigencia, fim_vigencia, aeroporto
    FROM geralcontent;

-- Excluindo as colunas da tabela geralcontent que já foram transferidas para as tabelas secundárias
ALTER TABLE geralcontent
    DROP COLUMN aeroporto,
    DROP COLUMN sigla_aeroporto,
    DROP COLUMN tipo_do_seguro,
    DROP COLUMN seguradora,
    DROP COLUMN concessao,
    DROP COLUMN numero_apolice,
    DROP COLUMN inicio_vigencia,
    DROP COLUMN fim_vigencia;

-- Exibindo os dados das tabelas criadas
SELECT * FROM aeroporto;
SELECT * FROM tipo_seguro;
SELECT * FROM seguradora;
SELECT * FROM concessao;
SELECT * FROM apolice;
SELECT * FROM vigencia;

-- Realizando os joins para exibir dados combinados
SELECT 
    g.id, 
    a.aeroporto, 
    a.sigla_aeroporto, 
    t.tipo_do_seguro, 
    s.seguradora, 
    c.concessao, 
    p.numero_apolice, 
    v.inicio_vigencia, 
    v.fim_vigencia
FROM 
    geralcontent g
JOIN 
    aeroporto a ON g.aeroporto = a.aeroporto
JOIN 
    tipo_seguro t ON g.aeroporto = t.aeroporto
JOIN 
    seguradora s ON g.aeroporto = s.aeroporto
JOIN 
    concessao c ON g.aeroporto = c.aeroporto
JOIN 
    apolice p ON g.aeroporto = p.aeroporto AND g.seguradora = p.seguradora
JOIN 
    vigencia v ON g.aeroporto = v.aeroporto;
