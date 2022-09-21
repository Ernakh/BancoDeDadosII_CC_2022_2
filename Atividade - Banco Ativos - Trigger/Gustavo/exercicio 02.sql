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

insert into eras(nome,inicio_milhoes_atras,fim_milhoes_atras) values ('cretaceo',145,65)
insert into eras(nome,inicio_milhoes_atras,fim_milhoes_atras) values ('jurassico',200,144)
insert into eras(nome,inicio_milhoes_atras,fim_milhoes_atras) values ('triassico',251,199)

insert into descobridor(nome) values ('John Bell Hatcher')
insert into descobridor(nome) values ('Barnum Brown')
insert into descobridor(nome) values ('Othniel Charles Marsh')

select * from descobridor
select * from eras
select * from dinosauro

insert into dinosauro(nome,ano_descoberta,pais_descoberta,grupo,toneladas,fk_descobridor_id,fk_era_id) values ('alossauro',1877,'america do 
Norte','Terapodes',3,3,2)
insert into dinosauro(nome,ano_descoberta,pais_descoberta,grupo,toneladas,fk_descobridor_id,fk_era_id) values ('triceraptops',1887,'canada','Ceratopsideos',6,1,1)
insert into dinosauro(nome,ano_descoberta,pais_descoberta,grupo,toneladas,fk_descobridor_id,fk_era_id) values ('torossauro',1891,'USA','Ceratopsideos',8,1,1)

