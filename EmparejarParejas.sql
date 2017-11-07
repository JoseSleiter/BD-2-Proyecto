DELIMITER ;;
CREATE PROCEDURE `EmparejarParejas`(in idgrup int,in idadmin int)
BEGIN
	declare ida,idb,idc,idd int;
	declare done int default 0;

-- Crear Cursor
	declare hombres cursor for
	select usuario.IdUsuario from participa,gruposecreto,usuario
		where 	participa.IdParticipante = usuario.IdUsuario	AND
				participa.IdGrupo        = idgrup AND
				gruposecreto.IdGrupo     = idgrup AND
				usuario.sexo = "M"           
	order by rand();

-- Crear Cursor
	declare mujeres cursor for
	select usuario.IdUsuario from participa,gruposecreto,usuario
		where 	participa.IdParticipante = usuario.IdUsuario	and
				participa.IdGrupo        = idgrup AND
				gruposecreto.IdGrupo     = idgrup AND
			usuario.sexo = "F"
	order by rand();

-- Crear Cursor
	declare hombres2 cursor for
	select usuario.IdUsuario from participa,gruposecreto,usuario
		where 	participa.IdParticipante = usuario.IdUsuario	and
				participa.IdGrupo        = idgrup AND
				gruposecreto.IdGrupo     = idgrup AND
			usuario.sexo = "M"
	order by rand() ;

-- Crear Cursor
	declare mujeres2 cursor for
	select usuario.IdUsuario from participa,gruposecreto,usuario
		where 	participa.IdParticipante    = usuario.IdUsuario	and
				participa.IdGrupo 			= idgrup AND    
				gruposecreto.IdGrupo        = idgrup AND
			usuario.sexo = "F"
	order by rand() ;

	declare continue handler for not found set done = 1;

open hombres;
open mujeres;
open hombres2;
open mujeres2;

	conhombres : loop

		fetch hombres into ida;
		fetch mujeres into idb;
		fetch hombres2 into idc;
		fetch mujeres2 into idd;
    
		if done = 1 then
			leave conhombres;
		end if;
    
		insert into regala (IdRegalador,IdRecibidor,IdGrupo,IdAdministrador) values (ida,idb,idgrup,idadmin);
		insert into regala (IdRegalador,IdRecibidor,IdGrupo,IdAdministrador) values (idd,idc,idgrup,idadmin);
    
	end loop conhombres;

close hombres;
close mujeres;
close hombres2;
close mujeres2;
END ;;