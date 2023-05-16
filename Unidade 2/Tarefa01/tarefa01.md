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

d. Faça uma função para calcular quantos dias de atraso tem uma atividade. A função retornará
negativo se estiver atrasada e positiva se estiver em dia.

e. Faça uma função para calcular quantos dias de atraso tem um projeto. A função retornará
negativo se estiver atrasada e positiva se estiver em dia.

f. Faça um procedimento para exibir a equipe de um projeto, exibindo o nome do funcionário, a
sigla do departamento.

g. Faça uma função para calcular quantas atividades um membro da equipe fez no projeto.

h. Faça uma função para calcular a porcentagem de atividades que um membro de equipe fez no
projeto.

i. Para cada questão que você resolver, faça um commit indicando o ID da issue. Na mensagem
de commit sempre acrescente o ID da issue criada na questão 1.