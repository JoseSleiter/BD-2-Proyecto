DELIMITER ;;
CREATE PROCEDURE `EmparejarAleatorios`(in idgrup int,in idadmin int,in maximo int)
BEGIN
	declare ida,idb,idc,idd int;
	declare done int default 0;

	declare primeros cursor for
		select seis.p from (select usuario.IdUsuario as p from participa,gruposecreto,usuario
		where 	participa.IdParticipante = usuario.IdUsuario	and
				participa.IdGrupo        = idgrup and
				gruposecreto.IdGrupo     = idgrup		      
		order by usuario.ci ASC
		limit maximo) as seis
		order by rand();

	declare segundos cursor for
		select seis.p from (select usuario.IdUsuario as p from participa,gruposecreto,usuario
		where 	participa.IdParticipante = usuario.IdUsuario	and
				participa.IdGrupo        = idgrup and
				gruposecreto.IdGrupo     = idgrup	
		order by usuario.ci DESC
		limit maximo) as seis
		order by rand();

	declare primeros2 cursor for
		select seis.p from (select usuario.IdUsuario as p from participa,gruposecreto,usuario
		where 	participa.IdParticipante = usuario.IdUsuario	and
				participa.IdGrupo        = idgrup and
				gruposecreto.IdGrupo     = idgrup		
		order by usuario.ci ASC
		limit maximo) as seis
		order by rand();

	declare segundos2 cursor for
		select seis.p from (select usuario.IdUsuario as p from participa,gruposecreto,usuario
		where 	participa.IdParticipante = usuario.IdUsuario	and
				participa.IdGrupo        = idgrup and
				gruposecreto.IdGrupo     = idgrup		
		order by usuario.ci DESC
		limit maximo) as seis
		order by rand();

	declare continue handler for not found set done = 1;

open primeros;
open segundos;
open primeros2;
open segundos2;

	primerosu : loop

		fetch primeros into ida;
		fetch segundos into idb;
		fetch primeros2 into idc;
		fetch segundos2 into idd;
    
		if done = 1 then
			leave primerosu;
		end if;
    
		insert into regala (IdRegalador,IdRecibidor,IdGrupo,IdAdministrador) values (ida,idb,idgrup,idadmin);
		insert into regala (IdRegalador,IdRecibidor,IdGrupo,IdAdministrador) values (idd,idc,idgrup,idadmin);

	end loop primerosu;

close primeros;
close segundos;
close primeros2;
close segundos2;
END ;;
DELIMITER ;