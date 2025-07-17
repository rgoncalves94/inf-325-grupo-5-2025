-- Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS `marketplace_db`;
USE `marketplace_db`;

-- -----------------------------------------------------
-- Tabela `lojistas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lojistas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `dados_cadastrais` VARCHAR(255) NULL,
  PRIMARY KEY (`id`));

-- -----------------------------------------------------
-- Tabela `clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `perfil` VARCHAR(45) NOT NULL DEFAULT 'padrão',
  `endereco` VARCHAR(500) NULL,
  PRIMARY KEY (`id`));

-- -----------------------------------------------------
-- Tabela `categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));

-- -----------------------------------------------------
-- Tabela `produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produtos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `preco` DECIMAL(10,2) NOT NULL,
  `estoque` INT NOT NULL DEFAULT 0,
  `lojista_id` INT NOT NULL,
  `descricao` TEXT(4000) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_produtos_lojistas`
    FOREIGN KEY (`lojista_id`)
    REFERENCES `lojistas` (`id`)
);

-- -----------------------------------------------------
-- Tabela associativa `produtos_categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produtos_categorias` (
  `produto_id` INT NOT NULL,
  `categoria_id` INT NOT NULL,
  PRIMARY KEY (`produto_id`, `categoria_id`),
  CONSTRAINT `fk_prodcat_produtos`
    FOREIGN KEY (`produto_id`)
    REFERENCES `produtos` (`id`),
  CONSTRAINT `fk_prodcat_categorias`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `categorias` (`id`)
);

-- -----------------------------------------------------
-- Tabela `pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NOT NULL,
  `data` DATETIME NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pedidos_clientes`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `clientes` (`id`)
);

-- -----------------------------------------------------
-- Tabela `itens_pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itens_pedidos` (
  `pedido_id` INT NOT NULL,
  `produto_id` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `preco_unitario` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`pedido_id`, `produto_id`),
  CONSTRAINT `fk_itens_pedidos`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `pedidos` (`id`),
  CONSTRAINT `fk_itens_produtos`
    FOREIGN KEY (`produto_id`)
    REFERENCES `produtos` (`id`)
);

-- -----------------------------------------------------
-- Tabela `Avaliacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `avaliacoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NOT NULL,
  `produto_id` INT NOT NULL,
  `nota` INT NOT NULL,
  `comentario` TEXT NULL,
  `data` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_avaliacoes_clientes`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `clientes` (`id`),
  CONSTRAINT `fk_avaliacoes_produtos`
    FOREIGN KEY (`produto_id`)
    REFERENCES `produtos` (`id`)
);

-- -----------------------------------------------------
-- Tabela `precos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `precos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `produto_id` INT NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `tipo_preco` VARCHAR(45) NOT NULL,
  `data_inicio_vigencia` DATE NOT NULL,
  `data_fim_vigencia` DATE NULL,
  `ativo` BOOLEAN NOT NULL,
  `data_criacao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_precos_produtos`
    FOREIGN KEY (`produto_id`)
    REFERENCES `produtos` (`id`)
);

-- -----------------------------------------------------
-- Tabela `reclamacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reclamacoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pedido_id` INT NOT NULL,
  `produto_id` INT NOT NULL,
  `titulo` VARCHAR(255) NOT NULL,
  `texto` TEXT NULL,
  `data` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_reclamacoes_pedidos`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `pedidos` (`id`),
  CONSTRAINT `fk_reclamacoes_produtos`
    FOREIGN KEY (`produto_id`)
    REFERENCES `produtos` (`id`)
);

-- -----------------------------------------------------
-- Tabela `transacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transacoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lojista_id` INT NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `status` ENUM('Sacado', 'Disponível', 'Indisponível') NOT NULL DEFAULT 'Disponível',
  `data` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_transacoes_lojistas`
    FOREIGN KEY (`lojista_id`)
    REFERENCES `lojistas` (`id`)
);


-- ===== INSERTS DE DADOS =====

