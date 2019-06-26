--1.Para hacer export de una tabla b_personas en este caso
EXP BASEDATOS2/BASEDATOS2 TABLE=B_PERSONAS FILE=exp_per.dmp

/*
2.QUE OCURRE SI
SE CREA UNA TABLA CON LA ESTRUCTURA Y FILAS DE B_AREAS;
*/
CREATE TABLE B_AREAS_NUEVA AS
	SELECT  B.ID, B.NOMBRE_AREA, B.FECHA_CREA, B.ACTIVA, B.ID_AREA_SUPERIOR
	FROM B_AREAS B;

/*
3.
--2 sesiones por usuario
--5 minutos de tiempo limite
--3 intentos
*/
CREATE PROFILE perfile1 LIMIT
SESSIONS_PER_USER 2				
IDLE_TIME 5						
FAILED_LOGIN_ATTEMPTS 3;		

/*4.
No se ejecuta por un error porque B_ventas es una tabla padre
contraint error
*/
TRUNCATE TABLE B_VENTAS;

/*5.
Un alter table puede
borrar y agregar constraints como tambien agregar, modificar y eliminar columnas 
no puede agregar y modificar filas
*/
ALTER TABLE

/*

*/