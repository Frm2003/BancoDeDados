create database teste
go
use teste

create table tbPaciente(
	cod integer NOT NULL primary key,
	nome varchar(100) NOT NULL,
	logradouro varchar(200) NOT NULL,
	numero integer NOT NULL,
	cep char(8) NULL,
	complemento varchar(255) NULL,
	telefone varchar(11) NULL,
)

create table tbEspecialidade(
	cod integer NOT NULL primary key,
	especialidade varchar(100),
)

create table tbMedico (
	cod int NOT NULL primary key,
	nome varchar(100) NOT NULL,
	logradouro varchar(200) NOT NULL,
	numero integer NOT NULL,
	cep char(8) NULL,
	complemento varchar(255) NULL,
	contato varchar(11) NULL,
	codEspecialidade int,
	foreign key (codEspecialidade) references tbEspecialidade(cod)
)
create table tbConsulta(
	codPaciente int not null,
	codMedico int not null,
	foreign key (codPaciente) references tbPaciente(cod),
	foreign key (codMedico) references tbMedico(cod),
	dataHora date not null,
	observacao varchar(255) not null,
	primary key(codPaciente, codMedico, dataHora)
)

insert into tbPaciente values
(99901, 'Washington Silva', 'R. Anhaia', 150, '02345000', 'Casa','922229999'),
(99902, 'Luis Ricardo', 'R. Voluntários da Pátria', 2251, '03254010', 'Bloco B. Apto 25','923450987'),
(99903, 'Maria Elisa', 'Av. Aguia de Haia', 1188, '06987020', 'Apto 1208', '945674312'),
(99904, 'José Araujo', 'R. XV de Novembro', 18, '03678000', 'Casa', '945674312'),
(99905, 'Joana Paula', 'R. 7 de Abril', 97, '01214000', 'Conjunto 3 - Apto 801', '912095674')

insert into tbMedico values
(100001, 'Ana Paula', 'R. 7 de Setembro', 256, '03698000', 'Casa', '915689456', 1),
(100002, 'Maria Aparecida', 'Av. Brasil', 32, '02145070', 'Casa', '923235454', 1),
(100003, 'Lucas Borges', 'Av. do Estado', 3210, '05241000', 'Apto 205', '963698585', 2),
(100004, 'Gabriel Oliveira', 'Av. Dom Helder Carnara', 350, '03145000', 'Apto 602', '932458745', 3)

insert into tbEspecialidade values 
(1, 'Otorrinolaringologista'),
(2, 'Urologista'),
(3, 'Geriatra'),
(4, 'Pediatra')

insert into tbConsulta values
(99901, 100002, '2021-09-04 13:20', 'Infecção Urina'),
(99902, 100003, '2021-09-04 13:15', 'Gripe'),
(99901, 100001, '2021-09-04 12:30', 'Infecção Garganta')

/* ADICIONA COLUNAS NA TABELA */
alter table tbMedico add diaAtendimento varchar(50)
exec sp_rename 'tbMedico.diaAtendimento', ' dia_semana_atendimento', 'COLUMN'

/* ALTERA ATRIBUTOS DA TABELA */
alter table tbConsulta
alter column observacao varchar(200)

update tbMedico set diaAtendimento = '2° feira' 
where cod = 100001 or cod = 100003

update tbMedico set diaAtendimento = '4° feira'
where cod = 100002

update tbMedico set diaAtendimento = '5° feira'
where cod = 100004

update tbMedico set logradouro = 'Av. Bras Leme', numero = 876, complemento = 'Apto 504', cep = '02122000'
where cod = 100003

/* DELETA COISAS */
delete tbEspecialidade where cod = 4

select * from tbMedico
select * from tbEspecialidade