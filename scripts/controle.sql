-- -------------------- TF ----------------------------------
--
--                    SCRIPT DE CONTROLE (DML)
--
-- Data Criacao ...........: 21/11/2019
-- Autor(es) ..............: Sara Silva
--                           Ícaro Pires
-- Banco de Dados .........: MySQL
-- Banco de Dados(nome) ...: tf_icaro_sara
--
-- Data Ultima Alteracao ..: 21/11/2019
--   => criação de usuários
--
-- PROJETO => 01 Base de Dados
--         => 04 Tabelas
--         => 01 Visoes
--         => 02 usuários
--
-- -----------------------------------------------------------------

USE tf_icaro_sara;

create user admin identified by '@d2019';
grant all privileges on tf_icaro_sara.* to admin;    

create user usuario identified by 'uso2019';
grant select on tf_icaro_sara.* to usuario;
