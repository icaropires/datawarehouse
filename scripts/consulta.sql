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

CREATE INDEX RUBRICA_IDX on BOLETIM(rubrica);
CREATE INDEX CIDADE_IDX on OCORRENCIA(cidade);

CREATE VIEW V_OCORRENCIA_X_DELEGACIA AS
  SELECT d.nome, dp.nomeDepartamento, b.numBO, b.anoBO, b.rubrica, o.cidade from DELEGACIA d, DEPARTAMENTO dp, BOLETIM b, OCORRENCIA c
      JOIN BOLETIM b
      ON o.anoBO = b.anoBO and o.numBO = b.numBO
    JOIN DELEGACIA d
      ON b.idDelegacia = d.idDelegacia;
    JOIN DEPARTAMENTO dp
      ON dp.nomeDepartamento = d.nomeDepartamento;

SELECT * FROM V_OCORRENCIA_X_DELEGACIA;

SELECT COUNT(OCORRENCIA(idOcorrencia, cidade)) FROM OCORRENCIA o;

SELECT DISTINCT rubrica FROM BOLETIM;

