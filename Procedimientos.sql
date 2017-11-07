
/*================================
		PROCEDURE
==================================*/

/**
* Add_amigo:			
*					Cuando un usuario agrega a alguien a sus amigos
*					este usuario pasa automaticamente a tambien
*					ser amigo de quien lo agregó.
*
* TABLA: Es_Amigo
* EVENTO: Antes de insertar un registro en la tabla
*/
DELIMITER $$
CREATE PROCEDURE Add_amigo (IdUsuario INT, IdAmigo INT)
BEGIN
                                    
	-- Verificar que el usuario no este ya en mi lista
	IF (Usuario_Es_Amigo(IdUsuario, IdAmigo) = 1) THEN     
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'INSERT (Es_Amigo): El Usuario ya es tu amigo';	
        
	-- Agregarme a mi mismo
	ELSEIF (IdUsuario = IdAmigo) THEN
			INSERT INTO ES_AMIGO VALUE (IdUsuario,IdAmigo);
		ELSE
	    -- Agregar aun amigo y agregarme como su amigo
				INSERT INTO ES_AMIGO VALUE (IdUsuario,IdAmigo);
				INSERT INTO ES_AMIGO VALUE (IdAmigo,IdUsuario);
	END IF;
END $$
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!
/**
* Add_User_GrupoSecreto:	
*						Aumenta en +1 al atributo (CantActUser) en la
* 						tabla (GrupoSecreto), dependiendo del (IdGrupo)
*						y del (IdUsuarioAdministrador) enviado al ingresar
*                       un usuario en la tabla (Participa).
*/
DELIMITER $$
CREATE PROCEDURE `Add_User_GrupoSecreto`
				(IN Var_IdGrupo INT, IN Var_IdUsuarioAdministrador INT,IN sexo VARCHAR(1))
BEGIN
	DECLARE var_CantActUser INT DEFAULT 0;
    DECLARE var_CantActHombres INT DEFAULT 0;
    DECLARE var_CantActMujeres INT DEFAULT 0;
        
    -- Obtener el valor actual de la cantidad de usuarios (CantActUser)
    SELECT CantActUser INTO var_CantActUser
		FROM gruposecreto 
		WHERE IdGrupo= Var_IdGrupo AND
		IdAdministrador = Var_IdUsuarioAdministrador;

	-- Obtener el valor actual de la cantidad de Hombres (CantActHombres)
    SELECT CantActHombres INTO var_CantActHombres
		FROM gruposecreto 
		WHERE IdGrupo= Var_IdGrupo AND
		IdAdministrador = Var_IdUsuarioAdministrador;

	-- Obtener el valor actual de la cantidad de Mujeres (CantActMujeres)
    SELECT CantActMujeres INTO var_CantActMujeres
		FROM gruposecreto 
		WHERE IdGrupo= Var_IdGrupo AND
		IdAdministrador = Var_IdUsuarioAdministrador;
           
    -- Actualizar el valor de la cantidad de usuarios (CantActUser)
		UPDATE gruposecreto SET CantActUser =var_CantActUser +1
			WHERE IdGrupo= Var_IdGrupo AND
			IdAdministrador = Var_IdUsuarioAdministrador; 
                 
    -- Actualizar el valor de (CantActHombres) o (CantActMujeres)
	if	(select VerificarTipoGrupo(Var_IdGrupo) = 0) then
			if sexo = 'M' then
				UPDATE gruposecreto SET CantActHombres=var_CantActHombres +1
					WHERE IdGrupo= Var_IdGrupo AND
					IdAdministrador= Var_IdUsuarioAdministrador;
            else
				UPDATE gruposecreto SET CantActMujeres=var_CantActMujeres +1
					WHERE IdGrupo= Var_IdGrupo AND
					IdAdministrador= Var_IdUsuarioAdministrador;
            end if;        
    end if; 
END $$
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!

/**
* Delete_User_GrupoSecreto:	
*						Disminuye en -1 al atributo (CantActUser) en la
* 						tabla (GrupoSecreto), dependiendo del (IdGrupo)
*						y del (IdUsuarioAdministrador) enviado al eliminar
*                       un usuario en la tabla (Participa).
*/
DELIMITER $$
CREATE PROCEDURE `Delete_User_GrupoSecreto`
				(IN Var_IdGrupo INT, IN Var_IdUsuarioAdministrador INT,IN sexo VARCHAR(1))
