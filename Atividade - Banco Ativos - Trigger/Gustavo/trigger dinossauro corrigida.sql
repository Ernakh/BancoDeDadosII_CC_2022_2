--Tu estava sempre retornando NULL nas tuas consultas dentro do DECLARE, pois tua trigger estava com BEFORE, logo, não fazia sentido fazer um SELECT na tabela dinossauro
--mudei teus IFs e tuas condições para ficar mais adequado, assim como a consulta que possuia o mesmo problema relatado na linha acima



CREATE OR REPLACE FUNCTION era_checker()
RETURNS trigger AS $BODY$
DECLARE
    --era varchar(50) := (select eras.nome from eras where id=(select dinosauro.fk_era_id from dinosauro where dinosauro.id = NEW.id) limit 1);
    --inicio integer := (select eras.inicio_milhoes_atras from eras where id=(select dinosauro.fk_era_id from dinosauro where dinosauro.id = NEW.id) limit 1);
    --fim integer := (select eras.fim_milhoes_atras from eras where id=(select dinosauro.fk_era_id from dinosauro where dinosauro.id = NEW.id) limit 1);
BEGIN
    --RAISE NOTICE 'inicio: %.',inicio;
    --RAISE NOTICE 'fim: %.',fim;
/* Aqui definimos nossos códigos.*/
if( new.inicio_milhoes <= (select eras.inicio_milhoes_atras from eras where id= new.fk_era_id) and 
   new.inicio_milhoes >= (select eras.fim_milhoes_atras from eras where id= new.fk_era_id) and
   new.fim_milhoes <= (select eras.inicio_milhoes_atras from eras where id= new.fk_era_id ) and 
   new.fim_milhoes >= (select eras.fim_milhoes_atras from eras where id= new.fk_era_id )) then
        Raise Notice 'sucesso';
    else
        RAISE EXCEPTION 'falhou';
    end if;
    RETURN NEW;
END;
$BODY$
language plpgsql VOLATILE;

CREATE or REPLACE TRIGGER  era_checker
before INSERT or update ON dinosauro
FOR EACH ROW
EXECUTE PROCEDURE era_checker();


select * from eras
select * from dinosauro


insert into dinosauro(nome,ano_descoberta,pais_descoberta,grupo,toneladas,fk_descobridor_id,fk_era_id,inicio_milhoes,fim_milhoes) 
values ('alossauro',1877,'america do Norte','Terapodes',3,3,3,155,150)--falha

insert into dinosauro(nome,ano_descoberta,pais_descoberta,grupo,toneladas,fk_descobridor_id,fk_era_id,inicio_milhoes,fim_milhoes) 
values ('alossauro',1877,'america do Norte','Terapodes',3,3,2,155,150)--sucesso


