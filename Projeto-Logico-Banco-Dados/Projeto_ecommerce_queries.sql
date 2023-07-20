-- inserção de dados e queries
use ecommerce;
show tables;

-- idCliente, Fname, Minit, Lname, CPF, Address
insert into clients (Fname, Minit, Lname, Typejuridico, CNPJ, CPF, Address)
		values('Maria', 'M', 'Silva', 'PF', null, '123456789', 'rua silva de prata 29, Carangola - Cidade das flores'),
			  ('Matheus', 'O', 'Pimentel', 'PF', null, '987654321', 'rua alameda 289, Centro - Cidade das flores'),
              ('Ricardo', 'F', 'Silva', 'PF', null, '45678913', 'rua alameda vinha 1009, Centro - Cidade das flores'),
              ('Julia', 'S', 'França', 'PF', null, '789123456', 'rua lareiras 861, Centro - Cidade das flores'),
              ('Roberta', 'G', 'Assis', 'PF', null, '98745631', 'avenida de koller 19, Centro - Cidade das flores'),
              ('Isabela', 'M', 'Cruz', 'PF', null, '654789123', 'rua alameda das flores 28, Centro - Cidade das flores');
              
select * from clients;
              
-- idProduct, Pname, classification_kids boolean, category('Eletrônico', 'Vestimenta', 'Alimentos', 'Móveis'), avaliação, size
insert into product (Pname, classification_kids, category, avaliação, size) values
								('Fone de ouvido', false, 'Eletrônico', '4', null),
                                ('Barbie Elsa', true, 'Eletrônico', '3', null),
                                ('Body Carters', true, 'Vestimenta', '5', null),
                                ('Microfone Vedo - Youtuber', False, 'Eletrônico', '4', null),
                                ('Sofá retrátil', false, 'Móveis', '3', '3x57x80'),
                                ('Farinha de arroz', false, 'Alimentos', '2', null),
                                ('Fire Stick Amazon', false, 'Eletrônico', '3', null);
         

select * from product;                                
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
							('1', default, 'compra via aplicativo', null, 1),
                            ('2', default, 'compra via aplicativo', 50, 0),
                            ('3', 'Comfirmado', null, null, 1),
                            ('4', default, 'compra via web site', 150, 0);
                            
 
 select * from orders;
-- idPOproduct, idPOorder, poQuantity, poStatus
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						(1, 1, 2, null),
                        (2, 1, 1, null),
                        (3, 2, 1, null);
                        
                        
-- storageLocation, quantity
insert into productStorage (storageLocation, quantity) values
							('Rio de Janeiro', 1000),
                            ('Rio de Janeiro', 500),
                            ('São Paulo', 10),
                            ('São Paulo', 100),
                            ('São Paulo', 10),
                            ('Brasília', 60);
                            
                     
-- idLproduct, idLstorage, location 
insert into storageLocation (idLproduct, idLstorage, location) values
						(1, 2, 'RJ'),
                        (2, 6, 'GO');
                        
                        
  -- idSupplier, SocialName, CNPJ, contact 
  insert into supplier (SocialName, CNPJ, contact) values
						('Almeida e filhos', 123456789123456 , '21985474'),
                        ('Eletrônicos Silva', 854519649143457 , '21985484');  
                        
select * from supplier;				
-- idPsSupplier, idPsProduct, quantity
insert into productSupplier(idPsSupplier, idPsProduct, quantity) values
						(1, 1, 6),
                        (1, 2, 8),
                        (2, 4, 9),
                        (1, 3, 5),
                        (2, 5, 10);
                        
