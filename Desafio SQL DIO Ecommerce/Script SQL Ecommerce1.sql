/*Criação do Banco de dados para o cenário de E-commerce*/

create database ecommerce;
use ecommerce;
/*drop database ecommerce;*/


/*Criando Tabela Cliente*/

create table cliente(
		id_cliente int auto_increment primary key,
        Pnome varchar(10),
        Sobrenome varchar(45),
        CPF char(11) not null, 
        CNPJ varchar(20),
        Rua varchar(20) not null,
        Bairro varchar(10),
        Cidade varchar(20) not null,
        Cep char(8) not null,
        Estado char(2) not null,
        Telefone varchar(15),
        email varchar(30),
        Login varchar(30),
        Data_nascimento date not null,
        constraint unique_cpf_cliente unique (CPF)
);
alter table cliente auto_increment=1;        

/*Persistência de dados da tabela cliente*/
insert into cliente (Pnome,Sobrenome,CPF,CNPJ,Rua,Bairro,Cidade,Cep,Estado,Telefone,email,Login,Data_nascimento) values
		('Anderson','Paulino','29147767700','189189228983','Venezuela','Vila','Santos','11702110','SP','13981351212','teste@teste','anderson','19801224'),
		('Adriano','Paulino','29147747701','189189228987','São Paulo','Margarida','São Paulo','11702444','SP','13981351222','adriano@teste','adriano','19680203'),
        ('Alex','Paulino','29147747702','189189228986','Valentin','Vila','Santos','11702110','SP','13981351212','alex@teste','alex','19740801'),
        ('Stefania','Paulino','29147747703','189189228984','Escobar','Vila','Santos','11702110','SP','13981351222','stefania@teste','stefania','19770830');     
        
        
/*Criando Tabela Produto*/
create table Produto(
		id_produto int auto_increment primary key,
        nome_produto varchar(10) not null,
        Fabricante varchar(20), 
        Valor float not null,
        classificacao_kids bool default false,
        categorias enum('eletronicos','vestuário','cama mesa e banho','móveis','alimentos','calçados','esportivos'),
        Peso_liquido varchar(10)
);
alter table produto auto_increment=1; 

/*Persistência de dados da tabela Produto */
insert into produto (nome_produto,Fabricante,Valor,classificacao_kids,categorias,Peso_liquido) values
			('video game','Sony','100',default,'eletronicos','1.5 Kg'),
            ('video game','Sony','100',default,'eletronicos','1.5 Kg'),
            ('video game','Sony','100',default,'eletronicos','1.5 Kg'),
            ('video game','Sony','100',default,'eletronicos','1.5 Kg');
            
update produto set nome_produto='celular', fabricante='Samsumg', valor='1500', Peso_liquido='0.255 kg'
where id_produto=2;
update produto set nome_produto='toalhas', fabricante='Personal', valor='30', categorias='cama mesa e banho', Peso_liquido='0.225 kg'
where id_produto=3;
update produto set nome_produto='tenis', fabricante='Nike', valor='550', categorias='esportivos', Peso_liquido='0.100 kg'
where id_produto=4;
select * from produto;

/*Criando Tabela Pedido*/
create table Pedido(
		id_pedido int auto_increment primary key,
        pedido_cliente_id int ,
        status_pedido ENUM('Processando', 'A caminho', 'Aprovado', 'Cancelado', 'Entregue') default 'Processando',
        forma_pagamento enum('boleto','cartão a vista','cartão parcelado','Pix') not null,
        valor_pedido float not null,
        descrição varchar(45),
        frete float default 0,
        produto varchar(45) not null,
        quantidade varchar(45) not null,
        constraint fk_pedido_cliente foreign key (pedido_cliente_id) references cliente(id_cliente)
);
alter table pedido auto_increment=1; 

/*Persistência de dados da tabela Pedido*/
insert into Pedido (status_pedido,forma_pagamento,valor_pedido,descrição,frete,produto,quantidade) values
		('Processando','cartão parcelado','100','video game SONY',default,'PS4','1'),
		('A caminho','Pix','1500','celular Samsumg',default,'Galaxy','1'),
		('Entregue','Boleto','30','Kit toalhas Pesonal',default,'Toalhas Kit','1'),
		('Cancelado','Boleto','550','Tenis Nike',default,'Nike Street','1');
        
select * from pedido;
update pedido set pedido_cliente_id='4'
where id_pedido=4;

/*Criando tabela Formas de pagamento*/
create table formas_pagamento(
		id_formas_pagamento int not null auto_increment,
        tipo_pagamento enum('Boleto','cartão a vista','cartão parcelado','Dois cartões','Pix') ,
        boleto_cod_barras varchar(45) ,
        cartão1_numero varchar(45)  ,
        validade_cartao1 varchar(10),
        cod_segurança_cartao1 char(3),
        cartão2_numero varchar(45)  ,
        validade_cartao2 varchar(10),
        cod_segurança_cartao2 char(3),
        pix_chave varchar(100),
        quantidade_parcelas int default'1',
        pagamento_id_cliente int,
        pagamento_id_pedido int,
        primary key(id_formas_pagamento, pagamento_id_cliente),
        constraint fk_id_pagamento_pedido foreign key (pagamento_id_pedido) references pedido(id_pedido)
);
alter table formas_pagamento auto_increment=1; 

