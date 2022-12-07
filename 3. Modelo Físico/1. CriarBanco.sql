-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema IgrejaBD
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema IgrejaBD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `IgrejaBD` DEFAULT CHARACTER SET utf8 ;
USE `IgrejaBD` ;

-- -----------------------------------------------------
-- Table `IgrejaBD`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IgrejaBD`.`Usuarios` (
  `CPF` VARCHAR(14) NOT NULL,
  `Nome` VARCHAR(255) NOT NULL,
  `Sobrenome` VARCHAR(255) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(14) NOT NULL,
  `HashSenha` CHAR(87) NOT NULL,
  `NomeCompleto` TEXT NULL,
  PRIMARY KEY (`CPF`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `Telefone_UNIQUE` (`Telefone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IgrejaBD`.`Administradores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IgrejaBD`.`Administradores` (
  `Usuario_CPF` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`Usuario_CPF`),
  CONSTRAINT `fk_Administrador_Usuario`
    FOREIGN KEY (`Usuario_CPF`)
    REFERENCES `IgrejaBD`.`Usuarios` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IgrejaBD`.`Publicacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IgrejaBD`.`Publicacoes` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Administradores_Usuario_CPF` VARCHAR(14) NOT NULL,
  `Legenda` TEXT NOT NULL,
  `Imagem` LONGBLOB NOT NULL,
  `Data` DATETIME NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_Publicacoes_Administradores1_idx` (`Administradores_Usuario_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Publicacoes_Administradores1`
    FOREIGN KEY (`Administradores_Usuario_CPF`)
    REFERENCES `IgrejaBD`.`Administradores` (`Usuario_CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IgrejaBD`.`CartaoDeCredito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IgrejaBD`.`CartaoDeCredito` (
  `Numero` VARCHAR(19) NOT NULL,
  `CVV` SMALLINT NOT NULL,
  `DataVencimento` DATE NOT NULL,
  `AnoMesVencimento` CHAR(5) NULL,
  `Bandeira` VARCHAR(45) NULL,
  PRIMARY KEY (`Numero`),
  UNIQUE INDEX `Numero_UNIQUE` (`Numero` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IgrejaBD`.`Usuarios_CartaoDeCredito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IgrejaBD`.`Usuarios_CartaoDeCredito` (
  `Usuarios_CPF` VARCHAR(14) NOT NULL,
  `CartaoDeCredito_Numero` VARCHAR(19) NOT NULL,
  PRIMARY KEY (`Usuarios_CPF`, `CartaoDeCredito_Numero`),
  INDEX `fk_Usuarios_CartaoDeCredito_CartaoDeCredito1_idx` (`CartaoDeCredito_Numero` ASC) VISIBLE,
  CONSTRAINT `fk_CartaoCreditoUsuarios_Usuarios1`
    FOREIGN KEY (`Usuarios_CPF`)
    REFERENCES `IgrejaBD`.`Usuarios` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_CartaoDeCredito_CartaoDeCredito1`
    FOREIGN KEY (`CartaoDeCredito_Numero`)
    REFERENCES `IgrejaBD`.`CartaoDeCredito` (`Numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IgrejaBD`.`Doacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IgrejaBD`.`Doacoes` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Usuarios_CPF` VARCHAR(14) NOT NULL,
  `Data` DATETIME NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_Doacoes_Usuarios1_idx` (`Usuarios_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Doacoes_Usuarios1`
    FOREIGN KEY (`Usuarios_CPF`)
    REFERENCES `IgrejaBD`.`Usuarios` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IgrejaBD`.`Pagamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IgrejaBD`.`Pagamentos` (
  `Doacoes_ID` INT NOT NULL AUTO_INCREMENT,
  `Valor` DECIMAL(6,2) NOT NULL,
  `DataPagamento` DATETIME NOT NULL,
  `Tipo` ENUM('Cartao', 'Pix', 'Boleto') NOT NULL,
  `Parcelas` TINYINT NULL,
  PRIMARY KEY (`Doacoes_ID`),
  CONSTRAINT `fk_Pagamentos_Doacoes1`
    FOREIGN KEY (`Doacoes_ID`)
    REFERENCES `IgrejaBD`.`Doacoes` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
