-- criação de banco de dados para o cenario de E-commerce
-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table clients(
		idClient  int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Adress varchar(30),
        constraint unique_cpf_client unique (CPF)
        
);

alter table clients auto_increment = 1;

-- desc clients;
-- criar tabela produto

-- size -dimensão do produto
create table product(
		idProduct  int auto_increment primary key,
        Pname varchar(10),
        classification_kid bool,
        category enum('eletrônico','moda', 'brinquedos', 'alimentos','móveis') not null,
        Adress varchar(30),
        avaliation float default 0,
        size enum('P','M','G','GG','XL','Não consta')
             
        
);
-- criar tabela pagamento
-- terminar de implementar a tabelae crie a conexão com as tabelas nescessarias
-- reflita essa modificação no diagram de esquema relacional
-- criar constrain relacional ao pagamento
create table payment(
		idPayment int primary key auto_increment,
		idClient int,
        typePayment enum('boleto','credito','debito','pix', 'dinheiro'),
        cardNumber varchar(45),
        limitAvaliable float,
        constraint fk_payment_client foreign key (idClient) references clients(idClient)
);
desc  payment;
-- criar tabela pedido

create table orders(
		idOrder int auto_increment primary key,
        idOrderClient int,
        idPayment int,
        orderStatus enum('cancelado','confirmado','Em processo')default 'Em processo',
        orderDescription varchar(255),
        sendValue float default 10,
        paymentCash bool default false ,
        constraint fk_orders_payment foreign key (idPayment) references payment(idPayment),
        constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
        
);

-- criar tabela estoque
create table productStorage(
		idProdStorage int auto_increment primary key,
        storageLocation varchar(255),
        quality int default 0
);


-- criar tabela fornecedor
create table supplier(
		idSupplier int auto_increment primary key,
        SocialName varchar(255)not null,
        CNPJ char(15) not null,
        Phone char(11) not null,
        Email char(45),
        constraint unique_supplier unique (CNPJ) 
        );
        
  desc supplier;
  
-- criar tabela vendedor
create table seller(
        idSeller int auto_increment primary key, 
        SocialName varchar(255)not null,
        AbstName varchar(255),
        CNPJ char(15),
        CPF char(9),
        email varchar(45),
        phone varchar(11),
        location varchar(255),
        constraint unique_CNPJ_seller unique (CNPJ),
        constraint unique_CPF_seller unique (CPF)
     
);

desc seller;

-- relacionamento N pra M
create table productSeller(
	idPseller int,
	idPproduct int,
    prodQuantity int default 1,
    primary key (idPSeller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
    
);

desc productSeller;
-- relacionamento N pra M
create table productOrder(
		idPOproduct int,
        idPOorder int,
        poQuality int default 1,
        poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
        primary key (idPOproduct, idPOorder),
        constraint fk_productOrder_seller foreign key (idPOproduct) references product(idProduct),
        constraint fk_productOrder_product foreign key (idPOorder) references orders(idOrder)
        
        );
        
  -- relacionamento N pra M 
  
create table storageLocation(
		idLproduct int,
        idLstorage int,
        location varchar(255) not null,
        primary key (idLproduct, idLstorage),
        constraint fk_storage_Location_product foreign key (idLproduct) references product(idProduct),
        constraint fk_storage_Location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
		idPrSupplier int,
        idPrProduct int,
        quantity int not null,
        primary key(idPrSupplier, idPrProduct),
        constraint fk_product_supplier_supplier foreign key (idPrSupplier) references supplier(idSupplier),
        constraint fk_product_supplier_product  foreign key (idPrProduct) references product(idProduct)
);

desc productSupplier;

show tables;

show databases;
use information_schema;
show tables;
desc REFERENTIAL_CONSTRAINTS;
select * from referential_constraints where constraint_schema = 'ecommerce';
