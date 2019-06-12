CREATE OR REPLACE TYPE T_SESION AS OBJECT (
	FECHORA_INI DATE,
	FECHORA_FIN DATE,
	MEMBER FUNCTION VALIDAR_HORARIO(ID number) return boolean
	);
	/

CREATE OR REPLACE TYPE BODY T_SESION AS
	MEMBER FUNCTION VALIDAR_HORARIO (ID number) return boolean
	IS
	B BOOLEAN:=FALSE,
	V_FECH_INI DATE, --VARIABLE PARA FECHA_INICIO
	V_FECH_FIN DATE, --VARIABLE PARA FECHA_FIN
	VAR NUMBER, --PARA GUARDAR CUALQUIER VALOR NUMERICO QUE NECESITE
		
BEGIN
	SELECT 
		T.FECHA_FIN,
		H.HORA_INICIO,
		T.FECHA_INICIO 
			INTO V_FECH_FIN,V_HORA_INI,V_FECH_INI
	FROM TRATAMIENTO T 
	JOIN HORARIO H ON T.NRO_TURNO=H.NRO_TURNO 
	WHERE T.ID_TRATAMIENTO=ID;
	
	
	IF V_FECH_FIN IS NULL THEN --1.A Que la FECHA_FIN del tratamiento no est� a�n asignada.
		VAR := (FECHORA_INI - V_FECH_INI);
		IF FECHORA_INI >= V_FECH_INI  THEN  --1.B Que el atributo FECHORA_INI sea igual o mayor a la fecha de inicio del tratamiento.
			IF
        ELSE
        dbms_output.put_line('FECHORA_INI es distinto o menor a la fecha de inicio del tratamiento.');
    ELSE
        dbms_output.put_line('la FECHA_FIN del tratamiento no est� a�n asignada.');

    SELECT 
		T.FECHA_FIN,
		H.HORA_INICIO,
		TO_CHAR(T.FECHA_INICIO, 'HH24:MI') 
	FROM TRATAMIENTO T 
	JOIN HORARIO H ON T.NRO_TURNO=H.NRO_TURNO 
	;		
			
		TO_CHAR(V_FECH_INI, 'HH 24:MI')
	
	