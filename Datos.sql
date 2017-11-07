
/*================================
		DATOS
==================================*/
INSERT INTO USUARIO VALUES
(null,25311318,'Lara','Ruiz',20,'Villa Colombia','0414-8679805','josesl3eer3@gmail.com','123456','Disponible','M'),
(null,26081328,'Antony','Rocha',23,'Villa Colombia','0414-8679855','josesleer6@gmail.com','123456','Disponible','M'),
(null,25421225,'Margaret','Gonzales',21,'Villa Colombia','0414-8979855','josesleit2er4@gmail.com','123456','Disponible','F'),
(null,25531127,'Robert','Puleo',19,'Villa Colombia','0414-8679855','jo1sesle5@gmail.com','123456','Disponible','M'),
(null,26041328,'Julio','Rocha',18,'Villa Colombia','0414-8679855','josesle22er6@gmail.com','123456','Disponible','M'),
(null,25581127,'Paulo','Puleo',23,'Villa Colombia','0414-8679855','josesle5@gmail.com','123456','Disponible','M'),
(null,25081225,'jose','rios',25,'Villa Colombia','0414-8679855','josesleiter@gmail.com','123456','Disponible','M'),
(null,25081127,'Alfredo','Tochon',24,'Villa Colombia','0414-8679855','josesle@gmail.com','123456','Disponible','M'),
(null,25081328,'Beatriz','Aviles',22,'Villa Colombia','0414-8679855','josesleer@gmail.com','123456','Disponible','F'),
(null,25081435,'Veronica','Tochon',23,'Villa Colombia','0414-8679855','josesleitr@gmail.com','123456','Disponible','F'),
(null,22181225,'Maria','Ramos',33,'Villa Colombia','0414-8679255','josesleiter1@gmail.com','123456','Disponible','F'),
(null,25281127,'Carmen','Suarez',30,'Villa Colombia','0414-8619855','josesle2@gmail.com','123456','Disponible','F'),
(null,25381328,'Julia','Ruiz',28,'Villa Colombia','0414-8679805','josesleer3@gmail.com','123456','Disponible','F'),
(null,25481225,'Maria','Gonzales',22,'Villa Colombia','0414-8979855','josesleiter4@gmail.com','123456','Disponible','F'),
(null,27081225,'Luis','Lara',27,'Villa Colombia','0414-8679865','josesleiter7@gmail.com','123456','Disponible','M'),
(null,25311328,'Lara','Ruiz',26,'Villa Colombia','0414-8679805','josesll3eer3@gmail.com','123456','Disponible','F'),
(null,25422225,'Margaret','Gonzales',30,'Villa Colombia','0414-8979855','josesleit5er4@gmail.com','123456','Disponible','F'),
(null,25531137,'Robert','Puleo',32,'Villa Colombia','0414-8679855','josssesle5@gmail.com','123456','Disponible','M'),
(null,26141328,'Julio','Rocha',25,'Villa Colombia','0414-8679855','josesle2er6@gmail.com','123456','Disponible','M'),
(null,28081117,'Marcos','Ventura',27,'Villa Colombia','0414-8659855','josesle8@gmail.com','123456','Disponible','M');

INSERT INTO GrupoSecreto
  (IdGrupo,
  NombreGrupo,
  IdAdministrador,
  TipoGrupo,
  LimitePrecioA,
  LimitePrecioB,
  Estado,
  CantMaxUser,
  CantActUser,
  CantActHombres,
  CantActMujeres,
  FechaIni,
  FechaFin) VALUES
(null,'Reencuentro 2',2,'Aleatorio','10','50','En Curso',12,0,0,0,"2017/09/13","2017/09/17"),
(null,'Feliz Navidad',1,'En Pareja','10','50','En Curso',12,0,0,0,"2017/08/17","2017/09/17"),
(null,'Reencuentro',2,'Aleatorio','10','50','En Curso',12,0,0,0,"2017/08/12","2017/09/17"),
(null,'Una Fiesta loca',1,'En Pareja','10','50','En Curso',12,0,0,0,"2017/11/04","2017/11/05"),
(null,'Reunion de Navidad Parte2',1,'En Pareja','10','50','En Curso',12,0,0,0,"2017/11/04","2017/11/05");

INSERT INTO ADMINISTRADORTIENDA VALUE
(22,'Sleiter','Rios','25081225','josesleiterrios@gmail.com','123456');

INSERT INTO TIENDA VALUE 
(NULL,22,'Tu casa','Puerto Ordaz','0414-8675243'),
(NULL,22,'La Abuelita','Puerto Ordaz','0412-4675342'),
(NULL,22,'Tu tienda','Puerto Ordaz','0416-1212243'),
(NULL,22,'Todo cosas','Puerto Ordaz','0424-4361343'),
(NULL,22,'El Perolero','Puerto Ordaz','0414-2673243');

INSERT INTO PRODUCTO VALUE
(NULL,'Reloj','','$20'),
(NULL,'Cartera','','$25'),
(NULL,'Torta','','$25');

CALL Add_amigo(2,1);
CALL Add_amigo(2,2);
CALL Add_amigo(2,3);
CALL Add_amigo(2,4);
CALL Add_amigo(2,5);
CALL Add_amigo(2,6);
CALL Add_amigo(2,7);
CALL Add_amigo(2,8);
CALL Add_amigo(2,9);
CALL Add_amigo(2,10);
CALL Add_amigo(2,11);
CALL Add_amigo(2,12);
CALL Add_amigo(2,15);
CALL Add_amigo(2,16);
CALL Add_amigo(2,17);
CALL Add_amigo(2,18);
CALL Add_amigo(1,1);
CALL Add_amigo(1,3);
CALL Add_amigo(1,4);
CALL Add_amigo(1,5);
CALL Add_amigo(1,6);
CALL Add_amigo(1,7);
CALL Add_amigo(1,8);
CALL Add_amigo(1,9);
CALL Add_amigo(1,10);
CALL Add_amigo(1,11);
CALL Add_amigo(1,12);
CALL Add_amigo(1,13);
CALL Add_amigo(1,14);
CALL Add_amigo(1,15);
CALL Add_amigo(1,16);
CALL Add_amigo(1,17);
CALL Add_amigo(1,18);

INSERT INTO PARTICIPA VALUES
(1,2,1),
(1,2,2),
(1,2,3),
(1,2,4),
(1,2,5),
(1,2,6),
(1,2,7),
(1,2,8),
(1,2,9),
(1,2,10),
(1,2,11),
(1,2,12)
,
(2,1,1),
(2,1,2),
(2,1,4),
(2,1,5),
(2,1,6),
(2,1,3),
(2,1,9),
(2,1,10),
(2,1,11),
(2,1,12),
(2,1,13),
(2,1,7)
,
(3,2,1),
(3,2,2),
(3,2,3),
(3,2,4),
(3,2,15),
(3,2,6),
(3,2,17),
(3,2,18),
(3,2,12),
(3,2,16),
(3,2,11),
(3,2,10)
,
(4,1,1),
(4,1,2),
(4,1,3),
(4,1,4),
(4,1,15),
(4,1,6),
(4,1,17),
(4,1,18),
(4,1,12),
(4,1,16),
(4,1,11),
(4,1,10);


call Generar_Amigo_Secreto(1,2);
call Generar_Amigo_Secreto(2,1);

select * from regala;
