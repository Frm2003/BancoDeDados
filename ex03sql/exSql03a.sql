create database ex03
go
use ex03
go
create table users(
	id integer not null identity(1, 1),
	nome varchar(45) not null,
	userName varchar(45) not null unique,
	senha varchar(45) not null default('123mudar'),
	email varchar(45) not null,

	primary key(id)
)
go
create table projects(
	id integer not null identity(10001, 1),
	nome varchar(45) not null,
	descricao varchar(45),
	dataProjeto date not null check(dataProjeto > '01/09/2014'),

	primary key(id)
)
go
create table usersHasProject(
	userId integer not null,
	projectId integer not null,
	foreign key (userId) references users(id),
	foreign key (projectId) references projects(id),

	primary key (userId, projectId)
)

insert into users values
('Maria', 'Rh_maria', '123mudar', 'maria@empresa.com'),
('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
('Ana', 'Rh_ana', '123mudar', 'ana@empresa.com'),
('Clara', 'Ti_clara', '123mudar', 'clara@empresa.com'),
('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')

insert into projects values
('Re-folha', 'Refatoração de folhas', '05/09/2014'),
('Manutenção de PCs', 'Manutenção de PCs', '06/09/2014'),
('Auditoria', null, '07/09/2014')

insert into usersHasProject values
(1, 10001),
(5, 10001),
(3, 10003),
(4, 10002),
(2, 10002)

alter table projects add dataFinal date
alter table projects add custoDiario decimal(10, 2)

update projects set dataFinal = '16/09/2014' where id = 10001
update projects set dataFinal = '16/09/2014' where id = 10002
update projects set dataFinal = '18/09/2014' where id = 10003

update projects set custoDiario = 80.00 where id = 10001
update projects set custoDiario = 79.85 where id = 10002
update projects set custoDiario = 90.00 where id = 10003

select * from users
select * from projects
select * from usersHasProject

/*
Fazer uma consulta que retorne id, nome, email, username e caso a senha seja diferente de
123mudar, mostrar ******** (8 asteriscos), caso contrário, mostrar a própria senha.
*/
select id, nome, email, username,
	case when (senha = '123mudar') then
		'********'
	else 
		senha
	end as senha
from users
/*
- Considerando que o projeto 10001 durou 15 dias, fazer uma consulta que mostre o nome do
projeto, descrição, data, data_final do projeto realizado por usuário de e-mail
aparecido@empresa.com
*/
select * 
from projects
where id IN
(
select distinct projectId
from usersHasProject
where  projectId = 10001
)
/*
- Fazer uma consulta que retorne o nome e o email dos usuários que estão envolvidos no
projeto de nome Auditoria
*/
select nome, email
from users
where id in (
	select distinct userId
	from usersHasProject
	where projectId in (
		select distinct id 
		from projects
		where nome = 'Auditoria'
	)
)
/*
- Considerando que o custo diário do projeto, cujo nome tem o termo Manutenção, é de 79.85
e ele deve finalizar 16/09/2014, consultar, nome, descrição, data, data_final e custo_total do
projeto
*/
select * from projects where nome like 'Manutenção%' and dataFinal = '16/09/2014' and custoDiario = 79.85