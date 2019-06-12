create or replace type T_SESION as object(
	fechora_ini DATE,
	fechora_fin DATE,
MEMBER FUNCTION validar_horario(id NUMBER) RETURN BOOLEAN
);
/

CREATE OR REPLACE TYPE BODY T_SESION AS
MEMBER FUNCTION validar_horario(id NUMBER) RETURN BOOLEAN
IS
V_FECH_FIN DATE;
V_FECH_INI DATE;
V_HORA_INI VARCHAR2(5);


BEGIN
SELECT T.FECHA_FIN,H.HORA_INICIO,T.FECHA_INICIO INTO V_FECH_FIN,V_HORA_INI,V_FECH_INI
FROM TRATAMIENTO T JOIN HORARIO H ON T.NRO_TURNO=H.NRO_TURNO WHERE T.ID_TRATAMIENTO=ID;
IF v_fech_fin IS NULL THEN
IF FECHORA_INI>=V_FECH_INI THEN
  IF TO_CHAR(V_FECH_INI, 'HH24:MI')=V_HORA_INI THEN
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
END;
/
---2---
CREATE OR REPLACE TYPE TAB_SESION IS VARRAY(20) OF T_SESION;
/

---3---
ALTER TABLE TRATAMIENTO ADD SESIONES TAB_SESION;
/