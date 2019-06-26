-- TEMA 2
CREATE OR REPLACE TYPE T_CIERRE AS OBJECT(
	ID_CUENTA NUMBER(8),
	FECHA_INICIO DATE,
	FECHA_CIERRE DATE,
	CREDITOS NUMBER(15),
	DEBITOS NUMBER(15),
	SALDO NUMBER(15),
	MONTO_INTERES NUMBER(15),
	MEMBER PROCEDURE CALCULAR_SALDO_PERIODO(P_ID_CUENTA NUMBER, P_FECHA_INICIO DATE, P_FECHA_CIERRE DATE),
	MEMBER PROCEDURE CALCULAR_INTERES(P_ID_CUENTA NUMBER) 
);
/

CREATE OR REPLACE TYPE BODY T_CIERRE AS 
	MEMBER PROCEDURE CALCULAR_SALDO_PERIODO(P_ID_CUENTA NUMBER, P_FECHA_INICIO DATE, P_FECHA_CIERRE DATE)
	IS
		BEGIN
			
			SELF.ID_CUENTA := P_ID_CUENTA;
			SELF.FECHA_INICIO := P_FECHA_INICIO;
			SELF.FECHA_CIERRE := P_FECHA_CIERRE;
			
			SELECT SUM(MC.IMPORTE) INTO CREDITOS
			FROM AHO_MOVIMIENTOS_CUENTA MC
			WHERE MC.ID_CUENTA = P_ID_CUENTA
				AND MC.ID_TIPO IN (SELECT ID_TIPO FROM AHO_TIPO_MOVIMIENTO WHERE DEBITO_CREDITO LIKE '%C%')
				AND TRUNC(MC.FECHA_MOVIMIENTO) BETWEEN TRUNC(P_FECHA_INICIO) AND TRUNC(P_FECHA_CIERRE);
			
			SELECT SUM(MC.IMPORTE) INTO DEBITOS
			FROM AHO_MOVIMIENTOS_CUENTA MC
			WHERE MC.ID_CUENTA = P_ID_CUENTA
				AND MC.ID_TIPO IN (SELECT ID_TIPO FROM AHO_TIPO_MOVIMIENTO WHERE DEBITO_CREDITO LIKE '%D%')
				AND TRUNC(MC.FECHA_MOVIMIENTO) BETWEEN TRUNC(P_FECHA_INICIO) AND TRUNC(P_FECHA_CIERRE);
			
			SELF.SALDO := CREDITOS - DEBITOS;
			SELF.MONTO_INTERES := 0;
		END;
		MEMBER PROCEDURE CALCULAR_INTERES(P_ID_CUENTA NUMBER)
		IS
		
		BEGIN
			
			DBMS_OUTPUT.PUT_LINE('ABC');
		END;
END;
/