-- Lojistas (3 registros)
INSERT INTO `lojistas` (`nome`, `email`, `dados_cadastrais`) VALUES
('TechCell Express', 'contato@techcell.com', 'CNPJ: 12.345.678/0001-90'),
('Casa & Eletro Premium', 'vendas@casaeletro.com', 'CNPJ: 23.456.789/0001-01'),
('InfoWorld Solutions', 'atendimento@infoworld.com', 'CNPJ: 34.567.890/0001-12');

-- Clientes (20 registros)
INSERT INTO `clientes` (`nome`, `email`, `perfil`, `endereco`) VALUES
('João Silva', 'joao.silva@email.com', 'padrão', 'Rua do Beco Diagonal, 93'), 
('Maria Oliveira', 'maria.oliveira@email.com', 'vip', 'Avenida Privet Drive, 4'),
('Carlos Pereira', 'carlos.p@email.com', 'padrão', 'Rua Grimmauld Place, 12'), 
('Ana Costa', 'ana.costa@email.com', 'padrão', 'Travessa Godrics Hollow, 157'),
('Pedro Martins', 'pedro.m@email.com', 'vip', 'Alameda Hogsmeade, 234'), 
('Sandra Ferreira', 'sandra.f@email.com', 'padrão', 'Rua Knockturn Alley, 66'),
('Lucas Gomes', 'lucas.g@email.com', 'padrão', 'Avenida Spinners End, 89'), 
('Juliana Rodrigues', 'juliana.r@email.com', 'padrão', 'Rua Little Whinging, 321'),
('Gabriel Almeida', 'gabriel.a@email.com', 'vip', 'Travessa Ottery St. Catchpole, 45'), 
('Beatriz Barbosa', 'beatriz.b@email.com', 'padrão', 'Rua Shell Cottage, 178'),
('Marcos Souza', 'marcos.s@email.com', 'padrão', 'Alameda Diagon Alley, 412'), 
('Fernanda Lima', 'fernanda.l@email.com', 'padrão', 'Avenida Flourish and Blotts, 73'),
('Rafael Nunes', 'rafael.n@email.com', 'padrão', 'Rua Olivanders, 298'), 
('Camila Santos', 'camila.s@email.com', 'vip', 'Travessa Gringotts, 156'),
('Tiago Mendes', 'tiago.m@email.com', 'padrão', 'Rua Leaky Cauldron, 507'), 
('Larissa Castro', 'larissa.c@email.com', 'padrão', 'Alameda Madam Malkins, 84'),
('Bruno Ribeiro', 'bruno.r@email.com', 'padrão', 'Avenida Quality Quidditch, 129'), 
('Patrícia Rocha', 'patricia.r@email.com', 'padrão', 'Rua Weasleys Wizard Wheezes, 365'),
('Felipe Jesus', 'felipe.j@email.com', 'padrão', 'Travessa Borgin and Burkes, 241'), 
('Amanda Dias', 'amanda.d@email.com', 'vip', 'Rua Three Broomsticks, 192');

-- Categorias (3 registros)
INSERT INTO `categorias` (`nome`) VALUES
('Eletrônicos'),
('Eletrodomésticos'),
('Informática');

-- Produtos
-- Lojista 1 (TechCell Express) - ID 1: 3 celulares + 2 informática
INSERT INTO `produtos` (`nome`, `preco`, `estoque`, `lojista_id`, `descricao`) VALUES
('Galaxy S24 Ultra 256GB', 4899.90, 25, 1, 'Smartphone premium com câmera de 200MP e S Pen integrada'),
('iPhone 15 Pro Max 512GB', 8999.00, 18, 1, 'iPhone mais avançado com chip A17 Pro e titânio'),
('Xiaomi 14 Pro 256GB', 3299.90, 40, 1, 'Smartphone com Snapdragon 8 Gen 3 e câmera Leica'),
('MacBook Air M3 16GB', 12999.00, 15, 1, 'Notebook ultraportátil com chip M3 e tela Liquid Retina'),
('Desktop Gamer RTX 4080', 8499.90, 8, 1, 'PC Gamer completo com RTX 4080 e Ryzen 7 7800X3D');