/*Persistência de dados da tabela formas_pagamento*/
insert into formas_pagamento(tipo_pagamento,boleto_cod_barras,cartão1_numero,validade_cartao1,cod_segurança_cartao1,
							cartão2_numero,validade_cartao2,cod_segurança_cartao2,pix_chave,quantidade_parcelas,pagamento_id_cliente,pagamento_id_pedido) values
                            ('cartão parcelado',null,'1223436567958','02/30',222,null,null,null,null,'2','1','1'),
                            ('Pix',null,null,null,null,null,null,null,'355k3jiu35909u430940ur',default,'2','2'),
                            ('Boleto','243553353546356563',null,null,null,null,null,null,null,default,'3','3'),
                            ('Boleto','453554346653543363',null,null,null,null,null,null,null,default,'4','4');

select * from formas_pagamento;




/*Criando tabela estoque*/

create table estoque(
		id_estoque int not null auto_increment primary key,
        quantidade int default '0',
        localizaçao varchar(255)      
);
alter table estoque auto_increment=1;

/*Persistência de dados da tabela estoque*/
insert into estoque (quantidade,localizaçao) values
			('100','Rua do comercio,225, Vila, São Paulo - SP CEP:12873-234'),
            ('300','Rua do comercio,225, Vila, São Paulo - SP CEP:12873-234'),
            ('1000','Rua do comercio,225, Vila, São Paulo - SP CEP:12873-234'),
            ('500','Rua do comercio,225, Vila, São Paulo - SP CEP:12873-234');
 
 select * from estoque;
 
/*Criando tabela fornecedor*/
create table fornecedor(
		fornecedor_id int not null auto_increment primary key,
        razao_social varchar(45) not null,
        cnpj varchar(45),
        cpf char(11),
        nome_fantasia varchar(45) not null,
        endereço varchar(45),
        estado char(2),
        telefone char(13) ,
        constraint unique_fornecedor unique (cnpj)
);
alter table fornecedor auto_increment=1; 

/*Persistência de dados da tabela fornecedor*/
insert into fornecedor(razao_social,cnpj,cpf,nome_fantasia,endereço,estado,telefone) values
					('Industria de comercio Ltda','02.456.985.0001-45','37221234320',
					'Comercial Netmais','Rua do comercio,225, Vila, São Paulo','SP','5511981446377'),
                    ('Industria de Eletronicos Ltda','02.456.985.0001-40','37221234321',
					'Comercial Eletronicos','Rua do comercio,225, Vila, São Paulo','SP','5511981446377'),
                    ('Industria de Tecidos Ltda','02.456.985.0001-41','37221234320',
					'Comercial Tecidos','Rua do comercio,225, Vila, São Paulo','SP','5511981446377'),
                    ('Industria de Celulares Ltda','02.456.985.0001-42','37221234311',
					'Comercial Celulares','Rua do comercio,225, Vila, São Paulo','SP','5511981446377');
                    
select * from fornecedor;                     

/*Criando tabela terceiros vendedor*/
create table vendedor(
		vendedor_id int not null auto_increment primary key,
        razao_social varchar(45) not null,
        cnpj varchar(45) not null,
        cpf char(11) not null,
        nome_fantasia varchar(45) not null,
        endereço varchar(45),
        estado char(2),
        telefone char(13),
        constraint unique_cnpj_vendedor unique(cnpj),
        constraint unique_cpf_vendedor unique(cpf) 
);
alter table vendedor auto_increment=1; 

/*Persistência de dados da tabela vendedor*/
insert into vendedor(razao_social,cnpj,cpf,nome_fantasia,endereço,estado,telefone) values
			('Compre mais Informatica Ltda','34.455.654.0001-33','22749383920','Info Mais',
            'Rua do comercio,225, Vila, São Paulo','SP','5511987986577'),
            ('Confeção Industria Ltda','34.455.654.0001-32','22749383921','Loja dos Tecidos',
            'Rua do comercio,225, Vila, São Paulo','SP','5511987986577'),
            ('Company Eletronics Ltda','34.455.654.0001-31','22749383922','Eleronics Life',
            'Rua do comercio,225, Vila, São Paulo','SP','5511987986577'),
            ('CellPhone Ltda','34.455.654.0001-30','22749383923','CellPhone',
            'Rua do comercio,225, Vila, São Paulo','SP','5511987986577');
            
select * from vendedor;            

/*Criando tabela vendedor tem produto(terceiros)*/
create table produtos_vendedor(
		vendedor_id int ,
        id_produto int,
        primary key (vendedor_id,id_produto),
        quantidade_produto int default '1',
        constraint fk_produtos_vendedor foreign key(vendedor_id) references vendedor(vendedor_id),
        constraint fk_produtos_produtos foreign key(id_produto) references produto(id_produto)      
);

