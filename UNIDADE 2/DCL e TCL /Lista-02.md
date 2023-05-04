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

`Funcionario (codigo[Primary Key], nome, idade)`

```sql

DROP TABLE IF EXISTS accounts;

Create table Funcionario (
	codigo SERIAL primary key not null,
	nome char[111] not null,   
    idade int not null
);

```

#### 4 - Exemplifique a execução do comando COMMIT em SQL.

```sql
-- Início da transação
BEGIN;

-- Adicionando alguns registros na tabela Funcionario
INSERT INTO Funcionario (nome, idade) VALUES ('João', 28), ('Maria', 32);

-- Confirmando as alterações com o comando COMMIT
COMMIT;
```

#### 5 - Exemplifique a execução dos comandos SAVEPOINT, ROLLBACK TO SAVEPOINT  e RELEASE SAVEPOINT.

#### SAVEPOINT e ROLLBACK TO SAVEPOINT

```sql 
-- Início da transação
BEGIN;

-- Seleciona o registro com código igual a 1
SELECT * FROM Funcionario WHERE codigo = 1 FOR UPDATE;

-- Verifica se o nome é válido
IF nome <> 'João' THEN
  -- Cria um SAVEPOINT
  SAVEPOINT my_savepoint;
  
  -- Altera o nome do funcionário
  UPDATE Funcionario SET nome = 'João' WHERE codigo = 1;
  
  -- Verifica se a idade é válida
  IF idade >= 18 THEN
    -- Confirma as alterações com o comando COMMIT
    COMMIT;
  ELSE
    -- Desfaz as alterações feitas a partir do SAVEPOINT
    ROLLBACK TO SAVEPOINT my_savepoint;
  END IF;
ELSE
  -- Desfaz a transação inteira
  ROLLBACK;
END IF;

-- Fim da transação
COMMIT;
```

#### RELEASE SAVEPOINT
```sql
-- Início da transação
BEGIN;

-- Seleciona o registro com código igual a 1
SELECT * FROM Funcionario WHERE codigo = 1 FOR UPDATE;

-- Verifica se o nome é válido
IF nome <> 'João' THEN
  -- Cria um SAVEPOINT
  SAVEPOINT my_savepoint;
  
  -- Altera o nome do funcionário
  UPDATE Funcionario SET nome = 'João' WHERE codigo = 1;
  
  -- Verifica se a idade é válida
  IF idade >= 18 THEN
    -- Confirma as alterações com o comando COMMIT
    COMMIT;
  ELSE
    -- Desfaz as alterações feitas a partir do SAVEPOINT
    ROLLBACK TO SAVEPOINT my_savepoint;
  END IF;
ELSE
  -- Desfaz a transação inteira
  ROLLBACK;
END IF;

-- Libera o SAVEPOINT e finaliza a transação
RELEASE SAVEPOINT my_savepoint;
```


#### 6 - Explique o funcionamento dos comandos LOCK TABLES e UNLOCK TABLES.

#### Comando LOCK TABLES

O comando `LOCK TABLES` é usado para bloquear uma ou várias tabelas em um banco de dados, impedindo que outras transações modifiquem seus dados. Ele pode ser usado com diferentes tipos de bloqueio:

- `READ`: bloqueia a tabela para leitura, impedindo apenas a atualização ou exclusão dos dados;
- `WRITE`: bloqueia a tabela para escrita, impedindo qualquer operação de leitura, atualização ou exclusão.

#### Comando UNLOCK TABLES

O comando `UNLOCK TABLES` é utilizado para liberar as tabelas bloqueadas anteriormente pelo comando `LOCK TABLES`. É importante lembrar que o `LOCK TABLES` e o `UNLOCK TABLES` devem ser utilizados dentro de uma transação para garantir a consistência dos dados e evitar conflitos de acesso. O uso excessivo desses comandos pode levar a problemas de desempenho e concorrência em bancos de dados com muitas transações simultâneas.


## Permissões (DCL):

#### 7 - Crie um usuário com nome administrador e conceda a ele todos os privilégios em um banco de dados.

```sql 
-- Acessar o banco de dados como o usuário postgres
psql -U postgres mydatabase

-- Criar um novo usuário chamado "administrador" com uma senha
CREATE USER administrador WITH PASSWORD 'senha123';

-- Conceder todos os privilégios do banco de dados ao novo usuário
GRANT ALL PRIVILEGES ON DATABASE mydatabase TO administrador;

```

#### 8 - Crie um usuário com nome usu e conceda a ele todos os privilégios e depois altere seu nome para administrador2 e adicione uma senha para ele. Em seguida remova o usuário.

```sql
-- Acessar o banco de dados como o usuário postgres
psql -U postgres mydatabase

-- Criar um novo usuário chamado "usu" com todos os privilégios
CREATE USER usu;
GRANT ALL PRIVILEGES ON DATABASE mydatabase TO usu;

-- Renomear o usuário para "administrador2"
ALTER USER usu RENAME TO administrador2;

-- Adicionar uma senha ao usuário
ALTER USER administrador2 PASSWORD 'minhasenha';

-- Remover o usuário
DROP USER administrador2;
```

#### 9 - Crie um grupo chamado adms e adicione o usuário administrador.

```sql
-- Acessar o banco de dados como o usuário postgres
psql -U postgres mydatabase

-- Criar um novo grupo chamado "adms"
CREATE GROUP adms;

-- Adicionar o usuário "administrador" ao grupo "adms"
ALTER GROUP adms ADD USER administrador;
```

#### 10 - Crie um usuário com seu nome e conceda os privilégios de criar, deletar e atualizar uma tabela.

```sql
-- Acessar o banco de dados como o usuário postgres
psql -U postgres mydatabase

-- Criar um novo usuário com nome renanadm
CREATE USER renanadm;

-- Conceder os privilégios necessários para o novo usuário
GRANT CREATE, DROP, UPDATE ON ALL TABLES IN SCHEMA public TO renanadm;
```

#### 11 - Revogue o privilégio de deletar ao usuário criado na questão anterior.

```~~sql
-- Revogar o privilégio de deletar ao usuário "renanadm"
REVOKE DELETE ON ALL TABLES IN SCHEMA public FROM renanadm;

```