-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
							('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
							('Botique Durgas', null, null, 123456783, 'Rio de Janeiro', 219567895),
                            ('Kids World', null, 456789123654485, null, 'São Paulo', 1198657484);
                            
                     insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
							('Tech eletronics', null, 123456789123456, null, 'Rio de Janeiro', 219946287);
                     
                            
select * from seller;                            
-- idPseller, idPproduct, prodQuantity
insert into productSeller (idPseller, idPproduct, prodQuantity) values
						(1, 6, 80),
                        (2, 7, 10);
                        
select * from productSeller;

select count(*) from clients;

select * from clients c orders o where c.idClient = o.idOrderClient;
                        
select Fname, Lanme, idOrder, orderStatus from clients c orders o where c.idClient = idOrderClient;
            
select concat(Fname, ' ',Lname) as Client, idOrder as Request, orderStatus as Status from clients c orders o where c.idClient = o.idOrderClient;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
							('2', default, 'compra via aplicativo', null, 1),
                            
select * from clients c orders o 
where c.idClient = idOrderClient;

select * from clients left outer join orders ON idClient = idOrderClient;

select * from clients c inner join orders o ON c.idClient = o.idOrderClient
					inner join productOrder p on p.idPOorder = o.idOrder;
                    
select * from orders;

-- recuperação de pedido com produto associado
select * from clients c 
					inner join orders o ON c.idClient = o.idOrderClient
					inner join productOrder p on p.idPOorder = o.idOrder
                    group by idClient;
                    
-- Recuperar quantos pedidos foram realizados pelos clientes
select c.idClient, Fname, count(*) as Number_of_orders from clients c 
					inner join orders o on c.idClient = o.idOrderClient
					inner join productOrder p on p.idPOorder = o.idOrder
                    group by idClient;
                    
        -- Quantos pedidos foram feitos por cada cliente?            
-- Para saber quantos pedidos foram feitos por cada cliente, você pode usar a cláusula GROUP BY
-- em uma consulta SQL para agrupar os pedidos por cliente e, em seguida, usar a função de agregação 
-- COUNT() para contar o número de pedidos para cada cliente. 

select idOrderClient, COUNT(*) as QuantidadePedidos
from orders
GROUP BY idOrderClient;

-- Algum vendedor também é fornecedor?
-- Para saber se algum vendedor também é fornecedor no seu banco de dados, você pode usar uma consulta SQL 
-- com uma cláusula JOIN para combinar as tabelas seller e supplier com base em um critério de correspondência. 
-- Se houver uma correspondência entre um vendedor e um fornecedor com o mesmo CNPJ ou CPF, isso indica que o vendedor também é fornecedor.

SELECT EXISTS (
    SELECT 1
    FROM seller s
    WHERE EXISTS (
        SELECT 1
        FROM supplier sp
        WHERE s.CNPJ = sp.CNPJ
    )
) AS VendedorTambemFornecedor;


SELECT *FROM seller s
JOIN supplier sp ON s.CNPJ = sp.CNPJ;

-- Relação de produtos fornecedores e estoques;
-- Para obter a relação de produtos, fornecedores e estoques, você precisará usar uma combinação de cláusulas 
-- JOIN para unir as tabelas relacionadas. Pelo código fornecido anteriormente, temos as tabelas product, supplier, 
-- productSupplier e productStorage que estão relacionadas entre si.

SELECT p.idProduct, p.Pname AS ProductName, s.idSupplier, s.SocialName AS SupplierName, ps.quantity AS StockQuantity, ps2.storageLocation AS StockLocation
FROM product p
JOIN productSupplier ps ON p.idProduct = ps.idPsProduct
JOIN supplier s ON ps.idPsSupplier = s.idSupplier
JOIN productStorage ps2 ON p.idProduct = ps2.idProdStorage;

-- Relação de nomes dos fornecedores e nomes dos produtos;
-- Para obter a relação de nomes dos fornecedores e nomes dos produtos, você precisa combinar as tabelas supplier, 
-- product, e productSupplier através de cláusulas JOIN.  

SELECT s.SocialName AS SupplierName, p.Pname AS ProductName
FROM supplier s
JOIN productSupplier ps ON s.idSupplier = ps.idPsSupplier
JOIN product p ON ps.idPsProduct = p.idProduct;





