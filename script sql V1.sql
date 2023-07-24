-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------
create database ecommerce;
use ecommerce;

-- -----------------------------------------------------
-- Table ecommerce.Cliente
-- -----------------------------------------------------
create table Cliente(
		idCliente int auto_increment primary key,
        primeiroNome varchar(20),
        ultimoNome varchar(20),
        sobreNome varchar(20),
        registroGeral varchar(45),
        endereço varchar(45),
        CPF Char(11) not null,
        dataNascimento Date,
		telefone varchar(11),
		email varchar(50),
        constraint unique_cpf_cliente unique(CPF),
        dataCadastro date,
        dataAtualizacao date
);


-- -----------------------------------------------------
-- Table ecommerce.Produto
-- -----------------------------------------------------
create table Produto(
		idProduto int auto_increment primary key,
        nomeProduto varchar(60) not null,
        codigo int(20),
        categoria enum('eletronicos', 'vestimentas', 'eletrodomesticos', 'Kids'),
        descrição  varchar(350),
        codigoBarra int(100),
        valorCusto decimal(7),
        valorVenda decimal(7)
);


-- -----------------------------------------------------
-- Table ecommerce.Pedido
-- -----------------------------------------------------
create table Pedido(
		idCliente int,
        idPedido int auto_increment primary key,
        idPedidoCliente int,
        pedidoStatus enum('Aguardando Confirmação de Pagamento','Pagamento Efetuado','Em separação', 'Enviado', 'Entregue') default 'Aguardando Confirmação de Pagamento',
        pedidoDescrição  varchar(255),
        pedidoFrete float default 10,
        idOrdemPagamento int,
		constraint fk_pedido_Cliente foreign key (idPedidoCliente) references Cliente (idCliente)
);


-- -----------------------------------------------------
-- Table ecommerce.Estoque
-- -----------------------------------------------------
create table Estoque(
idEstoque int auto_increment primary key,
localizacao varchar (45),
quantidade int default 0
);


-- -----------------------------------------------------
-- Table ecommerce.Fornecedor
-- -----------------------------------------------------
create table Fornecedor(
idFornecedor int auto_increment primary key,
endereco varchar (45),
razaoSocial varchar (45) not null,
nomeFantasia varchar (45),
CNPJ char (14) not null,
telefone varchar(11) not null,
email char(60) not null,
inscricaoEstadual varchar (45) not null,
constraint unique_fornecedor unique(CNPJ)
);


-- -----------------------------------------------------
-- Table ecommerce.Vendedor
-- -----------------------------------------------------
create table Vendedor(
idVendedor int auto_increment primary key,
endereco varchar (100),
areaAtuacao  varchar (45),
razaoSocial varchar (45) not null,
nomeFantasia varchar (45),
CNPJ char (14),
CPF char (11),
telefone varchar(11) not null,
email char(60) not null,
constraint unique_CNPJ_vendedor unique(CNPJ),
constraint unique_CPF_vendedor unique(CPF)
);


-- -----------------------------------------------------
-- Table ecommerce.ProdutosVendedor
-- -----------------------------------------------------
create table ProdutosVendedor(
idProduto int,
idVendedor int,
idProdutoVendedor int,
Quantidade int default 1,
primary key (idProduto, idProdutoVendedor),
constraint fk_produto_vendedor foreign key (idProdutoVendedor) references Vendedor (idVendedor),
constraint fk_produto_produto foreign  key (idProduto) references Produto (idProduto)
);


-- -----------------------------------------------------
-- Table ecommerce.ProdutosPedido
-- -----------------------------------------------------
create table ProdutosPedido(
idProduto int,
idPedido int,
idVendedor int,
idProdutoVendedor int,
quantidade int default 1,
statusProduto enum('Disponivel','Sem Estoque') default 'Disponivel',
primary key (idProdutoVendedor, idPedido),
constraint fk_pedido_vendedor foreign key (idProdutoVendedor) references Vendedor (idVendedor),
constraint fk_pedido_produto foreign  key (idPedido) references Pedido (idPedido)
);


-- -----------------------------------------------------
-- Table ecommerce.ProdutoEstoque
-- -----------------------------------------------------
create table ProdutoEstoque (
idProduto int,
idEstoque int,
localizacao varchar (100) not null,
primary key (idProduto, idEstoque),
constraint fk_estoque_vendedor foreign key (idProduto) references Produto (idProduto),
constraint fk_estoque_produto foreign  key (idEstoque) references Pedido (idPedido)
);


-- -----------------------------------------------------
-- Table ecommerce.ProdutosFornecedor
-- -----------------------------------------------------
create table ProdutosFornecedor(
idProduto int,
idProdutoFornecedor int,
quantidade int default 1,
primary key (idProduto, idProdutoFornecedor),
constraint fk_fornecerdor_vendedor foreign key (idProdutoFornecedor) references Fornecedor (idFornecedor),
constraint fk_fornecerdor_produto foreign  key (idProduto) references Produto (idProduto)
);


-- -----------------------------------------------------
-- Table ecommerce.Estoque_has_Produto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ecommerce.Estoque_has_Produto (
  Estoque_idEstoque INT NOT NULL,
  Produto_idProduto INT NOT NULL,
  PRIMARY KEY (Estoque_idEstoque, Produto_idProduto),
  INDEX fk_Estoque_has_Produto_Produto1_idx (Produto_idProduto ASC),
  INDEX fk_Estoque_has_Produto_Estoque1_idx (Estoque_idEstoque ASC),
  CONSTRAINT fk_Estoque_has_Produto_Estoque1
    FOREIGN KEY (Estoque_idEstoque)
    REFERENCES ecommerce.Estoque (idEstoque)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Estoque_has_Produto_Produto1
    FOREIGN KEY (Produto_idProduto)
    REFERENCES ecommerce.Produto (idProduto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

    
show tables;