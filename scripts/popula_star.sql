/*
CSV Columns
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

SET sql_mode = ''; -- Allow zero day

LOAD DATA LOCAL INFILE '/dataset/BO_2016.csv' 
    REPLACE
    INTO TABLE TEMPO
    CHARACTER SET 'utf8'
    FIELDS
        TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
    LINES
        TERMINATED BY '\n'
    IGNORE 1 LINES
    (@num_bo, @ano_bo, @id_delegacia, @nome_departamento, @nome_seccional, @delegacia, @nome_departamento_circ, @nome_seccional_circ, @nome_delegacia_circ, @ano, @mes, @flag_status, @rubrica, @desdobramento, @conduta, @latitude, @longitude, @cidade, @logradouro, @numero_logradouro, @flag_status, @dummy)
    SET data = STR_TO_DATE(CONCAT(@mes, '-', @ano), '%m-%Y');

LOAD DATA LOCAL INFILE '/dataset/BO_2016.csv' 
    REPLACE
    INTO TABLE LOCAL
    CHARACTER SET 'utf8'
    FIELDS
        TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
    LINES
        TERMINATED BY '\n'
    IGNORE 1 LINES
    (@num_bo, @ano_bo, @id_delegacia, @nome_departamento, @nome_seccional, @delegacia, @nome_departamento_circ, @nome_seccional_circ, @nome_delegacia_circ, @ano, @mes, @flag_status, @rubrica, @desdobramento, @conduta, @latitude, @longitude, @cidade, @logradouro, @numero_logradouro, @flag_status, @dummy)
    SET latitude = @latitude,
        longitude = @longitude,
        logradouro = @logradouro,
        cidade = @cidade,
        numero = @numero_logradouro

LOAD DATA LOCAL INFILE '/dataset/BO_2016.csv' 
    REPLACE
    INTO TABLE BOLETIM
    CHARACTER SET 'utf8'
    FIELDS
        TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
    LINES
        TERMINATED BY '\n'
    IGNORE 1 LINES
    (@num_bo, @ano_bo, @id_delegacia, @nome_departamento, @nome_seccional, @delegacia, @nome_departamento_circ, @nome_seccional_circ, @nome_delegacia_circ, @ano, @mes, @flag_status, @rubrica, @desdobramento, @conduta, @latitude, @longitude, @cidade, @logradouro, @numero_logradouro, @flag_status, @dummy)
    SET numBO = @num_bo,
        anoBO = @ano_bo,
        rubrica = @rubrica,

LOAD DATA LOCAL INFILE '/dataset/BO_2016.csv' 
    REPLACE
    INTO TABLE DELEGACIA
    CHARACTER SET 'utf8'
    FIELDS
        TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
    LINES
        TERMINATED BY '\n'
    IGNORE 1 LINES
    (@num_bo, @ano_bo, @id_delegacia, @nome_departamento, @nome_seccional, @delegacia, @nome_departamento_circ, @nome_seccional_circ, @nome_delegacia_circ, @ano, @mes, @flag_status, @rubrica, @desdobramento, @conduta, @latitude, @longitude, @cidade, @logradouro, @numero_logradouro, @flag_status, @dummy)
    SET nome = @delegacia,
        cidade = @cidade,
        departamento = @nome_departamento;

LOAD DATA LOCAL INFILE '/dataset/BO_2016.csv' 
    REPLACE
    INTO TABLE STATUS
    CHARACTER SET 'utf8'
    FIELDS
        TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
    LINES
        TERMINATED BY '\n'
    IGNORE 1 LINES
    (@num_bo, @ano_bo, @id_delegacia, @nome_departamento, @nome_seccional, @delegacia, @nome_departamento_circ, @nome_seccional_circ, @nome_delegacia_circ, @ano, @mes, @flag_status, @rubrica, @desdobramento, @conduta, @latitude, @longitude, @cidade, @logradouro, @numero_logradouro, @flag_status, @dummy)
    SET status = @flag_status,
        conduta = @conduta,
        desdobramento = @desdobramento;

LOAD DATA LOCAL INFILE '/dataset/BO_2016.csv' 
    REPLACE
    INTO TABLE OCORRENCIA
    CHARACTER SET 'utf8'
    FIELDS
        TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
    LINES
        TERMINATED BY '\n'
    IGNORE 1 LINES
    (@num_bo, @ano_bo, @id_delegacia, @nome_departamento, @nome_seccional, @delegacia, @nome_departamento_circ, @nome_seccional_circ, @nome_delegacia_circ, @ano, @mes, @flag_status, @rubrica, @desdobramento, @conduta, @latitude, @longitude, @cidade, @logradouro, @numero_logradouro, @flag_status, @dummy)
    SET idBoletim = (SELECT idBoletim FROM BOLETIM WHERE numBO = @num_bo AND anoBO = @ano_bo),
        idTempo = (SELECT idTempo FROM TEMPO WHERE data = STR_TO_DATE(CONCAT(@mes, '-', @ano), '%m-%Y'),
        idDelegacia = (SELECT idDelegacia FROM DELEGACIA WHERE nome = @delegacia),
        idLocal = (SELECT idLocal FROM LOCAL WHERE longitude = @longitude AND latitude = @LATITUDE),
        idStatus = (SELECT idStatus FROM STATUS WHERE status = @flag_status),
        qtdBOs = (SELECT COUNT(idBoletim) FROM BOLETIM),
        qtdDesdobramentosDiferentes = (SELECT COUNT(DISTINCT desdobramento) FROM STATUS);
