--As restrições de integridade dos dados podem ser construídas no SGBD de duas formas: Declarativa e Procedural:
--Na forma declarativa, as restrições de integridade são parametrizadas durante a criação das estruturas das tabelas, utilizando a linguagem SQL, na categoria DDL (Data Definition Language ), fazendo uso de chaves primárias (PK), impedindo valores não nulos, utilizando tipos e domínios de dados e aplicando regras de integridade referencial.
--Na forma procedural (também chamadas de restrições semânticas), é possível fazer uso de recursos como gatilhos (triggers), procedimentos armazenados (stored procedures), bem como de afirmações (assertions) . Geralmente a forma procedural é implementada por programadores ou analistas especializados na linguagem  e no SGBD, com auxílio das regras de negócio passadas pelos clientes.


--Restrições:

--Integridade Referencial
  -- É utilizada entre duas relações e usada para manter a consistência entre tuplas nas duas relações. Esta restrição afirma que uma tupla em uma relação que referencia outra relação, precisa se referir a uma tupla existente nessa relação(daí a importância da chave primária não ser nula). Esta restrição, de forma resumida, garante o vínculo ou relacionamento entre duas tabelas (relações) a partir do uso das chaves primárias ou chave alternativa definida com UNIQUE, onde essa chave primária, que pertence a uma tabela(relação) específica, será referenciada em outra tabela(relação) como sendo chave estrangeira(FK). Quando o atributo referente a chave estrangeira em uma tabela não está preenchido com o valor da chave primária da outra tabela, ele então será preenchido com o valor NULL, para fins de garantir a integridade.
  --Ex.: Se um produto de ID 523 foi cadastrado em uma tabela de Vendas, então um produto com ID 523 deve existir na tabela de Produtos relacionada.
  --Em resumo: cada valor de uma chave estrangeira deve corresponder a um valor de uma chave primária existente. Serve para manter a consistência entre tuplas de duas relações; Aparecem devido aos relacionamentos entre entidades
  --CASCADE: Se um registro for excluído em uma tabela (operações DELETE e TRUNCATE), então os registros relacionados em outras tabelas que o referenciam talvez precisem ser excluídos. Caso contrário ocorrerá erro. O mesmo se dá com a atualização de registros (operação UPDATE).
  --on delete cascade
  --on update cascade,

--Integridade de Domínio
  --As restrições de domínio especificam que, dentro de cada tupla, o valor de cada atributo Y deve ser um valor indivisível do domínio dom(Y), ou seja, se um atributo tiver que receber valores dentro de um intervalo pré-estabelecido para um domínio, ele só receberá valores dentro deste intervalo, caso contrário uma mensagem de erro aparecerá para o usuário para que ele possa ajustar os dados antes da entrada no banco de dados.
  --Valores inseridos em uma coluna devem sempre obedecer à definição dos valores que são permitidos para essa coluna – os valores do domínio.
  --Ex.: em uma coluna que armazena preços de mercadorias, os valores admitidos são do domínio numérico – ou seja, apenas números. Não há preços usando letras para sua representação.
	
--Integridade de Vazio
  -- Existem casos onde um determinado atributo pode ser não obrigatório, ou seja, ele possui um tipo e domínio estabelecidos, mas não é obrigatório, e para garantir que não haja uma variação de vazios (espaço em branco ou simplesmente nada ou alguns espaços aleatórios), utiliza-se o NULL como sendo uma informação única e válida para preenchimento do atributo quando ele não for informado. Para que isso seja possível, no momento da criação da estrutura da tabela, será utilizado o parâmetro NULL  ou NOT NULL. NULL significa que o atributo pode não ser preenchido com algum valor, já NOT NULL significa o contrário, ou seja, é obrigatório o seu preenchimento com algum valor, obedecendo o tipo e domínio estabelecido.


--Integridade de Chave
  --Por exemplo, o uso de chave primária(PK), ela representa um identificador único para cada tupla da tabela, ou seja, ele não pode se repetir. Mas, além da chave primária, existem a chaves candidatas, onde surge a possibilidade de se usar outro atributo como chave, mas por algum motivo, apenas um foi definido por ser a chave a primária. Agora, imagine que você queira garantir que este outro atributo, que não é chave primária, não seja repetido em alguma tabela, por uma regra de negócio estabelecida. Neste caso você pode se valer de uma cláusula em SQL, chamada UNIQUE, para garantir que este atributo não seja repetido na mesma tabela em tuplas diferentes.


--Integridade de Entidade
  --Essa forma de restrição afirma que nenhum valor de chave primária (PK) pode ser NULL, pois o seu valor é utilizado para identificar tuplas individuais em uma relação (tabela). Isso significa, que caso exista um valor NULL para uma chave primária, não será possível identificar uma tupla e por consequência, não poderíamos utilizar estas tuplas para referenciá-las em outras relações(tabelas), pois não conseguiríamos distingui-las.


--Integridade Definida pelo Usuário
  --A integridade definida pelo usuário permite definir regras comerciais que não se encaixam em outras categorias de integridade. Todas as categorias de integridade oferecem suporte à integridade definida pelo usuário.
  --Diz respeito a regras de negócio específicas que são definidas pelo usuário do banco de dados. Por exemplo, pode-se definir que uma coluna somente aceitará um conjunto restrito de valores, como por exemplo apenas as siglas dos estados da federação, e mais nenhum outro valor diferente.

--Integridade da coluna
  --Determina os valores aceitos para a respectiva coluna.


------------------




--create database integridade;

create table pessoas
(
	id integer primary key identity,
	nome_pessoa varchar(50) NOT NULL,
	nome_pet varchar(30) NULL,
	num_pet integer check (num_pet > 0),
	idade integer check (idade between 18 and 99),
	sexo char check (sexo in ('M', 'F', 'N')),
	nacionalidade varchar(50) default 'Brasileira'
)

insert into pessoas values ('Fabrício', 'Píter', 1, 32, 'M', 'Italiana')
insert into pessoas (nome_pessoa, nome_pet, num_pet, idade, sexo)
values ('Fabrício 3 ', 'Mina', 1, 32, 'N')

select * from pessoas

create table pais 
(
	id integer primary key identity,
	nome varchar(50) not null,
)

create table estado
(
	id integer primary key identity,
	nome varchar(50) not null,
	fk_pais integer,
	foreign key (fk_pais) references pais(id) on delete cascade
)

insert into pais values ('Brasil')
insert into pais values ('Inglaterra')

insert into estado values ('RS', 1)
insert into estado values ('RJ', 1)
insert into estado values ('SP', 1)
insert into estado values ('XX', 2)
insert into estado values ('YY', 2)

delete from pais where id = 2

select * from estado


