Create database trabalho

create table grupo
(
      id_grupo integer not null primary key identity,
      nome varchar(45)
)


create table descobridor
(
      id_descobridor integer not null primary key identity,
      nome varchar(45)
)

create table eras
(
      id_eras integer not null primary key identity,
      nome varchar(45),
      inicio INT,
      final INT
)


create table pais
(
      id_pais integer not null primary key identity,
      nome varchar(45)
)

create table dinossauro
(
      id_dinossauro integer not null primary key identity,
      nome varchar(45),
      toneladas INT,
      ano_descoberta INT,
      inicio_ano INT,
      final_ano INT,
      fk_grupo integer,
      fk_descobridor integer,
      fk_eras integer,
      fk_pais integer,
      foreign key (fk_grupo) references grupo(id_grupo),
      foreign key (fk_descobridor) references descobridor(id_descobridor),
      foreign key (fk_eras) references eras(id_eras),
      foreign key (fk_pais) references pais(id_pais)
)

select * from grupo;
select * from descobridor;
select * from eras;
select * from pais;
select * from dinossauro;

INSERT INTO grupo values ('Anquilossauros')
INSERT INTO grupo values ('Terapodes')
INSERT INTO grupo values ('Ceratopsideos')
INSERT INTO grupo values ('Anquilossauros')
INSERT INTO grupo values ('Estegossauro')

INSERT INTO descobridor values ('Cristian')
INSERT INTO descobridor values ('Marcio')
INSERT INTO descobridor values ('Pedro')
INSERT INTO descobridor values ('João')
INSERT INTO descobridor values ('Maria')

INSERT INTO eras values ('Cretaceo','145','66')
INSERT INTO eras values ('Jurassico','70','66')
INSERT INTO eras values ('Cretaceo','105','68')
INSERT INTO eras values ('Triássico','85','76')
INSERT INTO eras values ('Triássico','66','63')


INSERT INTO pais values ('Brasil')
INSERT INTO pais values ('Alemanha')
INSERT INTO pais values ('Argentina')
INSERT INTO pais values ('Espanha')
INSERT INTO pais values ('França')


INSERT INTO dinossauro values ('Pinacossauro','4','1977','144','143')
INSERT INTO dinossauro values ('Alossauro','3','1877','70','70')
INSERT INTO dinossauro values ('Torossauro','8','1972','105','105')
INSERT INTO dinossauro values ('Kentrossauro','7','2007','99','98')
INSERT INTO dinossauro values ('Saichania','4','1907','101','100')

create trigger teste_ano
on eras
after update
as
      declare @ini integer
      declare @fim integer

      select @ini = (select inserted.inicio from inserted)
      select @fim = (select inserted.final from inserted)

      IF @ini <= @fim
            begin
                  print ('Era inserida com sucesso!');
            end
      ELSE
                  rollback;
                  RAISERROR('INVALIDO - Era incorreta');
                  RETURN;
            end
end

