# Lista de Exercícios - DCL e TCL com PostgreSQL

## Transações (TCL):

1 - Explique o que são transações PostgreSQL.

2 - Explique o modelo ACID.

3 - Crie um banco de dados de apenas uma tabela com três atributos para servir de bd para as questões 4 e 5.
Funcionario (codigo[Primary Key], nome, idade)

4 - Exemplifique a execução do comando COMMIT em SQL.

5 - Exemplifique a execução dos comandos SAVEPOINT, ROLLBACK TO SAVEPOINT  e RELEASE SAVEPOINT.

6 - Explique o funcionamento dos comandos LOCK TABLES e UNLOCK TABLES.

## Permissões (DCL):

7 - Crie um usuário com nome administrador e conceda a ele todos os privilégios em um banco de dados.

8 - Crie um usuário com nome usu e conceda a ele todos os privilégios e depois altere seu nome para administrador2 e adicione uma senha para ele. Em seguida remova o usuário.

9 - Crie um grupo chamado adms e adicione o usuário administrador.

10 - Crie um usuário com seu nome e conceda os privilégios de criar, deletar e atualizar uma tabela.

11 - Revogue o privilégio de deletar ao usuário criado na questão anterior.
