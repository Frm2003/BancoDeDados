use teste
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

update users set userName = 'Rh_cido' where userName = 'Rh_apareci'
update users set senha = '888@*' where username = 'Rh_maria'
update projects set dataProjeto = '12/09/2014' where nome = 'Manutenção de PCs' 

delete usersHasProject where userId = 2 

select * from usersHasProject