-- --------     << TF >>     ------------
--
--                    SCRIPT DE CRIACAO (DDL)
--
-- Data Criacao ...........: 29/10/2019
-- Autor(es) ..............: Sara Silva
--                           Ícaro Pires
-- Banco de Dados .........: MySQL
-- Banco de Dados(nome) ...: tf_icaro_sara
--
-- Data Ultima Alteracao ..: 29/10/2019
--   => Criacao das tabelas
--   => Correção
--
-- PROJETO => 01 Base de Dados
--         => 04 Tabelas
--         => 01 Visoes
--         => 02 usuários
--
-- -----------------------------------------------------------------
CREATE DATABASE tf_icaro_sara;
USE tf_icaro_sara;

CREATE TABLE DEPARTAMENTO (
    nomeDepartamento VARCHAR(70) NOT NULL,

    CONSTRAINT DEPARTAMENTO_PK PRIMARY KEY(nomeDepartamento)
) Engine = InnoDB;

CREATE TABLE DELEGACIA (
    idDelegacia INTEGER NOT NULL AUTO_INCREMENT,
    nome VARCHAR(70) NOT NULL,
    cidade VARCHAR(50),

    nomeDepartamento VARCHAR(70) NOT NULL,

    CONSTRAINT DELEGACIA_PK PRIMARY KEY(idDelegacia),
    CONSTRAINT DELEGACIA_OCORRENCIA_PK FOREIGN KEY(nomeDepartamento)
        REFERENCES DEPARTAMENTO(nomeDepartamento)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT
) Engine = InnoDB;

CREATE TABLE BOLETIM (
    numBO INTEGER NOT NULL,
    anoBO INT NOT NULL,
    rubrica VARCHAR(50),

    idDelegacia INTEGER NOT NULL,

    CONSTRAINT BOLETIM_PK PRIMARY KEY(numBO, anoBO),
    CONSTRAINT BOLETIM_DELEGACIA_FK FOREIGN KEY(idDelegacia)
        REFERENCES DELEGACIA(idDelegacia)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT
) Engine = InnoDB;

CREATE TABLE OCORRENCIA (
    idOcorrencia INTEGER NOT NULL AUTO_INCREMENT,
    data DATE NOT NULL,
    desdobramento VARCHAR(500),
    status ENUM('C', 'T') NOT NULL,
    conduta VARCHAR(50),
    numero INT NOT NULL,
    logradouro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    latitude FLOAT,
    longitude FLOAT,

    numBO INTEGER NOT NULL,
    anoBO INT NOT NULL,

    CONSTRAINT OCORRENCIA_PK PRIMARY KEY(idOcorrencia),

    -- com a chave composta, a leitura do CSV insere valores errados
    CONSTRAINT OCORRENCIA_BOLETIM_FK FOREIGN KEY(numBO)
        REFERENCES BOLETIM(numBO)
            ON DELETE RESTRICT
            ON UPDATE RESTRICT
) Engine = InnoDB;
