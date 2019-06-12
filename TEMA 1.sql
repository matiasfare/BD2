create or replace type T_SESSION as object(
	fechora_ini DATE,
	fechora_fin DATE,
MEMBER FUNCTION validar_horario(id_tratamiento NUMBER) RETURN BOOLEAN
);

create or replace type body T_SESSION IS
	MEMBER FUNCTION validar_horario (id_tratamiento NUMBER) RETURN BOOLEAN
	IS
		b BOOLEAN := FALSE;
		fecha_ini_tratamiento DATE;
		diff_fechas NUMBER;
		fecha_fin_tratamiento DATE;
	BEGIN
		SELECT
			t.fecha_inicio
		INTO
			fecha_ini_tratamiento
		FROM
			tratamiento t
		WHERE
			t.id_tratamiento = id_tratamiento;
		
		SELECT
			t.fecha_fin
		INTO
			fecha_fin_tratamiento
		FROM
			tratamiento t
		WHERE
			t.id_tratamiento = id_tratamiento;

		IF fecha_fin_tratamiento is NULL THEN
			diff_fechas := fechora_ini - fecha_ini_tratamiento;
			IF diff_fechas >= 0 THEN
				diff_fechas := fechora_fin - fechora_ini;
				IF diff_fechas > 0 THEN
					b := TRUE;
				ELSE
					b:= FALSE;
				END IF;
			ELSE
				b:= FALSE;
			END IF;
		ELSE
			b := FALSE;
		END IF;
		return b;
	END;
END;
/




--------------solucion de hugo----------

-----------------clase de refuerzo-------------

---TEMA 1----

--1--
CREATE OR REPLACE type T_SESION as object(
fechora_ini date,
fechora_fin date,
member function VALIDAR_HORARIO(id NUMBER) return boolean
);

CREATE OR REPLACE TYPE BODY T_SESION AS
MEMBER FUNCTION validar_horario( id NUMBER) RETURN BOOLEAN
IS
V_FECH_FIN DATE;
V_FECH_INI DATE;
V_HORA_INI VARCHAR2(5);


BEGIN
SELECT T.FECHA_FIN,H.HORA_INICIO,T.FECHA_INICIO INTO V_FECH_FIN,V_HORA_INI,V_FECH_INI
FROM TRATAMIENTO T JOIN HORARIO H ON T.NRO_TURNO=H.NRO_TURNO WHERE T.ID_TRATAMIENTO=ID;
IF v_fech_fin IS NULL THEN
IF FECHORA_INI>=V_FECH_INI THEN
  IF TO_CHAR(V_FECH_INI, 'HH 24:MI')=V_HORA_INI THEN
    IF FECHORA_FIN> FECHORA_INI AND FECHORA_FIN<TRUNC(FECHORA_FIN)+1 THEN
     DBMS_OUTPUT.PUT_LINE('CUMPLE CON LOS REQUISITOS');
     RETURN TRUE;
    ELSE
    DBMS_OUTPUT.PUT_LINE('NO CUMPLE');
    RETURN FALSE;
    END IF;
  ELSE
  DBMS_OUTPUT.PUT_LINE('NO CUMPLE');
  RETURN FALSE;
  END IF;
ELSE
DBMS_OUTPUT.PUT_LINE('NO CUMPLE');
RETURN FALSE;
END IF;
ELSE
DBMS_OUTPUT.PUT_LINE('NO CUMPLE');
RETURN FALSE;
END IF;
END;
---2---
CREATE OR REPLACE TYPE TAB_SESION IS VARRAY(20) OF T_SESION;

---3---
ALTER TABLE TRATAMIENTO ADD SESION TAB_SESION;