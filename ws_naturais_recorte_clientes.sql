SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `ws_naturais_db` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `ws_naturais_db` ;

-- -----------------------------------------------------
-- Table `ws_naturais_db`.`clientes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ws_naturais_db`.`clientes` (
  `id_clientes` INT NOT NULL COMMENT 'Número sequencial do cliente no banco de dados.' ,
  `cnpj` VARCHAR(20) NULL COMMENT 'CNPJ do cliente.' ,
  `razao_social` VARCHAR(200) NULL COMMENT 'Razão social do cliente.' ,
  `nome_fantasia` VARCHAR(200) NULL COMMENT 'Nome fantasia do cliente.' ,
  `situacao` VARCHAR(1) NULL COMMENT 'Situação do cliente: Ativo ou Inativo' ,
  `email` VARCHAR(100) NULL COMMENT 'Email do cliente.' ,
  `telefone` VARCHAR(45) NULL ,
  `dt_inclusao` TIMESTAMP NOT NULL COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_clientes`) )
ENGINE = InnoDB
COMMENT = 'Clientes que podem emitir pedidos de produtos.';


-- -----------------------------------------------------
-- Table `ws_naturais_db`.`lojas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ws_naturais_db`.`lojas` (
  `id_lojas` INT NOT NULL COMMENT 'Número sequencial da loja no banco de dados.' ,
  `clientes_id` INT NOT NULL COMMENT 'Número sequencial do cliente no banco de dados.' ,
  `nome` VARCHAR(50) NULL COMMENT 'Nome da loja.' ,
  `dt_inclusao` TIMESTAMP NOT NULL COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  INDEX `fk_lojas_empresas1` (`clientes_id` ASC) ,
  PRIMARY KEY (`id_lojas`) ,
  CONSTRAINT `fk_lojas_empresas1`
    FOREIGN KEY (`clientes_id` )
    REFERENCES `ws_naturais_db`.`clientes` (`id_clientes` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Lojas de clientes.';


-- -----------------------------------------------------
-- Table `ws_naturais_db`.`uf`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ws_naturais_db`.`uf` (
  `id_uf` INT NOT NULL COMMENT 'Número sequencial da UF no banco de dados.' ,
  `sigla` VARCHAR(2) NOT NULL COMMENT 'Sigla da UF' ,
  `nome` VARCHAR(20) NOT NULL COMMENT 'Nome da UF' ,
  `dt_inclusao` TIMESTAMP NOT NULL COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_uf`) )
ENGINE = InnoDB
COMMENT = 'Lista de UF onde empresas possuem sede e/ou lojas.';


-- -----------------------------------------------------
-- Table `ws_naturais_db`.`cidades`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ws_naturais_db`.`cidades` (
  `id_cidades` INT NOT NULL COMMENT 'Número sequencial da cidade no banco de dados.' ,
  `uf_id` INT NOT NULL COMMENT 'Número sequencial da UF no banco de dados.' ,
  `nome` VARCHAR(50) NOT NULL COMMENT 'Nome da cidade.' ,
  `dt_inclusao` TIMESTAMP NOT NULL COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_cidades`) ,
  INDEX `fk_cidades_uf1` (`uf_id` ASC) ,
  CONSTRAINT `fk_cidades_uf1`
    FOREIGN KEY (`uf_id` )
    REFERENCES `ws_naturais_db`.`uf` (`id_uf` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Cidades onde podem existir lojas.';


-- -----------------------------------------------------
-- Table `ws_naturais_db`.`enderecos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ws_naturais_db`.`enderecos` (
  `id_enderecos` INT NOT NULL COMMENT ' Número sequencial do endereço no banco de dados.' ,
  `lojas_id` INT NOT NULL COMMENT 'Número sequencial da loja no banco de dados.' ,
  `cidades_id` INT NOT NULL COMMENT 'Número sequencial da cidade no banco de dados.' ,
  `tp_logradouro` VARCHAR(20) NULL COMMENT 'Tipo de logradouro. Ex: Avenida, Rua, Travessa etc.' ,
  `logradouro` VARCHAR(60) NULL COMMENT 'Nome do logradouro.' ,
  `numero` VARCHAR(10) NULL COMMENT 'Número no logradouro.' ,
  `complemento` VARCHAR(50) NULL COMMENT 'Complemento do endereço.' ,
  `bairro` VARCHAR(50) NULL COMMENT 'Nome do Bairro' ,
  `cep` VARCHAR(9) NULL COMMENT 'Código de Endereçamento Postal.' ,
  `latitude` VARCHAR(100) NULL COMMENT 'Latitude do endereço.' ,
  `longitude` VARCHAR(100) NULL COMMENT 'Longitude do endereço.' ,
  `dt_inclusao` TIMESTAMP NOT NULL COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  INDEX `fk_enderecos_cidades1` (`cidades_id` ASC) ,
  INDEX `fk_enderecos_lojas1` (`lojas_id` ASC) ,
  PRIMARY KEY (`id_enderecos`) ,
  CONSTRAINT `fk_enderecos_cidades1`
    FOREIGN KEY (`cidades_id` )
    REFERENCES `ws_naturais_db`.`cidades` (`id_cidades` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enderecos_lojas1`
    FOREIGN KEY (`lojas_id` )
    REFERENCES `ws_naturais_db`.`lojas` (`id_lojas` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Endereços de lojas';



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
