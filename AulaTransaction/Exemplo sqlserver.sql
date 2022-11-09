create table teste
(
	id integer primary key identity,
	nome varchar(50) not null
)


BEGIN TRANSACTION  
INSERT INTO teste VALUES(3);  
INSERT INTO teste VALUES(1, 1);
IF(@@ERROR > 0)  
BEGIN  
    ROLLBACK TRANSACTION  
END  
ELSE  
BEGIN  
   COMMIT TRANSACTION  
END  


select * from teste
