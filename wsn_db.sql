SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


-- -----------------------------------------------------
-- Table `wsn_db`.`transacoes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`transacoes` (
  `id_transacoes` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da transação no banco de dados.' ,
  `nome` VARCHAR(30) NOT NULL COMMENT 'Nome da transação.' ,
  `descricao` VARCHAR(100) NULL COMMENT 'Descrição da transação.' ,
  `url` VARCHAR(200) NULL COMMENT 'URL associada à transação.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_transacoes`) )
ENGINE = InnoDB
COMMENT = 'Transações do sistema para as ações do usuário.';


-- -----------------------------------------------------
-- Table `wsn_db`.`perfis`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`perfis` (
  `id_perfis` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial do perfil no banco de dados.' ,
  `nome` VARCHAR(30) NOT NULL COMMENT 'Nome do perfil.' ,
  `descricao` VARCHAR(100) NULL COMMENT 'Descrição do perfil.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_perfis`) )
ENGINE = InnoDB
COMMENT = 'Perfis (papeis) dos usuários no sistema.';


-- -----------------------------------------------------
-- Table `wsn_db`.`usuarios`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`usuarios` (
  `id_usuarios` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial do usuário no banco de dados.' ,
  `perfis_id` INT NOT NULL COMMENT 'Número sequencial do perfil no banco de dados.' ,
  `nome` VARCHAR(100) NULL COMMENT 'Nome do usuário.' ,
  `senha` VARCHAR(10) NULL COMMENT 'Senha do usuário.' ,
  `email` VARCHAR(100) NULL COMMENT 'Email do usuário.' ,
  `cargo` VARCHAR(30) NULL COMMENT 'Cargo do usuário: administrador ou vendedor' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Cargo do usuário: administrador ou vendedor' ,
  PRIMARY KEY (`id_usuarios`) ,
  INDEX `fk_usuarios_perfis1` (`perfis_id` ASC) ,
  CONSTRAINT `fk_usuarios_perfis1`
    FOREIGN KEY (`perfis_id` )
    REFERENCES `wsn_db`.`perfis` (`id_perfis` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Usuários com acesso às funcionalidades do sistema. \n';


-- -----------------------------------------------------
-- Table `wsn_db`.`clientes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`clientes` (
  `id_clientes` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial do cliente no banco de dados.' ,
  `cnpj` VARCHAR(20) NULL COMMENT 'CNPJ do cliente.' ,
  `inscricao_estadual` VARCHAR(45) NULL COMMENT 'Inscrição estadual do cliente.' ,
  `razao_social` VARCHAR(200) NULL COMMENT 'Razão social do cliente.' ,
  `nome_fantasia` VARCHAR(200) NULL COMMENT 'Nome fantasia do cliente.' ,
  `situacao` VARCHAR(1) NULL COMMENT 'Situação do cliente: Ativo ou Inativo' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_clientes`) )
ENGINE = InnoDB
COMMENT = 'Clientes que podem fazer pedidos de produtos.';


-- -----------------------------------------------------
-- Table `wsn_db`.`produtos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`produtos` (
  `id_produtos` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial do produto no banco de dados.' ,
  `nome` VARCHAR(100) NULL COMMENT 'Nome do produto.' ,
  `imagem` VARCHAR(100) NULL COMMENT 'Endereço da imagem do produto no servidor.' ,
  `preco_atual` DECIMAL NULL COMMENT 'Preço atual do produto, atualizado a cada remessa.' ,
  `estoque_critico` INT NULL COMMENT 'Estoque mínimo a ser considerado para emissão de novos pedidos.' ,
  `estoque_virtual` INT NULL COMMENT 'Estoque virtual considerando os pedidos realizados pelos clientes.' ,
  `estoque_fisico` INT NULL COMMENT 'Estoque considerando a retirada de produtos no estoque da empresa.' ,
  `peso` DECIMAL NULL COMMENT 'Peso do produto.' ,
  `qtd_caixa` INT NULL COMMENT 'Quantidade de unidades do produto por caixa.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_produtos`) )
