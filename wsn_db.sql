SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `wsn_db` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `wsn_db` ;

-- -----------------------------------------------------
-- Table `wsn_db`.`Transacao`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Transacao` (
  `id_transacao` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da transação no banco de dados.' ,
  `nome` VARCHAR(30) NOT NULL COMMENT 'Nome da transação.' ,
  `descricao` VARCHAR(100) NULL COMMENT 'Descrição da transação.' ,
  `url` VARCHAR(200) NULL COMMENT 'URL associada à transação.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_transacao`) )
ENGINE = InnoDB
COMMENT = 'Transações do sistema para as ações do usuário.';


-- -----------------------------------------------------
-- Table `wsn_db`.`Perfil`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Perfil` (
  `id_perfil` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial do perfil no banco de dados.' ,
  `nome` VARCHAR(30) NOT NULL COMMENT 'Nome do perfil.' ,
  `descricao` VARCHAR(100) NULL COMMENT 'Descrição do perfil.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_perfil`) )
ENGINE = InnoDB
COMMENT = 'Perfis (papeis) dos usuários no sistema.';


-- -----------------------------------------------------
-- Table `wsn_db`.`Usuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial do usuário no banco de dados.' ,
  `perfil_id` INT NOT NULL COMMENT 'Número sequencial do perfil no banco de dados.' ,
  `nome` VARCHAR(100) NULL COMMENT 'Nome do usuário.' ,
  `senha` VARCHAR(10) NULL COMMENT 'Senha do usuário.' ,
  `email` VARCHAR(100) NULL COMMENT 'Email do usuário.' ,
  `telefone` INT NULL COMMENT 'Telefone do usuário.' ,
  `cargo` VARCHAR(30) NULL COMMENT 'Cargo do usuário: administrador ou vendedor' ,
  `in_situacao` VARCHAR(1) NULL COMMENT 'Situação do Usuário: Ativo (S) ou Inativo (N)' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Cargo do usuário: administrador ou vendedor' ,
  PRIMARY KEY (`id_usuario`) ,
  INDEX `fk_usuarios_perfis1` (`perfil_id` ASC) ,
  CONSTRAINT `fk_usuarios_perfis1`
    FOREIGN KEY (`perfil_id` )
    REFERENCES `wsn_db`.`Perfil` (`id_perfil` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Usuários com acesso às funcionalidades do sistema. \n';


-- -----------------------------------------------------
-- Table `wsn_db`.`Cliente`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial do cliente no banco de dados.' ,
  `cnpj` VARCHAR(20) NULL COMMENT 'CNPJ do cliente.' ,
  `inscricao_estadual` VARCHAR(45) NULL COMMENT 'Inscrição estadual do cliente.' ,
  `razao_social` VARCHAR(200) NULL COMMENT 'Razão social do cliente.' ,
  `nome_fantasia` VARCHAR(200) NULL COMMENT 'Nome fantasia do cliente.' ,
  `in_situacao` VARCHAR(1) NULL COMMENT 'Situação do cliente: Ativo (S) ou Inativo (N)' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_cliente`) )
ENGINE = InnoDB
COMMENT = 'Clientes que podem fazer pedidos de produtos.';


