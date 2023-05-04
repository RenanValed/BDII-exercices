DROP TABLE IF EXISTS accounts;

Create table Funcionario (
	codigo SERIAL primary key not null,
	nome char[111] not null,   
    idade int not null
);