-- Lojista 2 (Casa & Eletro Premium) - ID 2: 2 celulares similares + 4 produtos aleatórios
INSERT INTO `produtos` (`nome`, `preco`, `estoque`, `lojista_id`, `descricao`) VALUES
('Galaxy S24 Ultra 512GB', 5499.90, 20, 2, 'Versão premium do Galaxy S24 Ultra com mais armazenamento'),
('iPhone 15 Pro 256GB', 7999.00, 22, 2, 'iPhone 15 Pro com tecnologia Pro avançada'),
('Geladeira Side by Side 540L', 4299.00, 12, 2, 'Geladeira com freezer lateral e dispenser de água'),
('Lava e Seca 12kg Inverter', 3899.90, 10, 2, 'Lava e seca com tecnologia inverter e 15 programas'),
('Micro-ondas 32L Inox', 899.90, 35, 2, 'Micro-ondas com grill e painel digital touch'),
('Purificador de Ar HEPA', 1299.90, 25, 2, 'Purificador com filtro HEPA e ionizador');

-- Lojista 3 (InfoWorld Solutions) - ID 3: 2 celulares similares + 4 produtos aleatórios
INSERT INTO `produtos` (`nome`, `preco`, `estoque`, `lojista_id`, `descricao`) VALUES
('Galaxy S24+ 256GB', 4299.90, 30, 3, 'Galaxy S24 Plus com tela de 6.7 polegadas e câmera avançada'),
('Xiaomi 14 Ultra 512GB', 4199.90, 28, 3, 'Xiaomi 14 Ultra com câmera profissional Leica'),
('Monitor Gamer 27" 240Hz', 2499.90, 20, 3, 'Monitor QHD com alta taxa de atualização para gamers'),
('Headset Gamer Wireless', 899.90, 45, 3, 'Headset sem fio com som surround 7.1 e RGB'),
('Teclado Mecânico RGB', 599.90, 60, 3, 'Teclado mecânico com switches Cherry MX e iluminação RGB'),
('Mouse Gamer 16000 DPI', 399.90, 80, 3, 'Mouse para jogos com sensor óptico de alta precisão');

-- Produtos_Categorias
INSERT INTO `produtos_categorias` (`produto_id`, `categoria_id`) VALUES
-- Produtos do Lojista 1
(1, 1), -- Galaxy S24 Ultra -> Eletrônicos
(2, 1), -- iPhone 15 Pro Max -> Eletrônicos  
(3, 1), -- Xiaomi 14 Pro -> Eletrônicos
(4, 3), -- MacBook Air -> Informática
(5, 3), -- Desktop Gamer -> Informática
-- Produtos do Lojista 2
(6, 1), -- Galaxy S24 Ultra 512GB -> Eletrônicos
(7, 1), -- iPhone 15 Pro -> Eletrônicos
(8, 2), -- Geladeira -> Eletrodomésticos
(9, 2), -- Lava e Seca -> Eletrodomésticos
(10, 2), -- Micro-ondas -> Eletrodomésticos
(11, 2), -- Purificador -> Eletrodomésticos
-- Produtos do Lojista 3
(12, 1), -- Galaxy S24+ -> Eletrônicos
(13, 1), -- Xiaomi 14 Ultra -> Eletrônicos
(14, 3), -- Monitor Gamer -> Informática
(15, 3), -- Headset Gamer -> Informática
(16, 3), -- Teclado Mecânico -> Informática
(17, 3); -- Mouse Gamer -> Informática

