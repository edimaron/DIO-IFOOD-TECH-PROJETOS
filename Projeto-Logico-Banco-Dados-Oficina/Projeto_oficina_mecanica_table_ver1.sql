-- criação do banco de dados para o cenário de Oficina Mecânica
-- drop database oficina_mecanica;

create database oficina_mecanica;
use oficina_mecanica;

-- criar tabela cliente
create table cliente(
		idcliente int auto_increment primary key,
        Fnome varchar(45),
        Sobrenome varchar(255),
        RazaoSocial varchar(45),
        Tipojuridico enum('PF', 'PJ') not null default 'PF',
		Cpf char(11),
        Cnpj char(15),
        Endereco varchar(255),
        Telefone char(11),
        constraint unique_Cpf_cliente unique(Cpf),
        constraint unique_Cnpj_cliente unique(Cnpj),
		check ((Tipojuridico = 'PJ' and Cnpj is not null and Cpf is null)
		or
		(Tipojuridico = 'PF' and Cpf is not null and Cnpj is null))
);

alter table cliente auto_increment = 1;

-- criar tabela mecanico
create table mecanico(
		idmecanico int auto_increment primary key,
        PnomeMecanico varchar(45),
        SobrenomeMecanico varchar(255),
        StatusMecanico enum ('Livre', 'Ocupado') default 'Livre',
        ValorMaoObra float
);

alter table mecanico auto_increment = 1;

-- criar tabela veiculo
create table veiculo(
		Placa char(7),
        idveiculo int auto_increment,
        Estado char(2),
        Chassi varchar(45),
        Marca varchar(45),
        Modelo varchar(45),
        AnoVeiculo int,
        cliente_idcliente int,
        mecanico_idmecanico int,
        primary key (idveiculo, cliente_idcliente, mecanico_idmecanico),
		constraint fk_veiculo_cliente foreign key(cliente_idcliente) references cliente(idcliente) on update cascade,
        constraint fk_veiculo_mecanico1 foreign key(mecanico_idmecanico) references mecanico(idmecanico) on update cascade
);

alter table veiculo auto_increment = 1;

-- criar tabela orçamento
create table orcamento(
		idorcamento int auto_increment,
        DataOrcamento date,
        ValorOrcamento float,
        StatusOrcamento enum('Aceito', 'Arguadando', 'Não aceito') default 'Aceito',
        cliente_idcliente int,
        mecanico_idmecanico int,
        primary key (idorcamento, mecanico_idmecanico),
		constraint fk_orcamento_mecanico1 foreign key(mecanico_idmecanico) references mecanico(idmecanico) on update cascade
);

alter table orcamento auto_increment = 1;

-- criar tabela ordem de serviço
create table ordemdeservico(
		idordemdeservico int auto_increment,
        StatusOrdemServico enum ('Aberto', 'Executando', 'cancelada', 'Finalizado') default 'Aberto',
        DataOrdemServico date,
        DataPrevista date,
        ValorOdemServico float,
        orcamento_idorcamento int,
        orcamento_mecanico_idmecanico int,
        primary key (idordemdeservico, orcamento_idorcamento, orcamento_mecanico_idmecanico),
        constraint fk_ordemdeservico_orcamento1 foreign key(orcamento_idorcamento, orcamento_mecanico_idmecanico) references orcamento(idorcamento, mecanico_idmecanico) on update cascade
);

alter table ordemdeservico auto_increment = 1;

-- criar tabela pagamento
create table pagamento(
		idpagamento int auto_increment,
        TipoPagamento enum ('Boleto', 'Cartão', 'Dois cartões') default 'Boleto',
        StatusPagamento enum ('Efetuado', 'Não efetuado', 'Ordem de serviço cancelada') default 'Efetuado',
        DataPagamento date,
        ValorPagamento float,
        ordemdeservico_idordemdeservico int,
        ordemdeservico_orcamento_idorcamento int,
        ordemdeservico_orcamento_mecanico_idmecanico int,
        cliente_idcliente int,
        primary key (idpagamento, ordemdeservico_idordemdeservico, ordemdeservico_orcamento_idorcamento, ordemdeservico_orcamento_mecanico_idmecanico, cliente_idcliente),
        constraint fk_pagamento_ordemdeservico1 foreign key(ordemdeservico_idordemdeservico, ordemdeservico_orcamento_idorcamento, ordemdeservico_orcamento_mecanico_idmecanico) references ordemdeservico(idordemdeservico, orcamento_idorcamento, orcamento_mecanico_idmecanico) on update cascade,
		constraint fk_pagamento_cliente1 foreign key(cliente_idcliente) references cliente(idcliente) on update cascade
);

alter table pagamento auto_increment = 1;

