CREATE OR REPLACE PACKAGE PKG_TRATAMIENTO IS
	FUNCTION F_CALCULAR_FIN(PACTUAL date, sesiones number) RETURN DATE;
	PROCEDURE P_COMPLETAR_SESION(PID_TRATAMIENTO NUMBER, FECHORA_INI DATE, FECHORA_FIN DATE);
END;
/

CREATE OR REPLACE PACKAGE BODY PKG_TRATAMIENTO IS
	FUNCTION F_CALCULAR_FIN(PACTUAL date, sesiones number) RETURN DATE IS
		v_counter number;
		v_fecha_actual date;
		v_day_number VARCHAR2(30);
		V_CONTADOR_FERIADO NUMBER;
	BEGIN
		--SELECT FECHA_INICIO, NRO_SESIONES INTO v_fecha_actual, sesiones
		--FROM TRATAMIENTO;
	   v_counter := 1;		
	   v_fecha_actual:=PACTUAL;
	   
	   while v_counter <= sesiones
	   loop

		  v_fecha_actual := v_fecha_actual + 1;
		  v_day_number := TO_CHAR(v_fecha_actual, 'd');

		  if v_day_number >= 2 and v_day_number <= 6 then
			 SELECT COUNT(DIA_FERIADO) INTO V_CONTADOR_FERIADO from FERIADO WHERE DIA_FERIADO=v_fecha_actual;
			 IF V_CONTADOR_FERIADO=0 THEN
				v_counter := v_counter + 1;
			 END IF;
		  end if;

	   end loop;

	   RETURN v_fecha_actual;

	EXCEPTION
	WHEN OTHERS THEN
	   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
	END;
	
	PROCEDURE P_COMPLETAR_SESION(PID_TRATAMIENTO NUMBER, FECHORA_INI DATE, FECHORA_FIN DATE) IS	
		
		V_NRO_SESIONES NUMBER;
		last_index number;	
		V_SESION T_SESION;
		V_SESIONES TAB_SESION;
		
	BEGIN
		SELECT SESIONES,NRO_SESIONES INTO V_SESIONES,V_NRO_SESIONES 
		FROM TRATAMIENTO WHERE ID_TRATAMIENTO=PID_TRATAMIENTO;
		
		last_index:=NVL(V_SESIONES.LAST,0);
		
		IF V_NRO_SESIONES=last_index THEN
			RAISE_APPLICATION_ERROR(-20031,'No pueden haber mas del numero de sesiones');
		END IF;
		
		last_index:=last_index+1;
		
		
		V_SESION:=T_SESION(FECHORA_INI,FECHORA_FIN);--
		
		IF V_SESION.validar_horario(PID_TRATAMIENTO) THEN
			
			if last_index = 1 then
				V_SESIONES:=TAB_SESION();
			end if;
			
			V_SESIONES.EXTEND;
			V_SESIONES(last_index):=V_SESION;
			
			UPDATE TRATAMIENTO
			SET SESIONES=V_SESIONES
			WHERE ID_TRATAMIENTO=PID_TRATAMIENTO;
			DBMS_OUTPUT.PUT_LINE('FUNCIONO');
			COMMIT;
		END IF;
	END;
	
END;
/


BEGIN
DBMS_OUTPUT.PUT_LINE(PKG_TRATAMIENTO.F_CALCULAR_FIN(TO_DATE('09-JUN-2019'),9));
END;
/

BEGIN
PKG_TRATAMIENTO.P_COMPLETAR_SESION(1200,SYSDATE-1, SYSDATE+2);
END;
/