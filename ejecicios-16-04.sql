
---TEMA 6

alter table TRATAMIENTO
  add DIAGNOSTICO BLOB;
  
CREATE OR REPLACE DIRECTORY DIR_DIAGNOSTICO AS 'C:\Diagnostico';

CREATE OR REPLACE PROCEDURE P_ADJUNTAR_DIAGNOSTICO IS	
	CURSOR C_TRA IS		
		SELECT ID_TRATAMIENTO,CEDULA
		FROM TRATAMIENTO
		WHERE EXTRACT(YEAR FROM FECHA_INICIO)= EXTRACT(YEAR FROM SYSDATE) --CONDICION PARA EXTRAER EL AÑO DE UN TRATAMIENTO ACTUAL
		AND EXTRACT(MONTH FROM FECHA_INICIO )= EXTRACT(MONTH FROM SYSDATE )  --CONDICION PARA EXTRAER EL AÑO DE UN TRATAMIENTO ACTUAL
		;
	V_SENTENCIA VARCHAR2(200);
	V_FLOB BFILE;
	V_BLOB BLOB;

BEGIN


	FOR REG IN C_TRA LOOP
		V_SENTENCIA:=REG.ID_TRATAMIENTO||'_'||REG.CEDULA||'.pdf';
		V_FLOB := BFILENAME('DIR_DIAGNOSTICO',V_SENTENCIA);
		IF DBMS_LOB.FILEEXISTS(V_FLOB)=1 THEN 
			
			UPDATE TRATAMIENTO		
			SET DIAGNOSTICO=EMPTY_BLOB()
			WHERE ID_TRATAMIENTO=REG.ID_TRATAMIENTO
			RETURNING DIAGNOSTICO INTO V_BLOB;
			--DBMS_OUTPUT.PUT_LINE(V_SENTENCIA);--SOLO PARA VER QUE LA SENTENCIA ESTA BIEN CONCATENADA
		
			DBMS_LOB.FILEOPEN(V_FLOB,DBMS_LOB.FILE_READONLY);
			
			DBMS_LOB.LOADFROMFILE(V_BLOB, V_FLOB,DBMS_LOB.GETLENGTH(V_FLOB));
			DBMS_LOB.FILECLOSE(V_FLOB);
		END IF;
	END LOOP;

EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20001,'ERROR EN P_ADJUNTAR_DIAGNOSTICO'||SQLERRM);
END;
/

BEGIN
	P_ADJUNTAR_DIAGNOSTICO;
END;
/