/*Persistência de dados da tabela Produtos_vendedor*/
insert into produtos_vendedor(vendedor_id,id_produto,quantidade_produto) values
				('3','1','100'),
                ('2','3','1000'),
                ('1','2','300'),
                ('4','2','300');
                
select * from produtos_vendedor;                
			
/*Criando tabela Produto tem pedido*/
create table produto_pedido(
		produto_id_produto int,
        produto_id_pedido int,
        quantidade int default '1',
        status enum('disponivel','sem estoque') default 'disponivel',
        constraint fk_produto_produto foreign key(produto_id_produto) references produto(id_produto),
        constraint fk_produto_id_pedido foreign key(produto_id_pedido) references pedido(id_pedido)
);

/*Persistência de dados da tabela Produto_pedido*/
insert into produto_pedido(produto_id_produto,produto_id_pedido,quantidade) values
			('1','1','1'),
            ('2','2','1'),
            ('3','3','1'),
            ('4','4','1');
            
select * from produto_pedido;            


/*Criando tabela produto tem em estoque*/
create table Produto_estoque(
		produto_id_produto int,
        estoque_id_estoque int,
        localização varchar(255),
        primary key (produto_id_produto,estoque_id_estoque),
        constraint fk_produto_tem_produto foreign key(produto_id_produto) references produto(id_produto),
        constraint fk_produto_tem_estoque foreign key(estoque_id_estoque) references pedido(id_pedido)
);

/*Persistência de dados da tabela Produto_estoque*/
insert	into Produto_estoque(produto_id_produto,estoque_id_estoque,localização) values
			('1','1','Rua do comercio,225, Vila, São Paulo - SP CEP:12873-234'),
            ('2','2','Rua do comercio,225, Vila, São Paulo - SP CEP:12873-234'),
            ('3','3','Rua do comercio,225, Vila, São Paulo - SP CEP:12873-234'),
            ('4','4','Rua do comercio,225, Vila, São Paulo - SP CEP:12873-234');

select * from Produto_estoque;            

/*Criando tabela fornecedor tem produto */
create table fornecedor_tem_produto(
		fornecedor_id_fornecedor int,
        produto_id_produto int,
        primary key (fornecedor_id_fornecedor,produto_id_produto),
        constraint fk_fornecedor_tem_produto foreign key(fornecedor_id_fornecedor) references fornecedor(fornecedor_id),
        constraint fk_produto_tem_fornecedor foreign key(produto_id_produto) references produto(id_produto)       
);
show tables;

/*Persistência de dados da tabela forncedor_tem_estoque*/
insert into fornecedor_tem_produto(fornecedor_id_fornecedor,produto_id_produto) values
			('1','1'),
            ('2','1'),
            ('3','3'),
            ('4','2');
            
select * from fornecedor_tem_produto;            
          
          
/*Aplicando consultas SQL */      
          
/*Fazendo uma consulta SQL de Clientes buscando CPF, produto comprado, valor da compra,Forma de pagamento, quantidade de parcelas,
 trazendo uma Query com valor parcelado atraves de uma operação e mostrando Status do pedido ordenando resultados por valor da compra*/
 
select concat(pnome,' ', sobrenome) as Cliente, cpf, produto, valor_pedido as "Valor da compra", tipo_pagamento as "Forma de pagamento",
quantidade_parcelas as parcelas,(valor_pedido/quantidade_parcelas) as "Valor parcelado",status_pedido 
from cliente inner join formas_pagamento
on id_cliente=pagamento_id_cliente 
inner join pedido 
on pedido_cliente_id = id_cliente
inner join produto_pedido
on id_pedido=produto_id_pedido
inner join produto
on id_produto=produto_id_produto
order by valor_pedido ;


/*Agrupando formas de pagamento e somando valor total de cada uma, e quantidade de formas do mesmo pagamento*/

select forma_pagamento as "Formas de pagamento",count(*) as Quantidade, sum(valor_pedido) as 'Valor total' from pedido
group by forma_pagamento ;



/*Verificando se um determinado tipo de pagamento possui o status do pedido como entregue
usando AS, INNER JOIN e HAVING*/

select concat(pnome, c.sobrenome) as Cliente, produto, valor_pedido as "valor da compra", tipo_pagamento as "Forma de Pagamento",status_pedido
from cliente as c
inner join formas_pagamento
on id_cliente=pagamento_id_cliente
inner join pedido 
on pedido_cliente_id = id_cliente
where tipo_pagamento='Boleto'
having status_pedido='entregue';


/*Somando o valor total de uma Forma de Pagamento*/

select sum(valor_pedido)as 'Valor total Pago por Boleto' from pedido
where forma_pagamento='boleto';       

/*Consultando alguns dados de clientes com ordem descrescente*/
select concat(pnome,' ',Sobrenome)as "nome completo", login, email from cliente
order by id_cliente desc;   