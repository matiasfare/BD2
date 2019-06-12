---tema2
CREATE OR REPLACE Function AGREGAR_DIAS (FECHORA_INI date, sesiones number)
   return date
IS

   v_counter number;
   fecha_actual date;
   v_day_number VARCHAR2(30);
   V_CONTADOR_FERIADO NUMBER;
BEGIN

   v_counter := 1;
   fecha_actual := FECHORA_INI;
   	
   
   while v_counter <= sesiones
   loop

      fecha_actual := fecha_actual + 1;
      v_day_number := TO_CHAR(fecha_actual, 'd');

      if v_day_number >= 2 and v_day_number <= 6 then
		 SELECT COUNT(DIA_FERIADO) INTO V_CONTADOR_FERIADO from FERIADO WHERE DIA_FERIADO=FECHA_ACTUAL;
		 IF V_CONTADOR_FERIADO=0 THEN
			v_counter := v_counter + 1;
         END IF;
      end if;

   end loop;

   RETURN fecha_actual;

EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
/

SET SERVEROUTPUT ON
begin
DBMS_OUTPUT.PUT_LINE(AGREGAR_DIAS(TO_DATE('09-JUN-2019'),9));
END;
/

PROCEDURE P_COMPLETAR_SESION(ID_TRATAMIENTO, FECHORA_INI y FECHORA_FIN),