-- Pedidos com status "Entregue" para todos os produtos
-- Produto 1: Galaxy S24 Ultra 256GB
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(1, '2024-12-01 14:30:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(1, 1, 1, 4899.90);

-- Produto 2: iPhone 15 Pro Max 512GB
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(2, '2024-12-02 10:15:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(2, 2, 1, 8999.00);

-- Produto 3: Xiaomi 14 Pro 256GB
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(3, '2024-12-03 16:45:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(3, 3, 1, 3299.90);

-- Produto 4: MacBook Air M3 16GB
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(4, '2024-12-04 09:20:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(4, 4, 1, 12999.00);

-- Produto 5: Desktop Gamer RTX 4080
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(5, '2024-12-05 13:10:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(5, 5, 1, 8499.90);

-- Produto 6: Galaxy S24 Ultra 512GB
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(6, '2024-12-06 11:00:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(6, 6, 1, 5499.90);

-- Produto 7: iPhone 15 Pro 256GB
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(7, '2024-12-07 15:30:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(7, 7, 1, 7999.00);

-- Produto 8: Geladeira Side by Side 540L
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(8, '2024-12-08 08:45:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(8, 8, 1, 4299.00);

-- Produto 9: Lava e Seca 12kg Inverter
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(9, '2024-12-09 17:20:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(9, 9, 1, 3899.90);

-- Produto 10: Micro-ondas 32L Inox
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(10, '2024-12-10 12:15:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(10, 10, 1, 899.90);

-- Produto 11: Purificador de Ar HEPA
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(11, '2024-12-11 14:50:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(11, 11, 1, 1299.90);

-- Produto 12: Galaxy S24+ 256GB
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(12, '2024-12-12 10:30:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(12, 12, 1, 4299.90);

-- Produto 13: Xiaomi 14 Ultra 512GB
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(13, '2024-12-13 16:00:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(13, 13, 1, 4199.90);

-- Produto 14: Monitor Gamer 27" 240Hz
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(14, '2024-12-14 09:40:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(14, 14, 1, 2499.90);

-- Produto 15: Headset Gamer Wireless
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(15, '2024-12-15 13:25:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(15, 15, 1, 899.90);

-- Produto 16: Teclado Mecânico RGB
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(16, '2024-12-16 11:10:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(16, 16, 1, 599.90);

-- Produto 17: Mouse Gamer 16000 DPI
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(17, '2024-12-17 15:55:00', 'Entregue');
INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(17, 17, 1, 399.90);

-- 10 pedidos adicionais com status variados
INSERT INTO `pedidos` (`cliente_id`, `data`, `status`) VALUES
(18, '2024-12-18 09:30:00', 'Processando'),
(19, '2024-12-18 14:20:00', 'Enviado'),
(20, '2024-12-19 10:15:00', 'Cancelado'),
(1, '2024-12-19 16:40:00', 'Processando'),
(2, '2024-12-20 08:25:00', 'Enviado'),
(3, '2024-12-20 13:50:00', 'Processando'),
(4, '2024-12-21 11:30:00', 'Enviado'),
(5, '2024-12-21 17:10:00', 'Cancelado'),
(6, '2024-12-22 09:45:00', 'Processando'),
(7, '2024-12-22 14:35:00', 'Enviado');

INSERT INTO `itens_pedidos` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(18, 3, 1, 3299.90),
(19, 6, 1, 5499.90),
(20, 14, 1, 2499.90),
(21, 7, 1, 7999.00),
(22, 11, 1, 1299.90),
(23, 16, 2, 599.90),
(24, 8, 1, 4299.00),
(25, 13, 1, 4199.90),
(26, 15, 1, 899.90),
(27, 9, 1, 3899.90);

-- Transações para todos os pedidos realizados
INSERT INTO `transacoes` (`lojista_id`, `valor`, `tipo`, `status`, `data`) VALUES
(1, 4899.90, 'Venda', 'Sacado', '2024-12-01 14:35:00'),
(1, 8999.00, 'Venda', 'Sacado', '2024-12-02 10:20:00'),
(1, 3299.90, 'Venda', 'Sacado', '2024-12-03 16:50:00'),
(1, 12999.00, 'Venda', 'Sacado', '2024-12-04 09:25:00'),
(1, 8499.90, 'Venda', 'Sacado', '2024-12-05 13:15:00'),
(2, 5499.90, 'Venda', 'Sacado', '2024-12-06 11:05:00'),
(2, 7999.00, 'Venda', 'Sacado', '2024-12-07 15:35:00'),
(2, 4299.00, 'Venda', 'Sacado', '2024-12-08 08:50:00'),
(2, 3899.90, 'Venda', 'Sacado', '2024-12-09 17:25:00'),
(2, 899.90, 'Venda', 'Disponível', '2024-12-10 12:20:00'),
(2, 1299.90, 'Venda', 'Disponível', '2024-12-11 14:55:00'),
(3, 4299.90, 'Venda', 'Disponível', '2024-12-12 10:35:00'),
(3, 4199.90, 'Venda', 'Disponível', '2024-12-13 16:05:00'),
(3, 2499.90, 'Venda', 'Disponível', '2024-12-14 09:45:00'),
(3, 899.90, 'Venda', 'Disponível', '2024-12-15 13:30:00'),
(3, 599.90, 'Venda', 'Disponível', '2024-12-16 11:15:00'),
(3, 399.90, 'Venda', 'Disponível', '2024-12-17 16:00:00'),
(1, 3299.90, 'Venda', 'Disponível', '2024-12-18 09:35:00'),
(2, 5499.90, 'Venda', 'Indisponível', '2024-12-18 14:25:00'),
(3, 2499.90, 'Venda', 'Indisponível', '2024-12-19 10:20:00'),
(2, 7999.00, 'Venda', 'Indisponível', '2024-12-19 16:45:00'),
(2, 1299.90, 'Venda', 'Indisponível', '2024-12-20 08:30:00'),
(3, 1199.80, 'Venda', 'Indisponível', '2024-12-20 13:55:00'),
(2, 4299.00, 'Venda', 'Indisponível', '2024-12-21 11:35:00'),
(3, 4199.90, 'Venda', 'Indisponível', '2024-12-21 17:15:00'),
(3, 899.90, 'Venda', 'Indisponível', '2024-12-22 09:50:00'),
(2, 3899.90, 'Venda', 'Indisponível', '2024-12-22 14:40:00');

-- Avaliações para produtos entregues
-- Lojista 1 (TechCell Express) - Avaliações baixas (1-2)
INSERT INTO `avaliacoes` (`cliente_id`, `produto_id`, `nota`, `comentario`, `data`) VALUES
(1, 1, 2, 'Produto chegou com arranhões e a bateria não dura nem meio dia. Muito decepcionante.', '2024-12-03 14:30:00'),
(2, 2, 1, 'Péssima experiência! O celular travou no primeiro dia e o vendedor não responde.', '2024-12-04 10:15:00'),
(3, 3, 2, 'Qualidade muito abaixo do esperado. A câmera não funciona direito e esquenta demais.', '2024-12-05 16:45:00'),
(4, 4, 1, 'Notebook veio com defeito na tela e demora muito para ligar. Não recomendo.', '2024-12-06 09:20:00'),
(5, 5, 2, 'PC gamer que não roda nem jogos básicos. Propaganda enganosa total.', '2024-12-07 13:10:00');

-- Lojista 2 (Casa & Eletro Premium) - Avaliações altas (4-5)
INSERT INTO `avaliacoes` (`cliente_id`, `produto_id`, `nota`, `comentario`, `data`) VALUES
(6, 6, 5, 'Produto incrível! Superou todas as expectativas, funciona perfeitamente.', '2024-12-08 11:00:00'),
(7, 7, 4, 'Muito bom! Chegou rapidinho e exatamente como descrito. Recomendo.', '2024-12-09 15:30:00'),
(8, 8, 5, 'Geladeira excelente! Silenciosa e muito espaçosa. Atendimento nota 10.', '2024-12-10 08:45:00'),
(9, 9, 4, 'Ótima máquina! Lava e seca muito bem, programas variados. Estou satisfeito.', '2024-12-11 17:20:00'),
(10, 10, 5, 'Micro-ondas fantástico! Funcionalidades excelentes e design bonito.', '2024-12-12 12:15:00'),
(11, 11, 4, 'Purificador muito bom! Já notei diferença na qualidade do ar em casa.', '2024-12-13 14:50:00');

-- Lojista 3 (InfoWorld Solutions) - Avaliações altas (4-5)
INSERT INTO `avaliacoes` (`cliente_id`, `produto_id`, `nota`, `comentario`, `data`) VALUES
(12, 12, 4, 'Ótimo celular! Câmera incrível e performance excelente. Recomendo muito.', '2024-12-14 10:30:00'),
(13, 13, 5, 'Smartphone perfeito! Todas as funcionalidades funcionam perfeitamente.', '2024-12-15 16:00:00'),
(14, 14, 5, 'Monitor sensacional para jogos! Cores vibrantes e sem delay. Adorei.', '2024-12-16 09:40:00'),
(15, 15, 4, 'Headset muito bom! Som claro e confortável para longas sessões de jogo.', '2024-12-17 13:25:00'),
(16, 16, 5, 'Teclado excelente! Teclas responsivas e iluminação linda. Vale cada centavo.', '2024-12-18 11:10:00'),
(17, 17, 4, 'Mouse preciso e confortável! Perfeito para jogos competitivos.', '2024-12-19 15:55:00');

-- Reclamações apenas para produtos do Lojista 1
INSERT INTO `reclamacoes` (`pedido_id`, `produto_id`, `titulo`, `texto`, `data`) VALUES
(1, 1, 'Produto com defeito de fábrica', 'O aparelho chegou com a tela trincada e arranhões na carcaça. Inaceitável pelo preço pago.', '2024-12-02 14:30:00'),
(2, 2, 'Produto não funciona corretamente', 'O celular trava constantemente e não consegue nem fazer ligações direito. Quero meu dinheiro de volta.', '2024-12-03 10:15:00'),
(3, 3, 'Qualidade inferior ao anunciado', 'A câmera não funciona e o aparelho esquenta muito. Nada do que foi prometido na descrição.', '2024-12-04 16:45:00'),
(4, 4, 'Notebook com problemas graves', 'Tela com defeito, demora para ligar e trava durante o uso. Produto de péssima qualidade.', '2024-12-05 09:20:00'),
(5, 5, 'PC gamer não roda jogos', 'Propaganda enganosa! O computador não consegue rodar nem jogos básicos. Performance ridícula.', '2024-12-06 13:10:00');

-- Preços para todos os produtos criados
INSERT INTO `precos` (`produto_id`, `valor`, `tipo_preco`, `data_inicio_vigencia`, `ativo`) VALUES
(1, 4899.90, 'Base', '2024-11-01', TRUE),
(2, 8999.00, 'Base', '2024-11-01', TRUE),
(3, 3299.90, 'Base', '2024-11-01', TRUE),
(4, 12999.00, 'Base', '2024-11-01', TRUE),
(5, 8499.90, 'Base', '2024-11-01', TRUE),
(6, 5499.90, 'Base', '2024-11-01', TRUE),
(7, 7999.00, 'Base', '2024-11-01', TRUE),
(8, 4299.00, 'Base', '2024-11-01', TRUE),
(9, 3899.90, 'Base', '2024-11-01', TRUE),
(10, 899.90, 'Base', '2024-11-01', TRUE),
(11, 1299.90, 'Base', '2024-11-01', TRUE),
(12, 4299.90, 'Base', '2024-11-01', TRUE),
(13, 4199.90, 'Base', '2024-11-01', TRUE),
(14, 2499.90, 'Base', '2024-11-01', TRUE),
(15, 899.90, 'Base', '2024-11-01', TRUE),
(16, 599.90, 'Base', '2024-11-01', TRUE),
(17, 399.90, 'Base', '2024-11-01', TRUE);