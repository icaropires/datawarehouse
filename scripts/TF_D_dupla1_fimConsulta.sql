 -- --------     << TF >>     ------------
 --
 --                    SCRIPT DE CRIACAO (DML)
 --
 -- Data Criacao ...........: 02/12/2019
 -- Autor(es) ..............: Sara Silva
 --                           Ícaro Pires
 -- Banco de Dados .........: MySQL
 -- Banco de Dados(nome) ...: tf_icaro_sara
 --
 -- Data Ultima Alteracao ..: 02/12/2019
 --   => Criacao das consultas
 --   => Criacao de view
 --
 -- PROJETO => 01 Base de Dados
 --         => 04 Tabelas
 --         => 01 Visoes
 --         => 02 usuários
 --
 -- -----------------------------------------------------------------

USE tf_icaro_sara;

-- Otimizar buscas na chave estrangeira de ocorrência por número do Boletim, otimizando os JOINS
-- CREATE INDEX NUM_BO_IDX on OCORRENCIA(numBO);

-- Para um analisador desses dados, parece bem comum filtrar por cidades, apesar de existirem vários
-- regitros para a mesma cidade, ainda haveria ganho de desempenho por serem muitas cidades
CREATE INDEX CIDADE_IDX on OCORRENCIA(cidade);

-- Resumo sobre os crimes na cidade de São Paulo
CREATE VIEW V_OCORRENCIA_X_DELEGACIA AS
  SELECT d.nome, dp.nomeDepartamento, b.numBO, b.anoBO, b.rubrica, o.cidade FROM OCORRENCIA o
      JOIN BOLETIM b
        ON o.anoBO = b.anoBO AND o.numBO = b.numBO
      JOIN DELEGACIA d
        ON b.idDelegacia = d.idDelegacia
      JOIN DEPARTAMENTO dp
        ON dp.nomeDepartamento = d.nomeDepartamento
      WHERE o.cidade = 'S.PAULO';
SELECT * FROM V_OCORRENCIA_X_DELEGACIA;

-- Mostra a quantidade de crimes por cidade
SELECT cidade, COUNT(idOcorrencia) as qtd_crimes FROM OCORRENCIA
	GROUP BY cidade
	ORDER BY qtd_crimes DESC;

-- Mostra os top 10 boletins que obtiveram mais desdobramentos
SELECT numBO, anoBO, COUNT(DISTINCT desdobramento) as boletins_top_desdobramentos
	FROM OCORRENCIA
		WHERE anoBO = 2016
		GROUP BY numBO
		ORDER BY boletins_top_desdobramentos DESC
	LIMIT 10;
