
/*================================
		TRIGGER
==================================*/

/**
* Insert_Usuario:			
*					Confirma que los atributos (sexo) y (estado) en la tabla
*					USUARIO no lleguen a poseer valores erroneos.
*
* TABLA: USUARIO
* EVENTO: Antes de insertar un registro en la tabla
*/
DELIMITER $$
CREATE TRIGGER Insert_Usuario
	BEFORE INSERT
	ON USUARIO
    for each row
BEGIN
		IF (NEW.sexo <> 'M' AND NEW.sexo NOT LIKE 'F' ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'INSERT: El campo (sexo) debe ser "M" (masculino) o "F" (femenino)';
	END IF;
    IF (NEW.estado NOT LIKE 'Disponible' AND NEW.estado NOT LIKE 'Ocupado' ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'INSERT: El campo (estado) debe ser "Disponible" o "Ocupado"';
	END IF;
END $$
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!

/**
* Insert_GrupoSecreto:			
*					Confirma que los atributos (TipoGrupo) y (Estado) en la tabla
*					GRUPOSECRETO no lleguen a poseer valores erroneos.
*
* TABLA: GRUPOSECRETO
* EVENTO: Antes de insertar un registro en la tabla
*/
DELIMITER $$
CREATE TRIGGER Insert_GrupoSecreto
	BEFORE	INSERT
	ON GRUPOSECRETO
	for each row
BEGIN    
	IF (NEW.TipoGrupo NOT LIKE 'En Pareja' AND NEW.TipoGrupo NOT LIKE 'Aleatorio' ) THEN		
        SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'INSERT: El campo (TipoGrupo) debe ser "En Pareja"
							o "Aleatorio"', MYSQL_ERRNO = NEW.IdGrupo;
	END IF;
    
    IF (NEW.Estado NOT LIKE 'En Curso' AND NEW.Estado NOT LIKE 'Cancelado' 
		AND NEW.Estado NOT LIKE 'Finalizado') THEN        
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'INSERT: El campo (estado) debe ser "En Curso", 
							"Cancelado" o "Finalizado"', MYSQL_ERRNO = NEW.IdGrupo;
	END IF;
    
    IF  NEW.FechaIni > NEW.FechaFin THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'INSERT: La FechaFin debe ser mayor a 
							la FechaIni', MYSQL_ERRNO = NEW.IdGrupo;
    END IF;		
END $$
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!

/**
* Insert_Participante_GrupoSecreto:			
*										Llama al procedimiento "Add_User_GrupoSecreto" para
*										agregar un Participante a un GrupoSecreto. Enviando
*										el atributo (IdGrupo) y (IdUsuarioAdministrador) para
*										localizar el Grupo Secreto al cual se le desea ingresar 
*										uno o varios usuarios.
*
* TABLA: PARTICIPA
* EVENTO: Antes de insertar un registro en la tabla
*/
DELIMITER $$
CREATE TRIGGER Insert_Participante_GrupoSecreto
	BEFORE	INSERT	
    ON PARTICIPA
    for each row
		BEGIN			
            DECLARE Var_Sexo VARCHAR(1);
            
			-- Verificar si el participante no esta en tu lista de amigos 
            IF (select Usuario_Es_Amigo(NEW.IdUsuarioAdministrador,NEW.IdParticipante) = 0) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'INSERT: El Usuario no esta en tu lista de amigos',
									MYSQL_ERRNO = NEW.IdParticipante;
            END IF;
            
            -- Verificar que el usuario quiera participar en los grupos secretos
            IF (select VerificarEstadoUsuario(NEW.IdParticipante)) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'INSERT: El Usuario no se encuentra Disponible', 
									MYSQL_ERRNO = NEW.IdParticipante;
            END IF;
			
            -- Buscar el sexo del usuario a agregar
			SELECT Sexo into Var_Sexo from usuario where usuario.IdUsuario = NEW.IdParticipante;
       
				CALL Add_User_GrupoSecreto
					(NEW.IdGrupo,NEW.IdUsuarioAdministrador,Var_Sexo);
END $$
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!

/**
* Update_Usuario:			
*					Confirma que los atributos (sexo) y (estado) en la tabla
*					USUARIO no llegen a poseer valores erroneos.
*
* TABLA: USUARIO
* EVENTO: Antes de actualizar un registro en la tabla
*/
DELIMITER $$
CREATE TRIGGER Update_Usuario
	BEFORE UPDATE
	ON USUARIO
    for each row
BEGIN
	IF (NEW.sexo NOT LIKE 'M' AND NEW.sexo NOT LIKE 'F' ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'UPDATE: El campo (sexo) debe ser "M" (masculino) o 
							"F" (femenino)',MYSQL_ERRNO = NEW.IdUsuario;
	END IF;
    IF (NEW.estado NOT LIKE 'Disponible' AND NEW.estado NOT LIKE 'Ocupado' ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'UPDATE: El campo (estado) debe ser "Disponible" o 
							"Ocupado"',MYSQL_ERRNO = NEW.IdUsuario;
	END IF;
END $$
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!


/**
* Update_Cant_User: 		
*					Llama al procedimiento "Verificar_CantActUser_GrupoSecreto" 
*					para saber si un Grupo Secreto dado esta al tope de su 
*					capacidad de usuarios disponibles. Enviando el atributo 
*					(IdGrupo), (Usuario_IdUsuario) y (CantActUser) para localizar 
*					el Grupo Secreto que se desea verificar.
*
* TABLA: GRUPOSECRETO
* EVENTO: Antes de Actualizar un registro en la tabla
*/
DELIMITER $$
CREATE TRIGGER Update_Cant_User
	BEFORE	UPDATE
    ON GRUPOSECRETO
    for each row
		BEGIN   

        	IF (NEW.TipoGrupo NOT LIKE 'En Pareja' AND NEW.TipoGrupo NOT LIKE 'Aleatorio' ) THEN		
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'UPDATE: El campo (TipoGrupo) debe ser 
									"En Pareja" o "Aleatorio"',MYSQL_ERRNO = NEW.IdGrupo;
			END IF;
    
			IF (NEW.Estado NOT LIKE 'En Curso' AND NEW.Estado NOT LIKE 'Cancelado' 
				AND NEW.Estado NOT LIKE 'Finalizado') THEN        
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'UPDATE: El campo (estado) debe ser "En Curso"
									, "Cancelado" o "Finalizado"',MYSQL_ERRNO = NEW.IdGrupo;
			END IF; 
            
			IF  NEW.FechaIni > NEW.FechaFin THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'UPDATE: La FechaFin debe ser mayor a la
									FechaIni',MYSQL_ERRNO = NEW.IdGrupo;
			END IF;	
            
			CALL Verificar_CantActUser_GrupoSecreto
					(NEW.IdGrupo,NEW.IdAdministrador,NEW.CantActUser,NEW.CantActHombres,NEW.CantActMujeres);
     END $$
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!


/**
* Delete_Participante: 		
*					Al borrar un registro de la tabla participa, se
*					Llama al procedimiento "Delete_User_GrupoSecreto" para
*					eliminar a un Participante de un GrupoSecreto. Enviando
*					el atributo (IdGrupo) y (IdUsuarioAdministrador) para
*					localizar el Grupo Secreto del cual se desea eliminar a  
*					uno o varios usuarios.
*
* TABLA: PARTICIPA
* EVENTO: Antes de eliminar un registro en la tabla
*/
DELIMITER $$
CREATE TRIGGER Delete_Participante
	BEFORE	DELETE	
    ON PARTICIPA
    for each row
		BEGIN
			DECLARE Var_Sexo VARCHAR(1);
	
        -- Buscar el sexo del usuario a eliminar
			SELECT Sexo into Var_Sexo from usuario where usuario.IdUsuario = OlD.IdParticipante;
			
            CALL Delete_User_GrupoSecreto
					(OLD.IdGrupo,OLD.IdUsuarioAdministrador,Var_Sexo);            
        END $$
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!


/**
* Delete_GrupoSecreto: 		
*					Borra las registros de las TABLAS Regala, Participa y 
*					GrupoSecreto. Cuando un Grupo Secreto es eliminado. Se usa
*					el atributo (IdGrupo) y (Usuario_IdUsuario) para localizar
*					los registros a eliminar en cada tabla.
*
* TABLA: GRUPOSECRETO
* EVENTO: Antes de eliminar un registro en la tabla
*/
DELIMITER $$
CREATE TRIGGER Delete_GrupoSecreto
	BEFORE	DELETE	
    ON GRUPOSECRETO
    for each row
		BEGIN
			DELETE	FROM REGALA 
			WHERE	idGrupo = OLD.idGrupo AND
					IdAdministrador = OLD.IdAdministrador;
        
        
			DELETE	FROM PARTICIPA 
			WHERE	idGrupo = OLD.idGrupo AND
					IdAdministrador = OLD.IdAdministrador;
            
        END $$
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!