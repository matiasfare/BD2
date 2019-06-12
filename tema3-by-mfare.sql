---tema3----
-- Implemente el siguiente control al INSERTAR o MODIFICAR en la tabla TRATAMIENTO:
-- Ni el fisioterapeuta ni el paciente, 
-- deben estar asignados a otro tratamiento NO FINALIZADO en el mismo horario (turno) 
-- durante la duración del tratamiento (Fecha Inicio - Fecha Fin) 
-- (Verifique que no haya problemas de tabla mutante).
-- La Fecha Fin de los tratamientos puede obtenerla mediante la función F_CALCULAR_FIN del paquete PKG_TRATAMIENTO.

CREATE OR REPLACE TRIGGER CONTROL_HORARIO AFTER INSERT, UPDATE  
ON TRATAMIENTO
FOR EACH ROW WHEN 

DECLARE
V_ID_TRATAMIENTO NUMBER,
V_COD_FISIOTERAPEUTA NUMBER,
V_

BEGIN

	SELECT T.ID_TRATAMIENTO,F.COD_FISIOTERAPEUTA,T.NRO_SESIONES,T.FECHA_INICIO
		INTO V_ID_TRATAMIENTO, V_COD_FISIOTERAPEUTA, V_FECHA_INICIO, V_NRO_SESIONES
		FROM TRATAMIENTO T JOIN FISIOTERAPEUTA F
		ON T.COD_FISIOTERAPEUTA=F.COD_FISIOTERAPEUTA
	;
	IF NEW.FECHA_INICIO != V_FECHA_INICIO