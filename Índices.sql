create database index_teste



CREATE TABLE clientes
(
      Cod INT IDENTITY PRIMARY KEY,
      Nome VARCHAR(100),
      UF VARCHAR(2),
      CEP VARCHAR(8)
)



CREATE [ UNIQUE ] [ CLUSTERED | NONCLUSTERED ] INDEX index_name
    ON( column [ ASC | DESC ] [ ,...n ] )
    [ INCLUDE ( column_name [ ,...n ] ) ]
    [ WITH ( [ ,...n ] ) ]
    [ ON { partition_scheme_name ( column_name )
         | filegroup_name
         | default
         }
    ]
[ ; ]


{
    [ database_name. [ schema_name ] . | schema_name. ]
        table_or_view_name
}


{
    PAD_INDEX  = { ON | OFF }
  | FILLFACTOR = fillfactor
  | SORT_IN_TEMPDB = { ON | OFF }
  | IGNORE_DUP_KEY = { ON | OFF }
  | STATISTICS_NORECOMPUTE = { ON | OFF }
  | DROP_EXISTING = { ON | OFF }
  | ONLINE = { ON | OFF }
  | ALLOW_ROW_LOCKS = { ON | OFF }
  | ALLOW_PAGE_LOCKS = { ON | OFF }
  | MAXDOP = max_degree_of_parallelism
}



SELECT CEP FROM clientes WHERE UF='RS'

CREATE NONCLUSTERED INDEX IDX_UF ON clientes (UF ASC) INCLUDE(CEP)

ALTER INDEX {nome_indice | ALL} ON REBUILD
ALTER INDEX {nome_indice | ALL} ON REORGANIZE	


UPDATE STATISTICS clientes

insert into clientes values ('Pessoa 4', 'SP', '11111');


select * from clientes
