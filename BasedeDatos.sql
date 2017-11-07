SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


CREATE SCHEMA IF NOT EXISTS `Proyecto` DEFAULT CHARACTER SET utf8 ;
USE `Proyecto` ;

-- -----------------------------------------------------
-- Table `Producto`
-- -----------------------------------------------------
CREATE TABLE `Producto` (
  `IdProducto` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(45) NULL,
  `Precio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdProducto`))
ENGINE = InnoDB  CHARSET=latin1 ;


-- -----------------------------------------------------
-- Table `Usuario`
-- -----------------------------------------------------
CREATE TABLE `Usuario` (
  `IdUsuario` INT NOT NULL AUTO_INCREMENT,
  `Ci` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Edad` INT(2) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Correo` VARCHAR(45) NOT NULL,
  `Clave` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL DEFAULT 'Disponible',-- Los tipos son [Disponible, Ocupado]
  `Sexo` VARCHAR(1) NOT NULL NULL DEFAULT 'M',-- Los tipos son [M, F]
  PRIMARY KEY (`IdUsuario`),
  UNIQUE INDEX `Idx_Ci` (`Ci` ASC),
  UNIQUE INDEX `Idx_Correo` (`Correo` ASC))
ENGINE = InnoDB  CHARSET=latin1 ;

