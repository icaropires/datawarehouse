/*
Columns
=======

1  - NUM_BO
2  - ANO_BO
3  - ID_DELEGACIA
4  - NOME_DEPARTAMENTO
5  - NOME_SECCIONAL
6  - DELEGACIA
7  - NOME_DEPARTAMENTO_CIRC
8  - NOME_SECCIONAL_CIRC
9  - NOME_DELEGACIA_CIRC
10 - ANO
11 - MES
12 - FLAG_STATUS
13 - RUBRICA
14 - DESDOBRAMENTO
15 - CONDUTA
16 - LATITUDE
17 - LONGITUDE
18 - CIDADE
19 - LOGRADOURO
20 - NUMERO_LOGRADOURO
21 - FLAG_STATUS
*/


CREATE DATABASE tf_icaro_sara;
USE tf_icaro_sara;

CREATE TABLE BOLETIM_DE_OCORRENCIA (
    num INTEGER NOT NULL,
    ano INT NOT NULL,
    id_delegacia INTEGER NOT NULL
) Engine = InnoDB;

LOAD DATA LOCAL INFILE '/dataset/BO_2016.csv' 
    REPLACE
    INTO TABLE BOLETIM_DE_OCORRENCIA
    CHARACTER SET 'utf8'
    FIELDS
        TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
    LINES
        TERMINATED BY '\n'
    IGNORE 1 LINES
    (@num_bo, @ano_bo, @id_delegacia, @nome_departamento, @nome_seccional, @delegacia, @nome_departamento_circ, @nome_seccional_circ, @nome_delegacia_circ, @ano, @mes, @flag_status, @rubrica, @desdobramento, @conduta, @latitude, @longitude, @cidade, @logradouro, @numero_logradouro, @flag_status, @dummy)
    SET num = @num_bo,
        ano = @ano_bo,
        id_delegacia = @id_delegacia;