BEGIN
	DECLARE var_CantActUser INT DEFAULT 0;
    DECLARE var_CantActHombres INT DEFAULT 0;
    DECLARE var_CantActMujeres INT DEFAULT 0;
        
    -- Obtener el valor actual de la cantidad de usuarios (CantActUser)
    SELECT CantActUser INTO var_CantActUser
		FROM gruposecreto 
		WHERE IdGrupo= Var_IdGrupo AND
		IdAdministrador = Var_IdUsuarioAdministrador;

	-- Obtener el valor actual de la cantidad de Hombres (CantActHombres)
    SELECT CantActHombres INTO var_CantActHombres
		FROM gruposecreto 
		WHERE IdGrupo= Var_IdGrupo AND
		IdAdministrador = Var_IdUsuarioAdministrador;

	-- Obtener el valor actual de la cantidad de Mujeres (CantActMujeres)
    SELECT CantActMujeres INTO var_CantActMujeres
		FROM gruposecreto 
		WHERE IdGrupo= Var_IdGrupo AND
		IdAdministrador = Var_IdUsuarioAdministrador;
           
    -- Actualizar el valor de la cantidad de usuarios (CantActUser)
		UPDATE gruposecreto SET CantActUser =var_CantActUser -1
			WHERE IdGrupo= Var_IdGrupo AND
			IdAdministrador = Var_IdUsuarioAdministrador; 
                 
    -- Actualizar el valor de (CantActHombres) o (CantActMujeres)
	if	(select VerificarTipoGrupo(Var_IdGrupo) = 0) then
			if sexo = 'M' then
				UPDATE gruposecreto SET CantActHombres=var_CantActHombres -1
					WHERE IdGrupo= Var_IdGrupo AND
					IdAdministrador= Var_IdUsuarioAdministrador;
            else
				UPDATE gruposecreto SET CantActMujeres=var_CantActMujeres -1
					WHERE IdGrupo= Var_IdGrupo AND
					IdAdministrador= Var_IdUsuarioAdministrador;
            end if;        
    end if; 
END $$
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!


/**
* Verificar_CantActUser_GrupoSecreto:	
*					Verifica para un registro dado en la tabla (GrupoSecreto) 
*					si el atributo (CantActUser) llego al maximo de usuarios
*					posibles comparandolo con el atributo (CantMaxUser) del
*					registro dado. Y no permite ingresar mas Participantes 
*					en ese Grupo.
*/
DELIMITER $$
CREATE PROCEDURE `Verificar_CantActUser_GrupoSecreto`
				(IN Var_IdGrupo INT, IN Var_IdAdministrador INT, IN CantActUser INT,
                IN CantActHombres INT,IN CantActMujeres INT)
BEGIN
	DECLARE var_CantMaxUser INT DEFAULT 0;
    DECLARE cur_Datos Cursor FOR SELECT CantMaxUser
							FROM gruposecreto 
							WHERE IdGrupo= Var_IdGrupo AND
							IdAdministrador = Var_IdAdministrador;
                                
	-- SELECCIONAR LA CANTIDA MAXIMA DE USUARIOS EN EL REGISTRO
	OPEN cur_Datos;
		FETCH cur_Datos INTO var_CantMaxUser;
	CLOSE cur_Datos;

    IF  CantActUser > var_CantMaxUser THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'El Grupro-Secreto ID: Esta lleno';
	END IF;
   
    IF  CantActHombres > (var_CantMaxUser div 2) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'El Grupro-Secreto ID: En Cantidad Hombres Esta Lleno';
	END IF;
    
    IF  CantActMujeres > (var_CantMaxUser div 2) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'El Grupro-Secreto ID: En Cantidad Mujeres Esta Lleno';
	END IF;

END$$
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!

/**
* Finalizar_GrupoSecreto:	
*						Cambia el atributo (estado) en la tabla (GrupoSecreto) 
*						por "Finalizado", Si el atributo (FechaFin) es igual
*						a la fecha actual del sistema.
*/
DELIMITER $$
CREATE PROCEDURE `Finalizar_GrupoSecreto` ()
BEGIN
	UPDATE GRUPOSECRETO
		SET Estado = 'Finalizado'
	WHERE idGrupo IN (select idGrupo
							from (select idGrupo, FechaFin 
									from GRUPOSECRETO
                                    group by(idGrupo) 
									having FechaFin = DATE_FORMAT(NOW(),'%Y/%m/%d')
								 ) 
					   as T);
END$$
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!

/**
* Cancelar_GrupoSecreto:	
*						Cambia el atributo (estado) en la tabla (GrupoSecreto) 
*						por "Cancelado", Esto solo puede ocurrir antes de que 
*						la (fechaFin) del Grupo Secreto a cancelar sea igual a 
*						la fecha actual del sistema. 
*
*/
DELIMITER $$
CREATE PROCEDURE `Cancelar_GrupoSecreto` 
					(IN Var_idGrupo INT, IN Var_idAdministrador INT)