-- -----------------------------------------------------
-- Table `Es_Amigo`
-- -----------------------------------------------------
CREATE TABLE `Es_Amigo` (
	`IdUsuario` INT NOT NULL,
	`IdAmigo` INT NOT NULL,
	PRIMARY KEY (`IdUsuario`, `IdAmigo`),
	INDEX `Idx_EsAmigo_IdUsuario` (`IdUsuario` ASC),
  CONSTRAINT `fk_EsAmigo_Usuario_IdUsuario`
    FOREIGN KEY (`IdUsuario`)
    REFERENCES `Usuario` (`IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EsAmigo_Usuario_IdAmigo`
    FOREIGN KEY (`IdAmigo`)
    REFERENCES `Usuario` (`IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB  CHARSET=latin1 ;

-- -----------------------------------------------------
-- Table `GrupoSecreto`
-- -----------------------------------------------------
CREATE TABLE `GrupoSecreto` (
  `IdGrupo` INT NOT NULL AUTO_INCREMENT,
  `IdAdministrador` INT NOT NULL,
  `NombreGrupo` VARCHAR(45) NOT NULL,
  `CantMaxUser` INT(2) NOT NULL,
  `CantActUser` INT(2) NOT NULL DEFAULT 0,
  `CantActMujeres` INT(2) NOT NULL DEFAULT 0,
  `CantActHombres` INT(2) NOT NULL DEFAULT 0,
  `TipoGrupo` VARCHAR(45) NOT NULL DEFAULT 'Aleatorio', -- Los tipos son [En Pareja, Aleatorio]
  `LimitePrecioA` VARCHAR(45) NOT NULL,
  `LimitePrecioB` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL DEFAULT 'En Curso', -- Los tipos son [En Curso, Cancelado, Finalizado]
  `FechaIni` DATE NOT NULL, -- Es de tipo [Year-M-Day]
  `FechaFin` DATE NOT NULL, -- Es de tipo [Year-M-Day]
  PRIMARY KEY (`IdGrupo`, `IdAdministrador`),
  INDEX `Idx_GrupoSecreto_id` (`IdAdministrador` ASC),
  CONSTRAINT `fk_GrupoSecreto_Usuario_IdUsuario`
    FOREIGN KEY (`IdAdministrador`)
    REFERENCES `Usuario` (`IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB  CHARSET=latin1 ;

-- -----------------------------------------------------
-- Table `Participa`
-- -----------------------------------------------------
CREATE TABLE `Participa` (
  `IdGrupo` INT NOT NULL,
  `IdUsuarioAdministrador` INT NOT NULL,
  `IdParticipante` INT NOT NULL,
  PRIMARY KEY (`IdGrupo`, `IdUsuarioAdministrador`, `IdParticipante`),
  INDEX `Idx_Participa_IdParticipante` (`IdParticipante` ASC),
  INDEX `Idx_Participa_IdsGrupoSecreto` (`IdGrupo` ASC, `IdUsuarioAdministrador` ASC),
  CONSTRAINT `fk_Participa_GrupoSecreto_IdsGrupoSecreto`
    FOREIGN KEY (`IdGrupo` , `IdUsuarioAdministrador`)
    REFERENCES `GrupoSecreto` (`IdGrupo` , `IdAdministrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Participa_Usuario_IdParticipante`
    FOREIGN KEY (`IdParticipante`)
    REFERENCES `Usuario` (`IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB  CHARSET=latin1 ;


-- -----------------------------------------------------
-- Table `Regala`
-- -----------------------------------------------------
CREATE TABLE `Regala` (
  `IdGrupo` INT NOT NULL,
  `IdAdministrador` INT NOT NULL,
  `IdRegalador` INT NOT NULL,
  `IdRecibidor` INT NOT NULL,
  PRIMARY KEY (`IdRegalador`, `IdRecibidor`, `IdGrupo`, `IdAdministrador`),
  INDEX `Idx_Regala_IdUsuarioReg` (`IdRegalador` ASC),
  INDEX `Idx_Regala_IdsGrupoSecreto` (`IdGrupo` ASC, `IdAdministrador` ASC),
  CONSTRAINT `fk_Regala_Usuario_IdUsuarioReg`
    FOREIGN KEY (`IdRegalador`)
    REFERENCES `Usuario` (`IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Regala_Usuario_IdUsuarioRec`
    FOREIGN KEY (`IdRecibidor`)
    REFERENCES `Usuario` (`IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Regala_GrupoSecreto_IdsGrupoSecreto`
    FOREIGN KEY (`IdGrupo` , `IdAdministrador`)
    REFERENCES `GrupoSecreto` (`IdGrupo` , `IdAdministrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB  CHARSET=latin1 ;

-- -----------------------------------------------------
-- Table `LeGusta`
-- -----------------------------------------------------
CREATE TABLE .`LeGusta` (
  `IdProducto` INT NOT NULL,
  `IdUsuario` INT NOT NULL,
  PRIMARY KEY (`IdProducto`, `IdUsuario`),
  INDEX `Idx_LeGusta_IdUsuario` (`IdUsuario` ASC),
  INDEX `Idx_LeGusta_IdProducto` (`IdProducto` ASC),
  CONSTRAINT `fk_LeGusta_Producto_IdProducto`
    FOREIGN KEY (`IdProducto`)
    REFERENCES `Producto` (`IdProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LeGusta_Usuario_IdUsuario`
    FOREIGN KEY (`IdUsuario`)
    REFERENCES `Usuario` (`IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB  CHARSET=latin1 ;

-- -----------------------------------------------------
-- Table `Posee`
-- -----------------------------------------------------
CREATE TABLE `Posee` (
  `IdTienda` INT NOT NULL,
  `IdAdministradorTienda` INT NOT NULL,
  `IdProducto` INT NOT NULL,
  PRIMARY KEY (`IdTienda`, `IdAdministradorTienda`, `IdProducto`),
  INDEX `Idx_Posee_IdProducto` (`IdProducto` ASC),
  INDEX `Idx_Posee_IdsTienda` (`IdTienda` ASC, `IdAdministradorTienda` ASC),
  CONSTRAINT `fk_Posee_Tienda_IdsTienda`
    FOREIGN KEY (`IdTienda` , `IdAdministradorTienda`)
    REFERENCES `Tienda` (`IdTienda` , `IdAdministradorTienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Posee_Producto_IdProducto`
    FOREIGN KEY (`IdProducto`)
    REFERENCES `Producto` (`IdProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB  CHARSET=latin1 ;


-- -----------------------------------------------------
-- Table `Tienda`
-- -----------------------------------------------------
CREATE TABLE `Tienda` (
  `IdTienda` INT NOT NULL AUTO_INCREMENT,
  `IdAdministradorTienda` INT NOT NULL,
  `NombreTienda` VARCHAR(45) NULL,
  `DireccionTienda` VARCHAR(45) NULL,
  `TelefonoTienda` VARCHAR(45) NULL,
  PRIMARY KEY (`IdTienda`, `IdAdministradorTienda`),
  INDEX `Idx_Tienda_IdAdministradorTienda` (`IdAdministradorTienda` ASC),
  CONSTRAINT `fk_Tienda_AdministradorTienda_IdAdmin`
    FOREIGN KEY (`IdAdministradorTienda`)
    REFERENCES `AdministradorTienda` (`IdAdmin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB  CHARSET=latin1 ;

-- -----------------------------------------------------
-- Table `AdministradorTienda`
-- -----------------------------------------------------
CREATE TABLE `AdministradorTienda` (
  `IdAdmin` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Cedula` INT NOT NULL,
  `Correo` VARCHAR(45) NOT NULL,
  `Clave` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdAdmin`),
  UNIQUE INDEX `Idx_Correo` (`Correo` ASC),
  UNIQUE INDEX `Idx_Cedula` (`Cedula` ASC))
ENGINE = InnoDB  CHARSET=latin1 ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=1;
SET UNIQUE_CHECKS=1;
SET GLOBAL event_scheduler=ON;