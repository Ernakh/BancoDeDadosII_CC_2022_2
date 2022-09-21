create table eras
(
	id integer not null unique,
	nome varchar (50) not null unique,
	inicio_milhoes_atras integer,
    fim_milhoes_atras integer
)
create sequence eras_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence eras_id_seq
owned by eras.id

alter TABLE eras
alter COLUMN id 
set default nextval('eras_id_seq'::regclass);

create table descobridor 
(
id INTEGER not null UNIQUE,
nome varchar (50) not null
)

create sequence descobridor_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence descobridor_id_seq
owned by descobridor.id

alter TABLE descobridor
alter COLUMN id 
set default nextval('descobridor_id_seq'::regclass);


create table dinosauro
(
id INTEGER not null UNIQUE,
nome varchar (50) not null,
grupo varchar (50),
toneladas integer,
fk_descobridor_id integer not null,    
constraint fk_descobridor foreign key(fk_descobridor_id) references descobridor(id),
fk_era_id integer not null,   
ano_descoberta integer not null,
pais_descoberta varchar(50) not null,
inicio_milhoes integer not null,
fim_milhoes integer not null,  
constraint fk_era
foreign key(fk_era_id)
references eras(id) 
)

create sequence dinosauro_id_seq
increment by 1
no maxvalue
no minvalue
cache 1;

alter sequence dinosauro_id_seq
owned by dinosauro.id

alter TABLE dinosauro
alter COLUMN id 
set default nextval('dinosauro_id_seq'::regclass);



CREATE OR REPLACE FUNCTION era_checker()
RETURNS trigger AS $BODY$
DECLARE
    era varchar(50) := (select eras.nome from eras where id=(select dinosauro.fk_era_id from dinosauro where dinosauro.id = NEW.id) limit 1);
    inicio integer := (select eras.inicio_milhoes_atras from eras where id=(select dinosauro.fk_era_id from dinosauro where dinosauro.id = NEW.id) limit 1);
    fim integer := (select eras.fim_milhoes_atras from eras where id=(select dinosauro.fk_era_id from dinosauro where dinosauro.id = NEW.id) limit 1);
BEGIN
/* Aqui definimos nossos códigos.*/
if( (select dinosauro.inicio_milhoes from dinosauro where dinosauro.id = new.id) >= inicio and (select dinosauro.inicio_milhoes from dinosauro where dinosauro.id = new.id) <= fim ) then
if( (select dinosauro.fim_milhoes from dinosauro where dinosauro.id = new.id) >= inicio and (select dinosauro.fim_milhoes from dinosauro where dinosauro.id = new.id) <= fim ) then
Raise Notice 'sucesso';
else
RAISE EXCEPTION 'falhou';
end if;
end if;
RETURN NEW;
END;
$BODY$
language plpgsql VOLATILE;

CREATE or REPLACE TRIGGER  era_checker
before INSERT or update ON dinosauro
FOR EACH ROW
EXECUTE PROCEDURE era_checker();



insert into eras(nome,inicio_milhoes_atras,fim_milhoes_atras) values ('cretaceo',145,65)
insert into eras(nome,inicio_milhoes_atras,fim_milhoes_atras) values ('jurassico',200,144)
insert into eras(nome,inicio_milhoes_atras,fim_milhoes_atras) values ('triassico',251,199)

insert into descobridor(nome) values ('John Bell Hatcher')
insert into descobridor(nome) values ('Barnum Brown')
insert into descobridor(nome) values ('Othniel Charles Marsh')

select * from descobridor
select * from eras
select * from dinosauro

insert into dinosauro(nome,ano_descoberta,pais_descoberta,grupo,toneladas,fk_descobridor_id,fk_era_id,inicio_milhoes,fim_milhoes) values ('alossauro',1877,'america do 
Norte','Terapodes',3,3,3,155,150)
insert into dinosauro(nome,ano_descoberta,pais_descoberta,grupo,toneladas,fk_descobridor_id,fk_era_id,inicio_milhoes,fim_milhoes) values ('triceraptops',1887,'canada','Ceratopsideos',6,1,4,70,66)
insert into dinosauro(nome,ano_descoberta,pais_descoberta,grupo,toneladas,fk_descobridor_id,fk_era_id,inicio_milhoes,fim_milhoes) values ('torossauro',1891,'USA','Ceratopsideos',8,1,1,67,65)