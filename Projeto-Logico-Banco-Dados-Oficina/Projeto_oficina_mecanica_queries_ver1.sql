-- inserção de dados e queries no banco de dados da oficina mecânica
use oficina_mecanica;
show tables;

-- idcliente, Fnome, Sobrenome, RazaoSocial, Tipojuridico enum('PF', 'PJ') not null default 'PF', Cpf, Cnpj, Endereco, Telefone
insert into cliente (Fnome, Sobrenome, RazaoSocial, Tipojuridico, Cpf, Cnpj, Endereco, Telefone)
		values('Maria', 'Silva', null, 'PF', '12345610789', null,'rua silva de prata 29, Carangola - Cidade das flores', 15981200520),
			  ('Matheus', 'Pimentel', null, 'PF', '98741654321', null, 'rua alameda 289, Centro - Cidade das flores', 15981200522),
              ('Ricardo', 'Silva', null, 'PF', '34567891543', null, 'rua alameda vinha 1009, Centro - Cidade das flores', 15981205520),
              ('Julia', 'França', null, 'PF', '78912473456', null, 'rua lareiras 861, Centro - Cidade das flores', 15989200520),
              ('Roberta', 'Assis', null, 'PF', '98764425631', null, 'avenida de koller 19, Centro - Cidade das flores', 15981270520),
              ('Isabela', 'Cruz', null, 'PF', '65478942123', null, 'rua alameda das flores 28, Centro - Cidade das flores', 15991200520);
   
select * from cliente;

-- idmecanico, PnomeMecanico, SobrenomeMecanico, StatusMecanico enum ('Livre', 'Ocupado') default 'Livre', ValorMaoObra
insert into mecanico (PnomeMecanico, SobrenomeMecanico, StatusMecanico, ValorMaoObra)
		values('Pimentel', 'Roberta', default, 520.00),
			  ('Cruz', 'Pimentel', 'Ocupado', 2.522),
              ('flores', 'Silva', 'Ocupado', 55.20),
              ('koller', 'França', 'Ocupado', 200.20),
              ('Roberta', 'Assis', 'Ocupado', 70.20),
              ('França', 'Cruz', default, 912.20);

select * from mecanico;

-- Placa, idveiculo, Estado, Chassi, Marca, Modelo, AnoVeiculo, cliente_idcliente, mecanico_idmecanico
insert into veiculo (Placa, Estado, Chassi, Marca, Modelo, AnoVeiculo, cliente_idcliente, mecanico_idmecanico)
		values('MHR5D65', 'RJ', 'CHASSI546123789', 'VOLKS', 'GOL', 2000, 1, 1),
			  ('RFD2542', 'RJ', 'CHASSI546123789', 'VOLKS', 'GOL', 2022, 2, 2),
              ('WSK5469', 'BA', 'CHASSDDDDS23789', 'VOLKS', 'GOL', 1980, 3, 3),
              ('ASD5S62', 'RJ', 'CHASGVDFF123789', 'VOLKS', 'GOL', 2020, 4, 4),
              ('LJH5896', 'RS', 'CHASSI546123789', 'VOLKS', 'GOL', 2003, 5, 5),
              ('ADF1235', 'MG', 'CHASSI546123789', 'VOLKS', 'GOL', 2020, 6, 6);

select * from veiculo;

-- idorcamento, DataOrcamento, ValorOrcamento, StatusOrcamento enum('Aceito', 'Arguadando', 'Não aceito') default 'Aceito', cliente_idcliente, mecanico_idmecanico
insert into orcamento (DataOrcamento, ValorOrcamento, StatusOrcamento, cliente_idcliente, mecanico_idmecanico)
		values(20230720, 1520.00, default, 1, 1),
			  (20230720, 2520.00, default, 2, 2),
              (20230720, 3520.00, default, 3, 3),
              (20230720, 4520.00, default, 4, 4),
              (20230720, 5320.00, default, 5, 5),
              (20230720, 5250.00, default, 6, 6);
              
select * from orcamento;

-- idordemdeservico, StatusOrdemServico enum ('Aberto', 'Executando', 'cancelada', 'Finalizado') default 'Aberto', DataOrdemServico, DataPrevista, 
-- ValorOdemServico, orcamento_idorcamento, orcamento_mecanico_idmecanico
insert into ordemdeservico (StatusOrdemServico, DataOrdemServico, DataPrevista, ValorOdemServico, orcamento_idorcamento, orcamento_mecanico_idmecanico)
		values(default, 20230720, 20230720, 1520.00, 1, 1),
			  (default, 20230720, 20230720, 2520.00, 2, 2),
              (default, 20230720, 20230720, 3520.00, 3, 3),
              (default, 20230720, 20230720, 4520.00, 4, 4),
              (default, 20230720, 20230720, 5320.00, 5, 5),
              (default, 20230720, 20230720, 5250.00, 6, 6);

select * from ordemdeservico;

-- idpagamento, TipoPagamento enum ('Boleto', 'Cartão', 'Dois cartões') default 'Boleto', 
-- StatusPagamento enum ('Efetuado', 'Não efetuado', 'Ordem de serviço cancelada') default 'Não efetuado', DataPagamento, 
-- ValorPagamento, ordemdeservico_idordemdeservico, ordemdeservico_orcamento_idorcamento, ordemdeservico_orcamento_mecanico_idmecanico
insert into pagamento (TipoPagamento, StatusPagamento, DataPagamento, ValorPagamento, ordemdeservico_idordemdeservico, ordemdeservico_orcamento_idorcamento, ordemdeservico_orcamento_mecanico_idmecanico, cliente_idcliente)
		values(default, default, 20230720, 550.00, 1, 1, 1, 1),
			  (default, default, 20230720, 1550.00, 2, 2, 2, 2),
              (default, default, 20230720, 5250.00, 3, 3, 3, 3),
              (default, default, 20230720, 5510.00, 4, 4, 4, 4),
              (default, default, 20230720, 342.52, 5, 5, 5, 5),
              (default, default, 20230720, 50.00, 6, 6, 6, 6);

select * from pagamento;


-- Quantos clientes estão cadastrados na oficina?
select count(*) as TotalClientes from cliente;

-- Quais são os mecânicos que estão ocupados no momento?
select PnomeMecanico, SobrenomeMecanico
from mecanico
where StatusMecanico = 'Ocupado';

-- Quais são os veículos que estão em ordem de serviço "Aberto"?
select Placa, Marca, Modelo
from veiculo v
join ordemdeservico os on v.idveiculo = os.idordemdeservico
where os.StatusOrdemServico = 'Aberto';

-- Quais são os orçamentos que foram aceitos?
select idorcamento, DataOrcamento, ValorOrcamento
from orcamento
where StatusOrcamento = 'Aceito';

-- Qual o total de valor em pagamentos efetuados até o momento?
select sum(ValorPagamento) as TotalPagamentosEfetuados
from pagamento
where StatusPagamento = 'Efetuado';

-- Quais são os clientes que têm mais de um veículo cadastrado?
select c.Fnome, c.Sobrenome
from cliente c
join veiculo v on c.idcliente = v.cliente_idcliente
group by c.idcliente, c.Fnome, c.Sobrenome
having count(v.idveiculo) > 1;

-- Quais são os mecânicos que têm o valor de mão de obra superior a 50?
select PnomeMecanico, SobrenomeMecanico, ValorMaoObra
from mecanico
where ValorMaoObra > 50;






