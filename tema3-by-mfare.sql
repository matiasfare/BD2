---tema3----
-- Implemente el siguiente control al INSERTAR o MODIFICAR en la tabla TRATAMIENTO:
-- Ni el fisioterapeuta ni el paciente, 
-- deben estar asignados a otro tratamiento NO FINALIZADO en el mismo horario (turno) 
-- durante la duración del tratamiento (Fecha Inicio - Fecha Fin) 
-- (Verifique que no haya problemas de tabla mutante).
-- La Fecha Fin de los tratamientos puede obtenerla mediante la función F_CALCULAR_FIN del paquete PKG_TRATAMIENTO.

CREATE OR REPLACE TRIGGER CONTROL_HORARIO
FOR INSERT OR UPDATE ON TRATAMIENTO COMPOUND TRIGGER

 TYPE T_TRA IS TABLE OF TRATAMIENTO%ROWTYPE INDEX BY BINARY_INTEGER;
 V_TRATAMIENTO T_TRA;
 V_FECHA_FIN DATE;
 INDICE NUMBER;
 --CURSOR C_TRATAMIENTOS IS SELECT * FROM TRATAMIENTO;
 CURSOR C_TRATAMIENTOS IS SELECT * FROM TRATAMIENTO WHERE FECHA_FIN IS NULL;
	
	BEFORE STATEMENT IS
	 BEGIN
		V_TRATAMIENTO.DELETE;
		FOR REG IN C_TRATAMIENTOS LOOP
			V_TRATAMIENTO(REG.ID_TRATAMIENTO).ID_TRATAMIENTO := REG.ID_TRATAMIENTO;
			V_TRATAMIENTO(REG.ID_TRATAMIENTO).CEDULA := REG.CEDULA;
			V_TRATAMIENTO(REG.ID_TRATAMIENTO).NRO_TURNO := REG.NRO_TURNO;
			V_TRATAMIENTO(REG.ID_TRATAMIENTO).COD_FISIOTERAPEUTA := REG.COD_FISIOTERAPEUTA;
            V_TRATAMIENTO(REG.ID_TRATAMIENTO).FECHA_INICIO := REG.FECHA_INICIO;
            V_TRATAMIENTO(REG.ID_TRATAMIENTO).FECHA_FIN := PKG_TRATAMIENTO.F_CALCULAR_FIN(REG.FECHA_INICIO, REG.NRO_SESIONES);
			END LOOP;
	END BEFORE STATEMENT;


BEFORE EACH ROW IS
BEGIN 

	V_FECHA_FIN:= PKG_TRATAMIENTO.F_CALCULAR_FIN(:NEW.FECHA_FIN,:NEW.NRO_SESIONES);
	
	INDICE := V_TRATAMIENTO.FIRST;
	
	WHILE INDICE <= V_TRATAMIENTO.LAST LOOP
		IF INSERTING OR UPDATING THEN
			--PACIENTE
			IF V_TRATAMIENTO(INDICE).CEDULA = :NEW.CEDULA AND V_TRATAMIENTO(INDICE).NRO_TURNO = :NEW.NRO_TURNO THEN
				IF V_TRATAMIENTO(INDICE).FECHA_INICIO >= :NEW.FECHA_INICIO AND V_TRATAMIENTO(INDICE).FECHA_FIN <= :NEW.FECHA_FIN
					THEN
						RAISE_APPLICATION_ERROR(-20067,'ERROR, YA TIENE TRATAMIENTO EN ESA FECHA');
				END IF;
			END IF;
			--TERAPEUTA
			IF V_TRATAMIENTO(INDICE).COD_FISIOTERAPEUTA = :NEW.COD_FISIOTERAPEUTA AND V_TRATAMIENTO(INDICE).NRO_TURNO = :NEW.NRO_TURNO THEN
				IF V_TRATAMIENTO(INDICE).FECHA_INICIO >= :NEW.FECHA_INICIO AND V_TRATAMIENTO(INDICE).FECHA_FIN <= :NEW.FECHA_FIN
					THEN
						RAISE_APPLICATION_ERROR(-20067,'ERROR,EL FISIOTRAPEUTA YA TIENE TRATAMIENTO EN ESA FECHA');
				END IF;
			END IF;
		END IF;
		INDICE := V_TRATAMIENTO.NEXT(INDICE);
	END LOOP;

 END BEFORE EACH ROW;
END;
/
