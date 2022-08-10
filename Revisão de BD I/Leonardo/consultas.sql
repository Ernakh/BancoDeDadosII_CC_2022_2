

select * from pessoas

insert into pessoas values 
('Fabrício', null, '123456', '123456', 'Rua tal numero tal', 178)

insert into pessoas values 
('Pessoa 3', null, '1234536', '123253', 'Rua tal numero tal', 155)


insert into medicos values ('12256', 5)



select * from medicos
join pessoas on pessoas.id = medicos.fk_pessoa


select nome, altura from pessoas


select * from pessoas where altura > 160 and altura < 185

select * from pessoas where altura between 160 and 185

select * from pessoas where nome like 'Fabr%'

select * from pessoas where nome like '%brí%'

select * from pessoas where nome like 'Pessoa%'

select * from medicos

select medicos.*, pessoas.nome from medicos, pessoas
where medicos.fk_pessoa = pessoas.id

select * from medicos
inner join pessoas on pessoas.id = medicos.fk_pessoa

select * from medicos --left join
left join pessoas on pessoas.id = medicos.fk_pessoa

select * from medicos --left join exclusivo
left join pessoas on pessoas.id = medicos.fk_pessoa
where pessoas.id is null


select * from medicos --right join
right join pessoas on pessoas.id = medicos.fk_pessoa

select * from medicos --right join exclusivo
right join pessoas on pessoas.id = medicos.fk_pessoa
where medicos.id is null


select * from medicos --full outer join
full outer join pessoas on pessoas.id = medicos.fk_pessoa

select * from medicos --full outer join exclusivo
full outer join pessoas on pessoas.id = medicos.fk_pessoa
where medicos.id is null or pessoas.id is null

(select * from medicos --left join
left join pessoas on pessoas.id = medicos.fk_pessoa)
union
(select * from medicos --right join
right join pessoas on pessoas.id = medicos.fk_pessoa)
