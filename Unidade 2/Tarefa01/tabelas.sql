CREATE TABLE funcionario (
codigo serial,
nome varchar(15) NOT NULL,
sexo char(1) DEFAULT NULL,
dataNasc date DEFAULT NULL,
salario decimal(10,2) DEFAULT NULL,
supervisor int,
depto int,
PRIMARY KEY (codigo),
CONSTRAINT funcSuperFK FOREIGN KEY (supervisor) REFERENCES funcionario(codigo) on
delete set null on update cascade
);

CREATE TABLE departamento (
codigo serial,
sigla varchar(15) NOT NULL UNIQUE,
descricao varchar(25) NOT NULL,
gerente int,
PRIMARY KEY (codigo),
CONSTRAINT depGerenteFK FOREIGN KEY (gerente) REFERENCES funcionario(codigo) on delete
set null on update cascade
);
alter table funcionario ADD CONSTRAINT funcDeptoFK FOREIGN KEY (depto) REFERENCES
departamento(codigo) on delete set null on update cascade;
CREATE TABLE equipe (
codigo serial,
nomeEquipe varchar(45) DEFAULT NULL,
PRIMARY KEY (codigo)
);

CREATE TABLE membro (
codigo serial,
codEquipe int,
codFuncionario int,
PRIMARY KEY (codigo),
foreign key (codEquipe) references equipe(codigo) on delete set null,
foreign key (codFuncionario) references funcionario(codigo) on delete set null
);

CREATE TABLE projeto (
codigo serial,
descricao varchar(45) DEFAULT NULL,
depto int,
responsavel int,
dataInicio date DEFAULT NULL,
dataFim date DEFAULT NULL,
situacao varchar(45) DEFAULT NULL,
dataConclusao date DEFAULT NULL,
equipe int,
PRIMARY KEY (codigo),
foreign key (depto) references departamento(codigo) on delete set null,
foreign key (responsavel) references funcionario(codigo) on delete set null,
foreign key (equipe) references equipe(codigo) on delete set null
);

CREATE TABLE atividade (
codigo serial,
descricao varchar(45) DEFAULT NULL,
dataInicio date DEFAULT NULL,
dataFim date DEFAULT NULL,
situacao varchar(45) DEFAULT NULL,
dataConclusao date DEFAULT NULL,
PRIMARY KEY (codigo)
);

CREATE TABLE atividade_projeto (
codAtividade int,
codProjeto int,
PRIMARY KEY (codProjeto, codAtividade),
foreign key (codAtividade) references atividade(codigo),
foreign key (codProjeto) references projeto(codigo)
);

CREATE TABLE atividade_membro (
codAtividade int,
codMembro int,
PRIMARY KEY (codAtividade, codMembro),
foreign key (codAtividade) references atividade(codigo),
foreign key (codMembro) references membro(codigo)
);

insert into departamento
(sigla, descricao, gerente)
values ('DHC', 'Dep História', null);
insert into departamento
(sigla, descricao, gerente)
values ('DCT', 'Dep Computação', null);
insert into funcionario
(nome, sexo, dataNasc, salario, supervisor, depto)
values ('Ana', 'F', '1988-05-07', 2500.00, null, 1);
insert into funcionario
(nome, sexo, dataNasc, salario, supervisor, depto)
values ('Taciano', 'M', '1980-01-25', 2500.00, null, 2)