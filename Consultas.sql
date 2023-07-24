-- Quantos pedidos foram feitos por cada cliente
select c.primeiroNome as Nome, count(idPedidoCliente) as total_de_pedidos from Pedido p , Cliente c 
where p.idCliente like c.idCliente
group by c.idCliente 
order by c.idCliente

-- Algum vendedor também é fornecedor?
select v.nomeFantasia as Nome from Vendedor v, Fornecedor f where v.CNPJ like f.CNPJ;

-- Relação de produtos fornecedores e estoques;
select v.razaoSocial as 'Razão Social', v.nomeFantasia as 'Nome Empresa', p.nomeProduto as Produto,pv.Quantidade as 'Quantidade Estoque'
from ProdutosVendedor pv, Estoque e
inner join Vendedor v on pv.idVendedor = v.idVendedor
inner join Produto p
order by 'Razão Social';

-- Relação cliente-pedido-vendedor
select c.Fname as Cliente, o.ordersState as status, o.ordersDescription as modalidade, o.payment as pagamento, otp.quantity, otp.status, 
p.Pname as produto, p.category as categoria, e.socialName as Vendedor, fantasyName as Empresa
from clients c 
left outer join orders o on idClient = idOrdersClient 
left outer join ordersToProduct otp on o.idOrders = otp.idOrders 
left outer join product p on otp.idProduct = p.idProduct
left outer join employeeToProduct etp on p.idProduct = etp.idProduct
left outer join employee e on e.idEmployee = etp.idEmployee;