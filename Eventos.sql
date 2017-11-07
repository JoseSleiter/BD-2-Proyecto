SET GLOBAL event_scheduler=ON;

/*================================
		EVENTOS
==================================*/
/**
* Actualizar_Estado_GrupoSecreto:			
*									Llama al procedimiento "Finalizar_GrupoSecreto" cada
*									dia del año para verificar que Grupo Secreto ya finalizo.
*									Y actualizar el (estado) del registro correspondiente a
*									"Finalizo".	
* TABLA: GRUPOSECRETO
* EVENTO: CADA DIA DEL AÑO
*/
DELIMITER $$
CREATE EVENT `Actualizar_Estado_GrupoSecreto`
ON SCHEDULE EVERY 1 MINUTE -- 1 DAY 
DO 
BEGIN
SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'run_event started';
  CALL Finalizar_GrupoSecreto();
  SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'run_event finished';
END $$
-- !!===================================================================================!!
-- !!======================================FIN==========================================!!
-- !!===================================================================================!!
