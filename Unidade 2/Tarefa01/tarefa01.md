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

c. Faça um procedimento para exibir os funcionários com idade acima da média do seu
departamento.

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