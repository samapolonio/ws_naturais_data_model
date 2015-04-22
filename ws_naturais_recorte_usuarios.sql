SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


-- -----------------------------------------------------
-- Table `ws_naturais_db`.`transacoes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ws_naturais_db`.`transacoes` (
  `id_transacoes` INT NOT NULL COMMENT 'Número sequencial da transação no banco de dados.' ,
  `nome` VARCHAR(30) NOT NULL COMMENT 'Nome da transação.' ,
  `descricao` VARCHAR(100) NULL COMMENT 'Descrição da transação.' ,
  `url` VARCHAR(200) NULL COMMENT 'URL associada à transação.' ,
  `dt_inclusao` TIMESTAMP NOT NULL COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_transacoes`) )
ENGINE = InnoDB
COMMENT = 'Transações do sistema para as ações do usuário.';


-- -----------------------------------------------------
-- Table `ws_naturais_db`.`perfis`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ws_naturais_db`.`perfis` (
  `id_perfis` INT NOT NULL COMMENT 'Número sequencial do perfil no banco de dados.' ,
  `nome` VARCHAR(30) NOT NULL COMMENT 'Nome do perfil.' ,
  `descricao` VARCHAR(100) NULL COMMENT 'Descrição do perfil.' ,
  `dt_inclusao` TIMESTAMP NOT NULL COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`id_perfis`) )
ENGINE = InnoDB
COMMENT = 'Perfis (papeis) dos usuários no sistema.';


-- -----------------------------------------------------
-- Table `ws_naturais_db`.`usuarios`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ws_naturais_db`.`usuarios` (
  `id_usuarios` INT NOT NULL COMMENT 'Número sequencial do usuário no banco de dados.' ,
  `perfis_id` INT NOT NULL COMMENT 'Número sequencial do perfil no banco de dados.' ,
  `nome` VARCHAR(100) NULL COMMENT 'Nome do usuário.' ,
  `senha` VARCHAR(10) NULL COMMENT 'Senha do usuário.' ,
  `email` VARCHAR(100) NULL COMMENT 'Email do usuário.' ,
  `cargo` VARCHAR(30) NULL COMMENT 'Cargo do usuário: administrador ou vendedor' ,
  `dt_inclusao` TIMESTAMP NOT NULL COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Cargo do usuário: administrador ou vendedor' ,
  PRIMARY KEY (`id_usuarios`) ,
  INDEX `fk_usuarios_perfis1` (`perfis_id` ASC) ,
  CONSTRAINT `fk_usuarios_perfis1`
    FOREIGN KEY (`perfis_id` )
    REFERENCES `ws_naturais_db`.`perfis` (`id_perfis` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Usuários com acesso às funcionalidades do sistema. \n';


-- -----------------------------------------------------
-- Table `ws_naturais_db`.`perfis_transacoes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ws_naturais_db`.`perfis_transacoes` (
  `transacoes_id` INT NOT NULL COMMENT 'Número sequencial da transação no banco de dados.' ,
  `perfis_id` INT NOT NULL COMMENT 'Número sequencial do perfil no banco de dados.' ,
  `dt_inclusao` TIMESTAMP NOT NULL COMMENT 'Data de inclusão do registro no banco de dados.' ,
  `dt_atualizacao` TIMESTAMP NULL COMMENT 'Data de atualização do registro no banco de dados.' ,
  PRIMARY KEY (`transacoes_id`, `perfis_id`) ,
  INDEX `fk_transacoes_has_perfis_perfis1` (`perfis_id` ASC) ,
  INDEX `fk_transacoes_has_perfis_transacoes1` (`transacoes_id` ASC) ,
  CONSTRAINT `fk_transacoes_has_perfis_transacoes1`
    FOREIGN KEY (`transacoes_id` )
    REFERENCES `ws_naturais_db`.`transacoes` (`id_transacoes` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transacoes_has_perfis_perfis1`
    FOREIGN KEY (`perfis_id` )
    REFERENCES `ws_naturais_db`.`perfis` (`id_perfis` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Relação entre perfis e transações.\nIndica quais perfis possu' /* comment truncated */;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
