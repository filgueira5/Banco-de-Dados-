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

-- Criação da tabela aeroporto com a mesma estrutura da tabela geralcontent
CREATE TABLE aeroporto AS
    SELECT seguradora, aeroporto, sigla_aeroporto
    FROM geralcontent
    LIMIT 0;

-- Inserção dos dados da tabela geralcontent para a tabela aeroporto
INSERT INTO aeroporto (seguradora, aeroporto, sigla_aeroporto)
    SELECT seguradora, aeroporto, sigla_aeroporto
    FROM geralcontent;

-- Criação da tabela tipo_seguro com a mesma estrutura da tabela geralcontent
CREATE TABLE tipo_seguro AS
    SELECT aeroporto, tipo_do_seguro
    FROM geralcontent
    LIMIT 0;

-- Inserção dos dados da tabela geralcontent para a tabela tipo_seguro
INSERT INTO tipo_seguro (aeroporto, tipo_do_seguro)
    SELECT aeroporto, tipo_do_seguro
    FROM geralcontent;

-- Criação da tabela seguradora com a mesma estrutura da tabela geralcontent
CREATE TABLE seguradora AS
    SELECT aeroporto, seguradora
    FROM geralcontent
    LIMIT 0;

-- Inserção dos dados da tabela geralcontent para a tabela seguradora
INSERT INTO seguradora (aeroporto, seguradora)
    SELECT aeroporto, seguradora
    FROM geralcontent;
    
CREATE TABLE concessao AS 
    SELECT concessao, aeroporto FROM geralcontent LIMIT 0;

INSERT INTO concessao (concessao, aeroporto)
    SELECT concessao, aeroporto
    FROM geralcontent;

CREATE TABLE apolice AS 
    SELECT aeroporto, seguradora, numero_apolice FROM geralcontent LIMIT 0;

INSERT INTO apolice (aeroporto, seguradora, numero_apolice)
    SELECT aeroporto, seguradora, numero_apolice
    FROM geralcontent;

CREATE TABLE vigencia AS
    SELECT inicio_vigencia, fim_vigencia FROM geralcontent LIMIT 0;

INSERT INTO vigencia (inicio_vigencia, fim_vigencia)
    SELECT inicio_vigencia, fim_vigencia
    FROM geralcontent;

-- Exibindo os dados das tabelas criadas
SELECT * FROM aeroporto;
SELECT * FROM tipo_seguro;
SELECT * FROM seguradora;
SELECT * FROM concessao;
SELECT * FROM apolice;
SELECT * FROM vigencia;
