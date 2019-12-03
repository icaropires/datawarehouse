USE tf_icaro_sara_dw;

SET sql_mode = ''; -- Allow zero as day

DELIMITER @
CREATE PROCEDURE insert_into_twoTables(name varchar(100),age int)
BEGIN
END@
DELIMITER ;

INSERT INTO TEMPO(data)
	SELECT data FROM tf_icaro_sara.OCORRENCIA;

INSERT INTO LOCAL(latitude, longitude, logradouro, cidade, numero)
	SELECT latitude, longitude, logradouro, cidade, numero
		FROM tf_icaro_sara.OCORRENCIA;

INSERT INTO BOLETIM(numBO, anoBO, rubrica) 
	SELECT numBO, anoBO, rubrica
		FROM tf_icaro_sara.BOLETIM;

INSERT INTO DELEGACIA(nome, departamento, cidade) 
	SELECT delegacia.nome, dpt.nomeDepartamento, delegacia.cidade
		FROM tf_icaro_sara.DELEGACIA delegacia
			JOIN tf_icaro_sara.DEPARTAMENTO dpt
				ON delegacia.nomeDepartamento = dpt.nomeDepartamento;

INSERT INTO STATUS(status, conduta, desdobramento) 
	SELECT status, conduta, desdobramento
		FROM tf_icaro_sara.OCORRENCIA;

INSERT INTO OCORRENCIA(idBoletim, idTempo, idDelegacia, idLocal, idStatus, qtdBOs, qtdDesdobramentosDiferentes)
	SELECT b.idBoletim, t.idTempo, delegacia.idDelegacia, l.idLocal, s.idStatus, count(numBO), count(distinct desdobramentos)
		FROM tf_icaro_sara.OCORRENCIA o
			JOIN tf_icaro_sara.BOLETIM b
				ON 
