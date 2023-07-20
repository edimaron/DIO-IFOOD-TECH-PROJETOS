-- criação do banco de dados para o cenário de E-commerce
-- drop database ecommerce;

create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10),
        Minit varchar(3),
        Lname varchar(20),
        Typejuridico enum('PJ', 'PF') not null default 'PJ',
		CNPJ char(15),
        CPF char(11),
        Address varchar(255),
        constraint unique_cpf_client unique(CPF),
        constraint unique_cnpj_client unique(CNPJ),
		check ((Typejuridico = 'PJ' and CNPJ is not null and CPF is null)
		or
		(Typejuridico = 'PF' and CPF is not null and CNPJ is null))
);

alter table clients auto_increment = 1;

desc clients;
    
-- criar tabela produto
-- size = dimensão do produto
create table product(
		idProduct int auto_increment primary key,
        Pname varchar(30) not null,
        classification_kids bool default false,
        category enum('Eletrônico', 'Vestimenta', 'Alimentos', 'Móveis') not null,
        avaliação float default 0,
        size varchar(10)
);

alter table product auto_increment = 1;
        
-- criar tabela pagamentos
-- para ser continuado no desafio termine de implementar a tabela e crie a conexão com  as tabelas necessárias
-- além disso, reflita essa modificação no esquema relacional
-- criar constraint relacionadas ao pagamento
create table payments(
		idpagClient int,
        idPayment int,
        typePayment enum('Boleto', 'Cartão', 'Dois cartões'),
        limitAvailable float,
        primary key(idpagClient, idPayment),
        foreign key (idpagClient) references clients (idClient) on delete cascade
);

create table payment_methods (
  idMethod int auto_increment primary key,
  idmethClient int,
  typePayment enum('Boleto', 'Cartão', 'Dois cartões'),
  limitAvailable float,
  foreign key (idmethClient) references clients (idClient) on delete cascade
);

-- criar tabela pedido
create table orders(
		idOrderClient int,
        orderStatus enum('Cancelado', 'Comfirmado', 'Em processamento') default 'Em processamento',
        orderDescription varchar(255),
        sendValue float default 10,
        paymentCash bool default false,
        deliveryStatus enum('Entregue', 'Em trânsito', 'Aguardando envio') default 'Aguardando envio',
        trackingCode VARCHAR(20),
        constraint fk_ordes_client foreign key(idOrderClient) references clients(idClient)
					on update cascade
);

alter table orders auto_increment = 1;

desc orders;
    
-- criar tabela estoque
create table productStorage(
		idProdStorage int auto_increment primary key,
		storageLocation varchar(255),
		quantity int default 0
);

alter table productStorage auto_increment = 1;
            
    -- criar tabela fornecedor
    create table supplier(
		idSupplier int auto_increment primary key,
        SocialName varchar(255) not null,
        CNPJ char(15) not null,
        contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
);

alter table supplier auto_increment = 1;

desc supplier;
    
    -- criar tabela vendedor
    create table seller(
		idSeller int auto_increment primary key,
        SocialName varchar(255) not null,
        AbstName varchar(255),
        CNPJ char(15),
        CPF char(9),
        location varchar(255),
        contact char(11) not null,
        constraint unique_cnpj_seller unique (CNPJ),
        constraint unique_cpf_seller unique (CPF)
);

alter table seller auto_increment = 1;
    
     -- criar tabela produtos_vendedor
    create table productSeller(
		idPSeller int,
        idPproduct int,
        prodQuantity int default 1,
        primary key (idPSeller, idPproduct),
        constraint fk_product_seller foreign key (idPSeller) references seller(idSeller),
        constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

desc productSeller;
    
     -- criar tabela produtos_Order
    create table productOrder(
		idPOproduct int,
        idPOorder int,
        poQuantity int default 1,
        poStatus enum('Disponível','Sem estoque') default 'Disponível',
        primary key (idPOproduct, idPOorder),
        constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
        constraint fk_productorder_product foreign key (idPOorder) references orders(idOrderClient)
	);
    
    -- criar tabela storagelocation
    create table storageLocation(
		idLProduct int,
        idLstorage int,
        location varchar(255) not null,
        primary key (idLproduct, idLstorage),
        constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
        constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idprodStorage)
);

-- criar tabela productSupplier
    create table productSupplier(
		idPsSupplier int,
        idPsProduct int,
        quantity int not null,
        primary key (idPsSupplier, idPsProduct),
        constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
        constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

desc productSupplier;

show tables;

show databases;

use information_schema;

show tables;

desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';

