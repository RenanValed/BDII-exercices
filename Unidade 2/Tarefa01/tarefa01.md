# Faça scripts .sql para as seguintes questões:
a. Faça uma função para calcular a idade do funcionário.
~~~sql
CREATE OR REPLACE FUNCTION calcular_idade(data_nasc date)
  RETURNS integer AS
$$
DECLARE
  idade integer;
BEGIN
  idade := extract(year from age(current_date, data_nasc));
  RETURN idade;
END;
$$
LANGUAGE plpgsql;
~~~
~~~sql
SELECT nome, calcular_idade(dataNasc) AS idade FROM funcionario;
~~~


b. Faça uma função para calcular a média de idade por departamento.

~~~sql
CREATE OR REPLACE FUNCTION calcular_media_idade_por_departamento()
  RETURNS TABLE (departamento varchar(15), media_idade numeric) AS
$$
BEGIN
  RETURN QUERY
  SELECT d.descricao AS departamento, avg(extract(year FROM age(current_date, f.dataNasc))) AS media_idade
  FROM funcionario f
  JOIN departamento d ON f.depto = d.codigo
  GROUP BY d.descricao;
END;
$$
LANGUAGE plpgsql;
~~~
~~~sql
SELECT * FROM calcular_media_idade_por_departamento();
~~~

c. Faça um procedimento para exibir os funcionários com idade acima da média do seu
departamento.

~~~sql
CREATE OR REPLACE PROCEDURE exibir_funcionarios_acima_media_idade()
AS $$
DECLARE
  departamento_id integer;
  media_idade numeric;
BEGIN
  -- Obter a média de idade por departamento
  SELECT d.codigo, avg(extract(year FROM age(current_date, f.dataNasc))) INTO departamento_id, media_idade
  FROM funcionario f
  JOIN departamento d ON f.depto = d.codigo
  GROUP BY d.codigo;

  -- Exibir os funcionários com idade acima da média por departamento
  FOR funcionario_row IN
    SELECT f.nome, extract(year FROM age(current_date, f.dataNasc)) AS idade
    FROM funcionario f
    WHERE f.depto = departamento_id AND extract(year FROM age(current_date, f.dataNasc)) > media_idade
  LOOP
    RAISE NOTICE 'Funcionário: %, Idade: %', funcionario_row.nome, funcionario_row.idade;
  END LOOP;
END;
$$
LANGUAGE plpgsql;
~~~

~~~sql
CALL exibir_funcionarios_acima_media_idade();
~~~

d. Faça uma função para calcular quantos dias de atraso tem uma atividade. A função retornará
negativo se estiver atrasada e positiva se estiver em dia.

~~~sql
CREATE OR REPLACE FUNCTION calcular_atraso(atividade_id integer)
  RETURNS integer AS
$$
DECLARE
  atraso_dias integer;
BEGIN
  SELECT extract(days FROM (current_date - dataConclusao)) INTO atraso_dias
  FROM atividade
  WHERE codigo = atividade_id;

  RETURN atraso_dias;
END;
$$
LANGUAGE plpgsql;
~~~

~~~sql
SELECT descricao, calcular_atraso(codigo) AS atraso
FROM atividade;
~~~

e. Faça uma função para calcular quantos dias de atraso tem um projeto. A função retornará
negativo se estiver atrasada e positiva se estiver em dia.

~~~sql
CREATE OR REPLACE FUNCTION calcular_atraso_projeto(projeto_id integer)
  RETURNS integer AS
$$
DECLARE
  atraso_dias integer;
BEGIN
  SELECT extract(days FROM (current_date - dataConclusao)) INTO atraso_dias
  FROM projeto
  WHERE codigo = projeto_id;

  RETURN atraso_dias;
END;
$$
LANGUAGE plpgsql;
~~~

~~~sql
SELECT descricao, calcular_atraso_projeto(codigo) AS atraso
FROM projeto;
~~~

f. Faça um procedimento para exibir a equipe de um projeto, exibindo o nome do funcionário, a
sigla do departamento.

~~~sql
CREATE OR REPLACE PROCEDURE exibir_equipe_do_projeto(projeto_id integer)
AS $$
BEGIN
  FOR equipe_row IN
    SELECT f.nome AS nome_funcionario, d.sigla AS sigla_departamento
    FROM membro m
    JOIN funcionario f ON m.codFuncionario = f.codigo
    JOIN departamento d ON f.depto = d.codigo
    WHERE m.codEquipe = (
      SELECT equipe FROM projeto WHERE codigo = projeto_id
    )
  LOOP
    RAISE NOTICE 'Funcionário: %, Departamento: %', equipe_row.nome_funcionario, equipe_row.sigla_departamento;
  END LOOP;
END;
$$
LANGUAGE plpgsql;
~~~

~~~sql
CALL exibir_equipe_do_projeto(1);
~~~

g. Faça uma função para calcular quantas atividades um membro da equipe fez no projeto.

~~~sql
CREATE OR REPLACE FUNCTION calcular_quantidade_atividades_membro(projeto_id integer, membro_id integer)
  RETURNS integer AS
$$
DECLARE
  quantidade_atividades integer;
BEGIN
  SELECT count(*) INTO quantidade_atividades
  FROM atividade_membro am
  WHERE am.codMembro = membro_id AND am.codAtividade IN (
    SELECT codigo FROM atividade WHERE codProjeto = projeto_id
  );

  RETURN quantidade_atividades;
END;
$$
LANGUAGE plpgsql;
~~~

~~~sql
SELECT calcular_quantidade_atividades_membro(1, 2) AS quantidade_atividades;
~~~


h. Faça uma função para calcular a porcentagem de atividades que um membro de equipe fez no
projeto.

~~~sql
CREATE OR REPLACE FUNCTION calcular_porcentagem_atividades_membro(projeto_id integer, membro_id integer)
  RETURNS numeric AS
$$
DECLARE
  quantidade_total integer;
  quantidade_atividades integer;
  porcentagem numeric;
BEGIN
  SELECT count(*) INTO quantidade_total
  FROM atividade_membro am
  JOIN atividade a ON am.codAtividade = a.codigo
  WHERE a.codProjeto = projeto_id;

  SELECT count(*) INTO quantidade_atividades
  FROM atividade_membro am
  JOIN atividade a ON am.codAtividade = a.codigo
  WHERE am.codMembro = membro_id AND a.codProjeto = projeto_id;

  IF quantidade_total > 0 THEN
    porcentagem := (quantidade_atividades::numeric / quantidade_total) * 100;
  ELSE
    porcentagem := 0;
  END IF;

  RETURN porcentagem;
END;
$$
LANGUAGE plpgsql;
~~~

~~~sql
SELECT calcular_quantidade_atividades_membro(1, 2) AS quantidade_atividades;
~~~

i. Para cada questão que você resolver, faça um commit indicando o ID da issue. Na mensagem
de commit sempre acrescente o ID da issue criada na questão 1.