BEGIN
	DECLARE Var_FechaFin DATE DEFAULT DATE_FORMAT(NOW(),'%Y/%m/%d');
	DECLARE Var_FechaActual DATE DEFAULT DATE_FORMAT(NOW(),'%Y/%m/%d');

	SELECT FechaFin INTO Var_FechaFin 
		FROM GRUPOSECRETO 
        WHERE IdGrupo = Var_idGrupo AND
				Usuario_IdUsuario = Var_idAdministrador;
	
	IF  Var_FechaActual < Var_FechaFin THEN
		UPDATE GRUPOSECRETO
			SET Estado = 'Cancelado'
		WHERE idGrupo = Var_idGrupo AND
			   IdAdministrador = Var_idAdministrador;
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'El Grupro-Secreto no se puede cancelar porque ya
							se llego acabo o se esta realizando actualmente';
    END IF;		
END $$
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!


/**
* Generar_Amigo_Secreto:	
*						Verifica que tipo de grupo es el que se creo. Si es
*						Enpareja o Aleatorio, para luego mandar a ejecutar
*						el procedimiento que ingresar a los usuario en regala
*/
DELIMITER //
CREATE PROCEDURE Generar_Amigo_Secreto
				(in idgrup integer,in idadmin integer)
BEGIN
	DECLARE maxima int;
		SELECT (CantMaxUser/2) into maxima 
			FROM gruposecreto 
			WHERE gruposecreto.IdGrupo = idgrup;
        
        if (select VerificarCompletos(idgrup) = 1) then
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Generar_Amigo_Secreto: El Grupo No Esta Todavia Lleno';
		end if;    
		if (select VerificarTipoGrupo(idgrup)) = 1 then			
				call EmparejarAleatorios(idgrup,idadmin,maxima);
		elseif
			(select VerificarTipoGrupo(idgrup)) = 0 then
				call EmparejarParejas(idgrup,idadmin);
		end if;

END //
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!


/*================================
		FUNCTIONS
==================================*/

/**
* Usuario_Es_Amigo:	
*						Verifica que el usuario que se desea ingresar
*						esta en la lista de amigos del creador del Grupo.
*						Si Es asi devuelve 1
*						Sino devuelve 0
*/
DELIMITER //
CREATE FUNCTION `Usuario_Es_Amigo` 
					(idadmin INT,idamigo integer) returns integer
BEGIN
	DECLARE Var_Esta int;
	
    SELECT count(IdAmigo) INTO Var_Esta
		FROM ES_AMIGO
		WHERE ES_AMIGO.IdUsuario = idadmin AND
				ES_AMIGO.IdAmigo	= idamigo;
	
    return Var_Esta;   
END //
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!

/**
* VerificarTipoGrupo:	
*						Verifica el tipo de grupo 
*						Si Es Aleatorio devuelve 1
*						Sino Si es EnPareja devuelve 0
*/
DELIMITER //
CREATE FUNCTION `VerificarTipoGrupo` 
					(idgrupo integer) returns integer
BEGIN
	DECLARE Var_TipoGrupo VARCHAR(20);
	Select TipoGrupo into Var_TipoGrupo 
		from gruposecreto 
        where gruposecreto.IdGrupo = idgrupo;
    
	if 	Var_TipoGrupo Like 'Aleatorio' then
		return 1;
    elseif    
		Var_TipoGrupo Like 'En Pareja' then
			return 0;   
    end if;
    
END //
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!

/**
* VerificarCompletos:	
*						Verifica Si el Grupo No Esta Completo
*						Si no Esta Completo devuelve 1
*						sino devuelve 0
*/
DELIMITER //
CREATE FUNCTION `VerificarCompletos` 
				(idgrup integer) returns integer
BEGIN
	declare actual int;
    declare maximo int;
    select  CantActUser into actual from gruposecreto 		where IdGrupo = idgrup;
    select  CantMaxUser into maximo from gruposecreto 	where IdGrupo = idgrup;
	if (actual) < (maximo) then
		return 1;
	end if;
    return 0;
END //
delimiter ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!
/**
* VerificarEstadoUsuario:	
*						Verifica el estado del usuario 
*						Si esta Ocupado devuelve 1
*						Si esta Disponible devuelve 0
*/
DELIMITER //
CREATE FUNCTION `VerificarEstadoUsuario` 
					(iduser integer) returns integer
BEGIN
	DECLARE Var_EstadoUser VARCHAR(20);
	Select estado into Var_EstadoUser 
		from USUARIO 
        where USUARIO.IdUsuario = iduser;
    
	if 	Var_EstadoUser Like 'Ocupado' then
		return 1;
    elseif    
		Var_EstadoUser Like 'Disponible' then
			return 0;   
    end if;
    
END //
DELIMITER ;
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!
