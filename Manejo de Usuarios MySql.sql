
/*================================
		PERMISOS DE USUARIOS
==================================*/

-- Creo el Administrador y le asigno TODOS los PERMISOS del proyecto
CREATE USER 'admin'@'localhost' identified BY 'admin';
GRANT ALL ON proyecto.* to 'admin'@'localhost';
 
-- Creo al Usuario y Tiene como permisos sobre las tablas del Proyecto
-- CRUD en las tablas de : USUARIO, ES_AMIGO, GRUPOSECRETO Y LEGUSTA
-- CRD en las tablas: PARTICIPA
-- R en las tablas : PRODUCTO, TIENDA, REGALA
CREATE USER 'usuario'@'localhost' identified BY 'usuario';
GRANT SELECT,UPDATE(Ci,Nombre,Apellido,Edad,Direccion,Telefono,Correo,Clave,Estado,Sexo),INSERT ON TABLE proyecto.usuario to 'usuario'@'localhost';
GRANT SELECT,DELETE,INSERT ON TABLE proyecto.es_amigo to 'usuario'@'localhost';
GRANT SELECT,UPDATE(NombreGrupo,FechaFin),DELETE,INSERT ON TABLE proyecto.gruposecreto to 'usuario'@'localhost';
GRANT SELECT,UPDATE,DELETE,INSERT ON TABLE proyecto.legusta to 'usuario'@'localhost';
GRANT SELECT,DELETE,INSERT ON TABLE proyecto.participa to 'usuario'@'localhost';
GRANT SELECT ON TABLE proyecto.regala to 'usuario'@'localhost';
GRANT SELECT ON TABLE proyecto.producto to 'usuario'@'localhost';
GRANT SELECT ON TABLE proyecto.tienda to 'usuario'@'localhost';

GRANT EXECUTE ON PROCEDURE proyecto.Generar_Amigo_Secreto to 'usuario'@'localhost';
GRANT EXECUTE ON PROCEDURE proyecto.EmparejarAleatorios to 'usuario'@'localhost';
GRANT EXECUTE ON PROCEDURE proyecto.EmparejarParejas to 'usuario'@'localhost';
GRANT EXECUTE ON PROCEDURE proyecto.Cancelar_GrupoSecreto to 'usuario'@'localhost';
/*GRANT EXECUTE ON PROCEDURE proyecto.Add_User_GrupoSecreto to 'usuario'@'localhost';
GRANT EXECUTE ON PROCEDURE proyecto.Finalizar_GrupoSecreto to 'usuario'@'localhost';
GRANT EXECUTE ON PROCEDURE proyecto.Verificar_CantActUser_GrupoSecreto to 'usuario'@'localhost';
GRANT EXECUTE ON PROCEDURE proyecto.Delete_User_GrupoSecreto to 'usuario'@'localhost';
GRANT EXECUTE ON FUNCTION  proyecto.VerificarCompletos to 'usuario'@'localhost';
GRANT EXECUTE ON FUNCTION  proyecto.VerificarTipoGrupo to 'usuario'@'localhost';
*/

-- Creo el AdministradorTienda como permisos de las tablas del Proyecto:
-- CRUD en las tablas: TIENDA, ADMINISTRADORTIENDA, PRODUCTO Y POSEE
CREATE USER 'admintienda'@'localhost' identified BY 'admintienda';
GRANT SELECT,UPDATE,DELETE,INSERT ON TABLE proyecto.administradortienda to 'admintienda'@'localhost';
GRANT SELECT,UPDATE,DELETE,INSERT ON TABLE proyecto.tienda to 'admintienda'@'localhost';
GRANT SELECT,UPDATE,DELETE,INSERT ON TABLE proyecto.posee to 'admintienda'@'localhost';
GRANT SELECT,UPDATE,DELETE,INSERT ON TABLE proyecto.producto to 'admintienda'@'localhost';