ENGINE = InnoDB
COMMENT = 'Produtos tratados pelo Sistema.';


-- -----------------------------------------------------
-- Table `wsn_db`.`uf`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`uf` (
  `id_uf` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da UF no banco de dados.' ,
  `sigla` VARCHAR(2) NOT NULL COMMENT 'Sigla da UF' ,
  `nome` VARCHAR(20) NOT NULL COMMENT 'Nome da UF' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_uf`) )
ENGINE = InnoDB
COMMENT = 'Lista de UF do Brasil.';


-- -----------------------------------------------------
-- Table `wsn_db`.`cidades`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`cidades` (
  `id_cidades` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da cidade no banco de dados.' ,
  `uf_id` INT NOT NULL COMMENT 'Número sequencial da UF no banco de dados.' ,
  `nome` VARCHAR(50) NOT NULL COMMENT 'Nome da cidade.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_cidades`) ,
  INDEX `fk_cidades_uf1` (`uf_id` ASC) ,
  CONSTRAINT `fk_cidades_uf1`
    FOREIGN KEY (`uf_id` )
    REFERENCES `wsn_db`.`uf` (`id_uf` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Cidades do Brasil.';


-- -----------------------------------------------------
-- Table `wsn_db`.`perfis_transacoes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`perfis_transacoes` (
  `transacoes_id` INT NOT NULL COMMENT 'Número sequencial da transação no banco de dados.' ,
  `perfis_id` INT NOT NULL COMMENT 'Número sequencial do perfil no banco de dados.' ,
  `dt_inclusao` TIMESTAMP NOT NULL COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`transacoes_id`, `perfis_id`) ,
  INDEX `fk_transacoes_has_perfis_perfis1` (`perfis_id` ASC) ,
  INDEX `fk_transacoes_has_perfis_transacoes1` (`transacoes_id` ASC) ,
  CONSTRAINT `fk_transacoes_has_perfis_transacoes1`
    FOREIGN KEY (`transacoes_id` )
    REFERENCES `wsn_db`.`transacoes` (`id_transacoes` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transacoes_has_perfis_perfis1`
    FOREIGN KEY (`perfis_id` )
    REFERENCES `wsn_db`.`perfis` (`id_perfis` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Relação entre perfis e transações. Indica quais perfis possu' /* comment truncated */;


-- -----------------------------------------------------
-- Table `wsn_db`.`bairros`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`bairros` (
  `id_bairros` INT NOT NULL ,
  `cidades_id` INT NOT NULL COMMENT 'Número sequencial da cidade no banco de dados.' ,
  `nome` VARCHAR(50) NULL ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_bairros`) ,
  INDEX `fk_bairros_cidades1` (`cidades_id` ASC) ,
  CONSTRAINT `fk_bairros_cidades1`
    FOREIGN KEY (`cidades_id` )
    REFERENCES `wsn_db`.`cidades` (`id_cidades` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wsn_db`.`enderecos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`enderecos` (
  `id_enderecos` INT NOT NULL AUTO_INCREMENT COMMENT ' Número sequencial do endereço no banco de dados.' ,
  `clientes_id` INT NOT NULL COMMENT 'Número sequencial do cliente no banco de dados.' ,
  `bairros_id` INT NOT NULL ,
  `tp_logradouro` VARCHAR(20) NULL COMMENT 'Tipo de logradouro. Ex: Avenida, Rua, Travessa etc.' ,
  `logradouro` VARCHAR(60) NULL COMMENT 'Nome do logradouro.' ,
  `numero` VARCHAR(10) NULL COMMENT 'Número no logradouro.' ,
  `complemento` VARCHAR(50) NULL COMMENT 'Complemento do endereço.' ,
  `cep` VARCHAR(9) NULL COMMENT 'Código de Endereçamento Postal.' ,
  `latitude` VARCHAR(100) NULL COMMENT 'Latitude do endereço.' ,
  `longitude` VARCHAR(100) NULL COMMENT 'Longitude do endereço.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_enderecos`, `clientes_id`) ,
  INDEX `fk_enderecos_clientes1` (`clientes_id` ASC) ,
  INDEX `fk_enderecos_bairros1` (`bairros_id` ASC) ,
  CONSTRAINT `fk_enderecos_clientes1`
    FOREIGN KEY (`clientes_id` )
    REFERENCES `wsn_db`.`clientes` (`id_clientes` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enderecos_bairros1`
    FOREIGN KEY (`bairros_id` )
    REFERENCES `wsn_db`.`bairros` (`id_bairros` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Endereços de lojas';


-- -----------------------------------------------------
-- Table `wsn_db`.`situacoes_pedido`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`situacoes_pedido` (
  `id_situacoes_pedido` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da situação do pedido no banco de dados.' ,
  `nome` VARCHAR(30) NULL COMMENT 'Nome da situação do pedido.' ,
  `descricao` VARCHAR(100) NULL COMMENT 'Descrição da situação do pedido.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_situacoes_pedido`) )
ENGINE = InnoDB
COMMENT = 'Situações que o pedido pode assumir:\n1 - Não emitido\n2 - Emi' /* comment truncated */;


-- -----------------------------------------------------
-- Table `wsn_db`.`formas_pagto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`formas_pagto` (
  `id_formas_pagto` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da forma de pagamento no banco de dados.' ,
  `nome` VARCHAR(30) NULL COMMENT 'Nome da forma de pagamento.' ,
  `descricao` VARCHAR(100) NULL COMMENT 'Descrição da forma de pagamento.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualizaçao do registro no banco de dados.' ,
  PRIMARY KEY (`id_formas_pagto`) )
ENGINE = InnoDB
COMMENT = 'Formas de pagamento do pedido.';


-- -----------------------------------------------------
-- Table `wsn_db`.`tp_pedidos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`tp_pedidos` (
  `id_tp_pedidos` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial do tipo de pedidos no banco de dados.' ,
  `nome` VARCHAR(30) NULL COMMENT 'Nome do tipo de pedidos.' ,
  `descricao` VARCHAR(100) NULL COMMENT 'Descrição do tipo de pedidos.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_tp_pedidos`) )
ENGINE = InnoDB
COMMENT = 'Tipos de pedidos:\n1 - Venda\n2 - Consignado\n3 - Bonificação\n4' /* comment truncated */;


-- -----------------------------------------------------
-- Table `wsn_db`.`pedidos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`pedidos` (
  `id_pedidos` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial do pedido no banco de dados.' ,
  `situacoes_pedido_id` INT NOT NULL COMMENT 'Número sequencial da situação do pedido no banco de dados.' ,
  `formas_pagto_id` INT NOT NULL COMMENT 'Número sequencial da forma de pagamento no banco de dados.' ,
  `clientes_id` INT NOT NULL COMMENT 'Número sequencial do cliente no banco de dados.' ,
  `usuarios_id` INT NOT NULL COMMENT 'Número sequencial do vendedor no banco de dados.' ,
  `tp_pedidos_id` INT NOT NULL ,
  `perc_desconto` DECIMAL NULL COMMENT 'Percentual de desconto concedido ao pedido.' ,
  `in_nf` VARCHAR(1) NULL COMMENT 'Indicador de emissão de Nota Fiscal.' ,
  `dt_situacao_atual` TIMESTAMP NULL COMMENT 'Data da situação atual do pedido.' ,
  `vl_total` DECIMAL NULL COMMENT 'Valor total do pedido. Derivado a partir do preço e da quantidade de cada produto no pedido.' ,
  `vl_liquido` DECIMAL NULL COMMENT 'Valor total do pedido considerando descontos.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_pedidos`) ,
  INDEX `fk_pedidos_tp_situacoes_pedido1` (`situacoes_pedido_id` ASC) ,
  INDEX `fk_pedidos_tp_formas_pagto1` (`formas_pagto_id` ASC) ,
  INDEX `fk_pedidos_clientes1` (`clientes_id` ASC) ,
  INDEX `fk_pedidos_usuarios1` (`usuarios_id` ASC) ,
  INDEX `fk_pedidos_tp_pedidos1` (`tp_pedidos_id` ASC) ,
  CONSTRAINT `fk_pedidos_tp_situacoes_pedido1`
    FOREIGN KEY (`situacoes_pedido_id` )
    REFERENCES `wsn_db`.`situacoes_pedido` (`id_situacoes_pedido` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_tp_formas_pagto1`
    FOREIGN KEY (`formas_pagto_id` )
    REFERENCES `wsn_db`.`formas_pagto` (`id_formas_pagto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`clientes_id` )
    REFERENCES `wsn_db`.`clientes` (`id_clientes` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_usuarios1`
    FOREIGN KEY (`usuarios_id` )
    REFERENCES `wsn_db`.`usuarios` (`id_usuarios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_tp_pedidos1`
    FOREIGN KEY (`tp_pedidos_id` )
    REFERENCES `wsn_db`.`tp_pedidos` (`id_tp_pedidos` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Pedidos realizados por clientes e emitidos para fábrica.';


-- -----------------------------------------------------
-- Table `wsn_db`.`produtos_pedidos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`produtos_pedidos` (
  `produtos_id` INT NOT NULL COMMENT 'Número sequencial do produto no banco de dados.' ,
  `pedidos_id` INT NOT NULL COMMENT 'Número sequencial do pedido no banco de dados.' ,
  `quant` INT NULL COMMENT 'Quantidade do produto no pedido.' ,
  `preco` DECIMAL NULL COMMENT 'Preço do produto no pedido.' ,
  `dt_inclusao` TIMESTAMP NOT NULL COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`produtos_id`, `pedidos_id`) ,
  INDEX `fk_produtos_has_pedidos_pedidos1` (`pedidos_id` ASC) ,
  INDEX `fk_produtos_has_pedidos_produtos1` (`produtos_id` ASC) ,
  CONSTRAINT `fk_produtos_has_pedidos_produtos1`
    FOREIGN KEY (`produtos_id` )
    REFERENCES `wsn_db`.`produtos` (`id_produtos` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produtos_has_pedidos_pedidos1`
    FOREIGN KEY (`pedidos_id` )
    REFERENCES `wsn_db`.`pedidos` (`id_pedidos` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Relação entre produtos e pedidos. Indica quais produtos estã' /* comment truncated */;


-- -----------------------------------------------------
-- Table `wsn_db`.`remessas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`remessas` (
  `id_remessas` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da remessa no banco de dados.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_remessas`) )
ENGINE = InnoDB
COMMENT = 'Remessas de produtos enviadas da fábrica.';


-- -----------------------------------------------------
-- Table `wsn_db`.`produtos_remessas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`produtos_remessas` (
  `produtos_id` INT NOT NULL COMMENT 'Número sequencial do produto no banco de dados.' ,
  `remessas_id` INT NOT NULL COMMENT 'Número sequencial da remessa no banco de dados.' ,
  `quant` INT NULL COMMENT 'Quantidade do produto na remessa.' ,
  `preco` DECIMAL NULL COMMENT 'Preço do produto na remessa.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`produtos_id`, `remessas_id`) ,
  INDEX `fk_produtos_has_remessas_remessas1` (`remessas_id` ASC) ,
  INDEX `fk_produtos_has_remessas_produtos1` (`produtos_id` ASC) ,
  CONSTRAINT `fk_produtos_has_remessas_produtos1`
    FOREIGN KEY (`produtos_id` )
    REFERENCES `wsn_db`.`produtos` (`id_produtos` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produtos_has_remessas_remessas1`
    FOREIGN KEY (`remessas_id` )
    REFERENCES `wsn_db`.`remessas` (`id_remessas` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Relação entre produtos e remessas. Indica quais produtos est' /* comment truncated */;


-- -----------------------------------------------------
-- Table `wsn_db`.`contatos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`contatos` (
  `id_contatos` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial do contato no banco de dados.' ,
  `clientes_id` INT NOT NULL COMMENT 'Número sequencial do cliente no banco de dados.' ,
  `nome` VARCHAR(45) NULL COMMENT 'Nome da pessoa de contato do cliente.' ,
  `telefone` VARCHAR(45) NULL COMMENT 'Telefone do contato.' ,
  `email` VARCHAR(45) NULL COMMENT 'e-mail do contato.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_contatos`, `clientes_id`) ,
  INDEX `fk_contatos_clientes1` (`clientes_id` ASC) ,
  CONSTRAINT `fk_contatos_clientes1`
    FOREIGN KEY (`clientes_id` )
    REFERENCES `wsn_db`.`clientes` (`id_clientes` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Pessoas e meios de contato do cliente.';


-- -----------------------------------------------------
-- Table `wsn_db`.`categorias`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`categorias` (
  `id_categorias` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da categoria no banco de dados.' ,
  `nome` VARCHAR(30) NULL COMMENT 'Nome da categoria.' ,
  `descricao` VARCHAR(100) NULL COMMENT 'Descrição da categoria.' ,
  `icone` VARCHAR(100) NULL COMMENT 'Endereço da imagem da categoria no servidor.' ,
  `limite_inferior` DECIMAL NULL COMMENT 'Limite inferior do volume de vendas da categoria.' ,
  `limite_superior` DECIMAL NULL COMMENT 'Limite superior do volume de vendas da categoria.' ,
  `qtd_dias` INT NULL COMMENT 'Intervalo de vendas considerado para aferir limites inferior e superior da categoria.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_categorias`) )
ENGINE = InnoDB
COMMENT = 'Categorias de clientes de acordo com o seu volume de compra.';


-- -----------------------------------------------------
-- Table `wsn_db`.`clientes_categorias`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`clientes_categorias` (
  `clientes_id` INT NOT NULL COMMENT 'Número sequencial do cliente no banco de dados.' ,
  `categorias_id` INT NOT NULL COMMENT 'Número sequencial da categoria no banco de dados.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`clientes_id`, `categorias_id`) ,
  INDEX `fk_clientes_has_categorias_categorias1` (`categorias_id` ASC) ,
  INDEX `fk_clientes_has_categorias_clientes1` (`clientes_id` ASC) ,
  CONSTRAINT `fk_clientes_has_categorias_clientes1`
    FOREIGN KEY (`clientes_id` )
    REFERENCES `wsn_db`.`clientes` (`id_clientes` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_has_categorias_categorias1`
    FOREIGN KEY (`categorias_id` )
    REFERENCES `wsn_db`.`categorias` (`id_categorias` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Relação entre categorias e clientes. Indica quais clientes e' /* comment truncated */;


-- -----------------------------------------------------
-- Table `wsn_db`.`h_produtos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`h_produtos` (
  `id_h_produtos` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da tabela de histórico de produtos.' ,
  `produtos_id` INT NOT NULL COMMENT 'Número sequencial do produto no banco de dados.' ,
  `nome` VARCHAR(100) NULL COMMENT 'Nome do produto.' ,
  `imagem` VARCHAR(100) NULL COMMENT 'Endereço da imagem do produto no servidor.' ,
  `preco_atual` DECIMAL NULL COMMENT 'Preço atual do produto, atualizado a cada remessa.' ,
  `estoque_critico` INT NULL COMMENT 'Estoque mínimo a ser considerado para emissão de novos pedidos.' ,
  `estoque_virtual` INT NULL COMMENT 'Estoque virtual considerando os pedidos realizados pelos clientes.' ,
  `estoque_fisico` INT NULL COMMENT 'Estoque considerando a retirada de produtos no estoque da empresa.' ,
  `peso` DECIMAL NULL COMMENT 'Peso do produto.' ,
  `qtd_caixa` INT NULL COMMENT 'Quantidade de unidades do produto por caixa.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_h_produtos`) ,
  INDEX `fk_h_produtos_produtos1` (`produtos_id` ASC) ,
  CONSTRAINT `fk_h_produtos_produtos1`
    FOREIGN KEY (`produtos_id` )
    REFERENCES `wsn_db`.`produtos` (`id_produtos` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela de histórico de Produtos.';



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
