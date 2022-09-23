-- criação de banco de dados para oficina
create database oficina;
use oficina;

-- criar tabela Ordem de Serviço            
create table OrdemServico (
			IdOrdemServico int primary key auto_increment,
            StatusOS enum ('Em andamento', 'Pronto') default "Em andamento",
            DataEmissao date,
            PrevisaodeConclusao date,
            Valor float);
 
 -- criar tabela cliente
create table Cliente (
			IdCliente int primary key auto_increment,
            Nome varchar(45) not null,
            Endereco varchar(100) not null,
            CPF char(11) not null,
            IdOrdemServico int,
            foreign key (IdOrdemServico)
            references OrdemServico(IdOrdemServico)
            );            
            
-- criar tabela Mão de Obra
create table MaodeObra (
			IdServico int primary key auto_increment,
            MaodeObra float
            );
            
-- criar tabela Peça
create table Peca (
			IdPeca int primary key auto_increment,
            PrecoPeca float
            );
            
            
-- criar tabela Relação Ordem de Serviço Mão de Obra
create table OSMaodeObra (
			IdOrdemServico int,
            foreign key (IdOrdemServico)
            references OrdemServico(IdOrdemServico),
            IdServico int,
            foreign key (IdServico)
            references Servico(IdServico)
			);

-- criar tabela Relação Ordem de Serviço Peças
create table OSPeca (
			IdOrdemServico int,
            foreign key (IdOrdemServico)
            references OrdemServico(IdOrdemServico),
            IdPeca int,
            foreign key (IdPeca)
            references Peca(IdPeca)
			);
            
-- criar tabela Mecanico
create table Mecanico (
			IdCMecanico int primary key auto_increment,
            NomeMecanico varchar(45) not null,
            EnderecoMecanico varchar(100) not null,
            Especialidade varchar(50)
            );            
            
-- criar tabela Veículo
create table Veiculo (
			IdVeiculo int primary key auto_increment,
            Placa varchar(14),
            IdRevisao int,
            foreign key (IdRevisao)
            references Analise(IdRevisao),
            IdOrdemServico int,
            foreign key (IdOrdemServico)
            references OrdemServico(IdOrdemServico),
            IdMecanico int,
            foreign key (IdMecanico)
            references Mecanico(IdMecanico)
            );
            
-- criar tabela Análise
create table Analise (
			IdAnalise int primary key auto_increment,
            Revisao boolean,
            Conserto boolean,
            IdOrdemServico int,
            foreign key (IdOrdemServico)
            references OrdemServico(IdOrdemServico),
            IdMecanico int,
            foreign key (IdMecanico)
            references Mecanico(IdMecanico)
            );
            
-- criar tabela Cliente Veículo
create table ClienteVeiculo (
			IdCliente int,
            foreign key (IdCliente)
            references Cliente(IdCliente),
            IdOrdemServico int,
            foreign key (IdOrdemServico)
            references OrdemServico(IdOrdemServico),
            IdVeiculo int,
            foreign key (IdVeiculo)
            references Veiculo(IdVeiculo)
            );

-- Populando a tabela cliente
insert into Cliente (Nome, CPF, Endereço)
		values ('Raquel Sousa', '12345678910', 'Rua dos bobos, nº 0, Rio de Janeiro, RJ'),
                ('Raissa Fofinha', '12345678911', 'Alameda da Preguiça, nº 20, Rio de Janeiro, RJ'),
                ('Elaine Curtinha', '09876543213', 'Rua dos Aposentados, nº 55, Duque de Caxias, RJ');
                
-- Populando a tabela ordem de serviço
insert into OrdemServico (StatusOS, DataEmissao, PrevisaodeConclusao, Valor)
			value ('Em andamento', 09/23/2022, 10/23/2022, 599.9),
				  ('Pronto', 08/15/2022, 09/10/2022, 1215.9),
                  ('Em andamento', 09/19/2022, 10/08/2022, 700.5);
                  
-- Populando a tabela Mecanico
insert into Mecanico (NomeMecanico, EnderecoMecanico, Especialidade)
			value ('Jorge', 'Oficina do Jorge', 'Motor'),
				  ('Sergio', 'Lanternagem daqui', 'Lanternagem');
            
-- Populando a tabela Análise
insert into Analise (Revisao, Conserto)
			value (true, false),
				  (true, true),
                  (false, false);
                  
-- Queries
show tables;
desc produto;
select * from cliente as c, veiculo as v, mecanico as m order by c.nome;
select * from cliente as c, OrdemServico as os, mecanico as m, analise as a where os.PrevisaodeConclusao = a.Conserto "true";
select nome, valor from cliente as c, OrdemServico as os having os.valor > 600;