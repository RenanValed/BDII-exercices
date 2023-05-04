# Lista de Exercícios - DCL e TCL com PostgreSQL

## Transações (TCL):

#### 1 - Explique o que são transações PostgreSQL.

- BEGIN é usada para iniciar um bloco de transação que terminará após atingir as palavras-chave COMMIT ou ROLLBACK.[fonte](https://www.enterprisedb.com/postgres-tutorials/how-work-postgresql-transactions)

#### 2 - Explique o modelo ACID.

O acrônimo ACID faz referência aos quatro princípios básicos que qualquer SGBD deve satisfazer para que possua esse título:

- **Atomicidade:** Uma transação deve ser tratada como uma operação única e indivisível, garantindo que todas as mudanças feitas naquele momento serão desfeitas se ocorrer uma falha.

- **Consistência:** Todas as transações devem seguir as regras de integridade e validação de dados, garantindo que o banco de dados esteja sempre em um estado consistente e válido após a transação ser concluída.

- **Isolamento:** Cada transação deve ser isolada das outras, a fim de evitar conflitos e inconsistências nos dados. Isso significa que as transações devem ser executadas independentemente das outras transações que estão sendo executadas simultaneamente no banco de dados.

- **Durabilidade:** As alterações feitas em uma transação devem ser permanentes e duráveis, mesmo em caso de falha de hardware ou software. Isso garante que as mudanças no banco de dados permaneçam mesmo após um problema ou falha.



#### 3 - Crie um banco de dados de apenas uma tabela com três atributos para servir de bd para as questões 4 e 5.

```Funcionario (codigo[Primary Key], nome, idade)```

[Ir para resposta](https://github.com/RenanValed/BDII-exercices/blob/main/UNIDADE%202/DCL%20e%20TCL%20/questao3.sql)

#### 4 - Exemplifique a execução do comando COMMIT em SQL.



#### 5 - Exemplifique a execução dos comandos SAVEPOINT, ROLLBACK TO SAVEPOINT  e RELEASE SAVEPOINT.



#### 6 - Explique o funcionamento dos comandos LOCK TABLES e UNLOCK TABLES.



## Permissões (DCL):

#### 7 - Crie um usuário com nome administrador e conceda a ele todos os privilégios em um banco de dados.

#### 8 - Crie um usuário com nome usu e conceda a ele todos os privilégios e depois altere seu nome para administrador2 e adicione uma senha para ele. Em seguida remova o usuário.

#### 9 - Crie um grupo chamado adms e adicione o usuário administrador.

#### 10 - Crie um usuário com seu nome e conceda os privilégios de criar, deletar e atualizar uma tabela.

#### 11 - Revogue o privilégio de deletar ao usuário criado na questão anterior.