-- -----------------------------------------------------
-- Table `wsn_db`.`Produto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Produto` (
  `id_produto` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial do produto no banco de dados.' ,
  `nome` VARCHAR(100) NULL COMMENT 'Nome do produto.' ,
  `imagem` VARCHAR(100) NULL COMMENT 'Endereço da imagem do produto no servidor.' ,
  `preco_atual` DECIMAL NULL COMMENT 'Preço atual do produto, atualizado a cada remessa.' ,
  `estoque_critico` INT NULL COMMENT 'Estoque mínimo a ser considerado para emissão de novos pedidos.' ,
  `estoque_virtual` INT NULL COMMENT 'Estoque virtual considerando os pedidos realizados pelos clientes.' ,
  `estoque_fisico` INT NULL COMMENT 'Estoque considerando a retirada de produtos no estoque da empresa.' ,
  `peso` DECIMAL NULL COMMENT 'Peso do produto.' ,
  `qtd_caixa` INT NULL COMMENT 'Quantidade de unidades do produto por caixa.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_produto`) )
ENGINE = InnoDB
COMMENT = 'Produtos tratados pelo Sistema.';


-- -----------------------------------------------------
-- Table `wsn_db`.`Uf`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Uf` (
  `id_uf` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da UF no banco de dados.' ,
  `sigla` VARCHAR(2) NOT NULL COMMENT 'Sigla da UF' ,
  `nome` VARCHAR(20) NOT NULL COMMENT 'Nome da UF' ,
  `in_habilitacao` VARCHAR(1) NULL ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Indica se o registro está habilitado para uso no sistema: Habilitado (S) ou Não habilitado (N)' ,
  PRIMARY KEY (`id_uf`) )
ENGINE = InnoDB
COMMENT = 'Lista de UF do Brasil.';


-- -----------------------------------------------------
-- Table `wsn_db`.`Cidade`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Cidade` (
  `id_cidade` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da cidade no banco de dados.' ,
  `uf_id` INT NOT NULL ,
  `nome` VARCHAR(50) NOT NULL COMMENT 'Nome da cidade.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `in_habilitacao` VARCHAR(1) NULL COMMENT 'Indica se o registro está habilitado para uso no sistema: Habilitado (S) ou Não habilitado (N)' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_cidade`, `uf_id`) ,
  INDEX `fk_cidades_uf1` (`uf_id` ASC) ,
  CONSTRAINT `fk_cidades_uf1`
    FOREIGN KEY (`uf_id` )
    REFERENCES `wsn_db`.`Uf` (`id_uf` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Cidades do Brasil.';


-- -----------------------------------------------------
-- Table `wsn_db`.`Perfil_Transacao`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Perfil_Transacao` (
  `transacao_id` INT NOT NULL COMMENT 'Número sequencial da transação no banco de dados.' ,
  `perfil_id` INT NOT NULL COMMENT 'Número sequencial do perfil no banco de dados.' ,
  `dt_inclusao` TIMESTAMP NOT NULL COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`transacao_id`, `perfil_id`) ,
  INDEX `fk_transacoes_has_perfis_perfis1` (`perfil_id` ASC) ,
  INDEX `fk_transacoes_has_perfis_transacoes1` (`transacao_id` ASC) ,
  CONSTRAINT `fk_transacoes_has_perfis_transacoes1`
    FOREIGN KEY (`transacao_id` )
    REFERENCES `wsn_db`.`Transacao` (`id_transacao` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transacoes_has_perfis_perfis1`
    FOREIGN KEY (`perfil_id` )
    REFERENCES `wsn_db`.`Perfil` (`id_perfil` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Relação entre perfis e transações. Indica quais perfis possu' /* comment truncated */;


-- -----------------------------------------------------
-- Table `wsn_db`.`Bairro`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Bairro` (
  `id_bairro` INT NOT NULL ,
  `cidade_id` INT NOT NULL ,
  `cidade_uf_id` INT NOT NULL ,
  `nome` VARCHAR(50) NULL ,
  `in_habilitacao` VARCHAR(1) NULL COMMENT 'Indica se o registro está habilitado para uso no sistema: Habilitado (S) ou Não habilitado (N)' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_bairro`) ,
  INDEX `fk_bairros_cidades1` (`cidade_id` ASC, `cidade_uf_id` ASC) ,
  CONSTRAINT `fk_bairros_cidades1`
    FOREIGN KEY (`cidade_id` , `cidade_uf_id` )
    REFERENCES `wsn_db`.`Cidade` (`id_cidade` , `uf_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wsn_db`.`Endereco`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Endereco` (
  `id_enderecos` INT NOT NULL AUTO_INCREMENT COMMENT ' Número sequencial do endereço no banco de dados.' ,
  `cliente_id` INT NOT NULL COMMENT 'Número sequencial do cliente no banco de dados.' ,
  `bairro_id` INT NOT NULL ,
  `tp_logradouro` VARCHAR(20) NULL COMMENT 'Tipo de logradouro. Ex: Avenida, Rua, Travessa etc.' ,
  `logradouro` VARCHAR(60) NULL COMMENT 'Nome do logradouro.' ,
  `numero` VARCHAR(10) NULL COMMENT 'Número no logradouro.' ,
  `complemento` VARCHAR(50) NULL COMMENT 'Complemento do endereço.' ,
  `cep` VARCHAR(9) NULL COMMENT 'Código de Endereçamento Postal.' ,
  `latitude` VARCHAR(100) NULL COMMENT 'Latitude do endereço.' ,
  `longitude` VARCHAR(100) NULL COMMENT 'Longitude do endereço.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_enderecos`, `cliente_id`) ,
  INDEX `fk_enderecos_clientes1` (`cliente_id` ASC) ,
  INDEX `fk_enderecos_bairros1` (`bairro_id` ASC) ,
  CONSTRAINT `fk_enderecos_clientes1`
    FOREIGN KEY (`cliente_id` )
    REFERENCES `wsn_db`.`Cliente` (`id_cliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enderecos_bairros1`
    FOREIGN KEY (`bairro_id` )
    REFERENCES `wsn_db`.`Bairro` (`id_bairro` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Endereços de lojas';


-- -----------------------------------------------------
-- Table `wsn_db`.`Situacao_pedido`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Situacao_pedido` (
  `id_situacao_pedido` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da situação do pedido no banco de dados.' ,
  `nome` VARCHAR(30) NULL COMMENT 'Nome da situação do pedido.' ,
  `descricao` VARCHAR(100) NULL COMMENT 'Descrição da situação do pedido.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_situacao_pedido`) )
ENGINE = InnoDB
COMMENT = 'Situações que o pedido pode assumir:\n1 - Não emitido\n2 - Emi' /* comment truncated */;


-- -----------------------------------------------------
-- Table `wsn_db`.`Forma_Pagto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Forma_Pagto` (
  `id_forma_pagto` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da forma de pagamento no banco de dados.' ,
  `nome` VARCHAR(30) NULL COMMENT 'Nome da forma de pagamento.' ,
  `descricao` VARCHAR(100) NULL COMMENT 'Descrição da forma de pagamento.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualizaçao do registro no banco de dados.' ,
  PRIMARY KEY (`id_forma_pagto`) )
ENGINE = InnoDB
COMMENT = 'Formas de pagamento do pedido.';


-- -----------------------------------------------------
-- Table `wsn_db`.`Tp_Pedido`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Tp_Pedido` (
  `id_tp_pedido` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial do tipo de pedidos no banco de dados.' ,
  `nome` VARCHAR(30) NULL COMMENT 'Nome do tipo de pedidos.' ,
  `descricao` VARCHAR(100) NULL COMMENT 'Descrição do tipo de pedidos.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_tp_pedido`) )
ENGINE = InnoDB
COMMENT = 'Tipos de pedidos:\n1 - Venda\n2 - Consignado\n3 - Bonificação\n4' /* comment truncated */;


-- -----------------------------------------------------
-- Table `wsn_db`.`Pedido`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial do pedido no banco de dados.' ,
  `situacao_pedido_id` INT NOT NULL COMMENT 'Número sequencial da situação do pedido no banco de dados.' ,
  `forma_pagto_id` INT NOT NULL COMMENT 'Número sequencial da forma de pagamento no banco de dados.' ,
  `cliente_id` INT NOT NULL COMMENT 'Número sequencial do cliente no banco de dados.' ,
  `usuario_id` INT NOT NULL COMMENT 'Número sequencial do vendedor no banco de dados.' ,
  `tp_pedido_id` INT NOT NULL ,
  `perc_desconto` DECIMAL NULL COMMENT 'Percentual de desconto concedido ao pedido.' ,
  `in_nf` VARCHAR(1) NULL COMMENT 'Indicador de emissão de Nota Fiscal.' ,
  `dt_situacao_atual` TIMESTAMP NULL COMMENT 'Data da situação atual do pedido.' ,
  `vl_total` DECIMAL NULL COMMENT 'Valor total do pedido. Derivado a partir do preço e da quantidade de cada produto no pedido.' ,
  `vl_liquido` DECIMAL NULL COMMENT 'Valor total do pedido considerando descontos.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_pedido`) ,
  INDEX `fk_pedidos_tp_situacoes_pedido1` (`situacao_pedido_id` ASC) ,
  INDEX `fk_pedidos_tp_formas_pagto1` (`forma_pagto_id` ASC) ,
  INDEX `fk_pedidos_clientes1` (`cliente_id` ASC) ,
  INDEX `fk_pedidos_usuarios1` (`usuario_id` ASC) ,
  INDEX `fk_pedidos_tp_pedidos1` (`tp_pedido_id` ASC) ,
  CONSTRAINT `fk_pedidos_tp_situacoes_pedido1`
    FOREIGN KEY (`situacao_pedido_id` )
    REFERENCES `wsn_db`.`Situacao_pedido` (`id_situacao_pedido` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_tp_formas_pagto1`
    FOREIGN KEY (`forma_pagto_id` )
    REFERENCES `wsn_db`.`Forma_Pagto` (`id_forma_pagto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`cliente_id` )
    REFERENCES `wsn_db`.`Cliente` (`id_cliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_usuarios1`
    FOREIGN KEY (`usuario_id` )
    REFERENCES `wsn_db`.`Usuario` (`id_usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_tp_pedidos1`
    FOREIGN KEY (`tp_pedido_id` )
    REFERENCES `wsn_db`.`Tp_Pedido` (`id_tp_pedido` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Pedidos realizados por clientes e emitidos para fábrica.';


-- -----------------------------------------------------
-- Table `wsn_db`.`Produto_Pedido`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Produto_Pedido` (
  `produto_id` INT NOT NULL COMMENT 'Número sequencial do produto no banco de dados.' ,
  `pedido_id` INT NOT NULL COMMENT 'Número sequencial do pedido no banco de dados.' ,
  `quant` INT NULL COMMENT 'Quantidade do produto no pedido.' ,
  `preco` DECIMAL NULL COMMENT 'Preço do produto no pedido.' ,
  `dt_inclusao` TIMESTAMP NOT NULL COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`produto_id`, `pedido_id`) ,
  INDEX `fk_produtos_has_pedidos_pedidos1` (`pedido_id` ASC) ,
  INDEX `fk_produtos_has_pedidos_produtos1` (`produto_id` ASC) ,
  CONSTRAINT `fk_produtos_has_pedidos_produtos1`
    FOREIGN KEY (`produto_id` )
    REFERENCES `wsn_db`.`Produto` (`id_produto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produtos_has_pedidos_pedidos1`
    FOREIGN KEY (`pedido_id` )
    REFERENCES `wsn_db`.`Pedido` (`id_pedido` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Relação entre produtos e pedidos. Indica quais produtos estã' /* comment truncated */;


-- -----------------------------------------------------
-- Table `wsn_db`.`Remessa`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Remessa` (
  `id_remessa` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da remessa no banco de dados.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_remessa`) )
ENGINE = InnoDB
COMMENT = 'Remessas de produtos enviadas da fábrica.';


-- -----------------------------------------------------
-- Table `wsn_db`.`Produto_Remessa`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Produto_Remessa` (
  `produto_id` INT NOT NULL COMMENT 'Número sequencial do produto no banco de dados.' ,
  `remessa_id` INT NOT NULL COMMENT 'Número sequencial da remessa no banco de dados.' ,
  `quant` INT NULL COMMENT 'Quantidade do produto na remessa.' ,
  `preco` DECIMAL NULL COMMENT 'Preço do produto na remessa.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`produto_id`, `remessa_id`) ,
  INDEX `fk_produtos_has_remessas_remessas1` (`remessa_id` ASC) ,
  INDEX `fk_produtos_has_remessas_produtos1` (`produto_id` ASC) ,
  CONSTRAINT `fk_produtos_has_remessas_produtos1`
    FOREIGN KEY (`produto_id` )
    REFERENCES `wsn_db`.`Produto` (`id_produto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produtos_has_remessas_remessas1`
    FOREIGN KEY (`remessa_id` )
    REFERENCES `wsn_db`.`Remessa` (`id_remessa` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Relação entre produtos e remessas. Indica quais produtos est' /* comment truncated */;


-- -----------------------------------------------------
-- Table `wsn_db`.`Contato`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Contato` (
  `id_contato` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial do contato no banco de dados.' ,
  `cliente_id` INT NOT NULL COMMENT 'Número sequencial do cliente no banco de dados.' ,
  `nome` VARCHAR(45) NULL COMMENT 'Nome da pessoa de contato do cliente.' ,
  `telefone` VARCHAR(45) NULL COMMENT 'Telefone do contato.' ,
  `email` VARCHAR(45) NULL COMMENT 'e-mail do contato.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_contato`, `cliente_id`) ,
  INDEX `fk_contatos_clientes1` (`cliente_id` ASC) ,
  CONSTRAINT `fk_contatos_clientes1`
    FOREIGN KEY (`cliente_id` )
    REFERENCES `wsn_db`.`Cliente` (`id_cliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Pessoas e meios de contato do cliente.';


-- -----------------------------------------------------
-- Table `wsn_db`.`Categoria`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da categoria no banco de dados.' ,
  `nome` VARCHAR(30) NULL COMMENT 'Nome da categoria.' ,
  `descricao` VARCHAR(100) NULL COMMENT 'Descrição da categoria.' ,
  `icone` VARCHAR(100) NULL COMMENT 'Endereço da imagem da categoria no servidor.' ,
  `limite_inferior` DECIMAL NULL COMMENT 'Limite inferior do volume de vendas da categoria.' ,
  `limite_superior` DECIMAL NULL COMMENT 'Limite superior do volume de vendas da categoria.' ,
  `qtd_dias` INT NULL COMMENT 'Intervalo de vendas considerado para aferir limites inferior e superior da categoria.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_categoria`) )
ENGINE = InnoDB
COMMENT = 'Categorias de clientes de acordo com o seu volume de compra.';


-- -----------------------------------------------------
-- Table `wsn_db`.`Cliente_Categoria`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`Cliente_Categoria` (
  `cliente_id` INT NOT NULL COMMENT 'Número sequencial do cliente no banco de dados.' ,
  `categoria_id` INT NOT NULL COMMENT 'Número sequencial da categoria no banco de dados.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`cliente_id`, `categoria_id`) ,
  INDEX `fk_clientes_has_categorias_categorias1` (`categoria_id` ASC) ,
  INDEX `fk_clientes_has_categorias_clientes1` (`cliente_id` ASC) ,
  CONSTRAINT `fk_clientes_has_categorias_clientes1`
    FOREIGN KEY (`cliente_id` )
    REFERENCES `wsn_db`.`Cliente` (`id_cliente` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_has_categorias_categorias1`
    FOREIGN KEY (`categoria_id` )
    REFERENCES `wsn_db`.`Categoria` (`id_categoria` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Relação entre categorias e clientes. Indica quais clientes e' /* comment truncated */;


-- -----------------------------------------------------
-- Table `wsn_db`.`H_Produto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `wsn_db`.`H_Produto` (
  `id_h_produto` INT NOT NULL AUTO_INCREMENT COMMENT 'Número sequencial da tabela de histórico de produtos.' ,
  `produto_id` INT NOT NULL COMMENT 'Número sequencial do produto no banco de dados.' ,
  `nome` VARCHAR(100) NULL COMMENT 'Nome do produto.' ,
  `imagem` VARCHAR(100) NULL COMMENT 'Endereço da imagem do produto no servidor.' ,
  `preco_atual` DECIMAL NULL COMMENT 'Preço atual do produto, atualizado a cada remessa.' ,
  `estoque_critico` INT NULL COMMENT 'Estoque mínimo a ser considerado para emissão de novos pedidos.' ,
  `estoque_virtual` INT NULL COMMENT 'Estoque virtual considerando os pedidos realizados pelos clientes.' ,
  `estoque_fisico` INT NULL COMMENT 'Estoque considerando a retirada de produtos no estoque da empresa.' ,
  `peso` DECIMAL NULL COMMENT 'Peso do produto.' ,
  `qtd_caixa` INT NULL COMMENT 'Quantidade de unidades do produto por caixa.' ,
  `dt_inclusao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_h_produto`) ,
  INDEX `fk_h_produtos_produtos1` (`produto_id` ASC) ,
  CONSTRAINT `fk_h_produtos_produtos1`
    FOREIGN KEY (`produto_id` )
    REFERENCES `wsn_db`.`Produto` (`id_produto` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela de histórico de Produtos.';



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
