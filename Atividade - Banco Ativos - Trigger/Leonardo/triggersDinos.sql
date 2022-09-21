create database dinos

create table grupo(
id int not null primary key identity,
nome varchar(50)
)

create table descobridor(
id int not null primary key identity,
nome varchar(50)
)

create table era(
id int not null primary key identity,
nome varchar(50),
)

create table pais(
id int not null primary key identity,
nome varchar(50)
)

create table dinossauro(
id int not null primary key identity,
nome varchar(50) not null,
fk_grupo int not null,
fk_descobridor int not null,
toneladas int,
ano_descoberta date,
inicio int,
fim int,
fk_era int,
fk_pais int,
foreign key (fk_grupo) references grupo(id),
foreign key (fk_descobridor) references descobridor(id),
foreign key (fk_era) references era(id),
foreign key (fk_pais) references pais(id) 
)

insert into grupo values('Anquilossauros')
insert into grupo values('Ceratopsídeos')
insert into grupo values('Estegossauros')
insert into grupo values('Terápodes')

insert into descobridor values('Maryanska')
insert into descobridor values('John Bell Hatcher')
insert into descobridor values('Cientistas Alemães')
insert into descobridor values('Museu Americano de História Natural')
insert into descobridor values('Othniel Charles Marsh')
insert into descobridor values('Barn Brown')

insert into era values('Cretáceo')
insert into era values('Jurássico')
insert into era values('Triassico')

insert into pais values('Mongólia')
insert into pais values('Canadá')
insert into pais values('Tanzânia')
insert into pais values('China')
insert into pais values('USA')

insert into dinossauro values('Saichania',1,1,4,'1977',145,66,1,1)
insert into dinossauro values('Tricerátops',2,2,6,'1887',66,70,1,2)
insert into dinossauro values('Kentrossauro',3,3,2,'1909',201,145,2,3)
insert into dinossauro values('Pinacossauro',1,4,6,'1877',85,75,3,4)
insert into dinossauro values('Alossauro',4,5,3,'1999',155,150,2,5)
insert into dinossauro values('Torossauro',1,2,8,'1891',67,65,1,5)
insert into dinossauro values('Anquilossauro',1,6,8,'1906',67,63,3,5)

select * from dinossauro
update dinossauro set inicio = 65 where id = 3
update dinossauro set fk_era = 3 where id = 10
update dinossauro set fim = 140 where id = 10

--------------------------------------
create trigger triggeridade
on dinossauro
after insert, update
as
	declare @idade integer
	select @idade = (select(inicio - fim) from inserted)

	if(@idade >= 0)
	begin
		--print('Inserido com sucesso!');
		return;
	end
	else
	begin
		rollback;
		raiserror('Tempo de existência inválido!', 14, 1);
		return;
	end

--drop trigger triggertempo
create trigger triggertempo
on dinossauro
after insert, update
as
	declare @inicio integer
	declare @fim integer
	declare @era integer
	select @inicio = (select(inicio) from inserted)
	select @fim = (select(fim) from inserted)
	select @era = (select(fk_era) from inserted)

	if(@inicio <= 145 and @fim >= 65 and @era = 1 )
	begin
		return;
	end
	else if
	(@inicio <= 201 and @fim >= 145 and @era = 2 )
	begin
		return;
	end
	else if(@inicio <= 252 and @fim >= 201 and @era = 3 )
	begin
		return;
	end
	else
	begin
		rollback;
		raiserror('Tempo de existência não condiz com a era!', 14, 1);
		return;
	end