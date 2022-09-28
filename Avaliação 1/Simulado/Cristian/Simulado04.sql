create database B3

create table acoes
(
	id_acoes integer not null primary key identity,
	codigo varchar(8),
	valor float not null,
	data_acoes date not null,
      inicio datetime2 generated always as row start not null,
      fim datetime2 generated always as row end not null,
            period for system_time (inicio, fim)
)
with
 (
 system_versioning = ON (history_table = dbo.acoes_historico)
 )

 select * from acoes

 alter table acoes set (system_versioning = OFF)

 insert into acoes (codigo,valor,data_acoes) values ('ITSA4F','9.87','21-09-2022')

 update acoes set valor = 'Avenida Jõao Pessoa' where id_acoes = 1
delete from acoes where id_acoes = 1
select * from acoes
for system_time all
where id_acoes = 1