create database aula2;

create table teste2
(
	id integer primary key identity,
	nome varchar(50)
)

create table pessoas2
(
	id integer primary key identity,
	nome varchar(50),
	idade integer,
	altura integer
)

create login usuario2 with password='senha1234';
create user usuario3 from login usuario2;
exec sp_addrolemember 'DB_DATAREADER', 'usuario3';
exec sp_addrolemember 'DB_DATAWRITER', 'usuario3';

select database_id, name, create_date from sys.databases where database_id > 4;


begin transaction

insert into teste values ('teste');
insert into teste values (1,2);

if(@@error > 0)
	begin
		rollback transaction;
	end
else
	begin
		commit transaction;
	end



SELECT distinct p.name
FROM sys.database_role_members roles
	JOIN sys.database_principals p ON roles.member_principal_id = p.principal_id
	JOIN sys.database_principals pp ON roles.role_principal_id = pp.principal_id
ORDER BY 1