SELECT * FROM sys.databases --lista base de dados

CREATE LOGIN Maria with password='123456',
	Default_database=Seguranca_1, check_expiration=off, 
	check_policy= off

select * from sys.sql_logins -- lista usuarios

select * from sys.sysprocesses where loginame = 'Juca' --acompanhar o usuario

create table disciplinas
(
	id integer primary key identity,
	data datetime default getdate(),
	nome varchar(100)
)

insert into Disciplinas(nome) 
values ('Banco de Dados I'), ('Banco de Dados II')

use Seguranca_1

create user Juca for Login Juca -- crio usuario pa partir do Login
create user Maria for Login Maria 

 grant select on disciplinas to Juca -- dou permissão para o Juca consultar disciplinas
 revoke select on disciplinas to Maria
 deny select on disciplinas to Maria

 select * from disciplinas


 create function funcaoDisciplina(@id integer)
 returns table as return
 (
	select * from disciplinas where id = @id
)

select * from funcaoDisciplina(2)

grant select on funcaoDisciplina to Juca

create view viewDisciplina
as select * from disciplinas

select * from viewDisciplina

grant select on viewDisciplina to Juca
deny select on viewDisciplina to Maria


SELECT	state_desc, prmsn.permission_name as [Permission], sp.type_desc, sp.name,
		grantor_principal.name AS [Grantor], grantee_principal.name as [Grantee]
FROM sys.all_objects AS sp
	INNER JOIN sys.database_permissions AS prmsn 
	ON prmsn.major_id = sp.object_id AND prmsn.minor_id=0 AND prmsn.class = 1
	INNER JOIN sys.database_principals AS grantor_principal
	ON grantor_principal.principal_id = prmsn.grantor_principal_id
	INNER JOIN sys.database_principals AS grantee_principal 
	ON grantee_principal.principal_id = prmsn.grantee_principal_id
WHERE grantee_principal.name = 'Maria'


SELECT p.name, p.type_desc, pp.name, pp.type_desc, pp.is_fixed_role
FROM sys.database_role_members roles
	JOIN sys.database_principals p ON roles.member_principal_id = p.principal_id
	JOIN sys.database_principals pp ON roles.role_principal_id = pp.principal_id
ORDER BY 1

