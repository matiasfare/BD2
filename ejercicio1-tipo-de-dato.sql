-- ejercicio 1 de tipo de datos

-- 1.Cree el procedimiento P_ESTADISTICA_ARTICULOS de la siguiente manera:
-- Cree  el tipo de dato  (registro) denominado r_articulosconformadopor los siguientes campos:
-- id_articulo
-- Nombre_articulo
-- Monto_compras
-- Monto_ventas
-- Cree una tabla indexada cuyos componentes sean datos del tipo r_articulos
-- Llene la tabla con los datos de compras y ventas de artículos durante el 2011 
-- En un ciclo FOR... LOOP, imprima el contenido de la tabla.

CREATE OR REPLACE PROCEURE P_ESTADISTICA_ARTICULOS 
	IS
		CURSOR C_ART IS
		SELECT A.ID,A.NOMBRE, Compras.MONTO_COMPRAS, Ventas.MONTO_VENTAS
		FROM B_ARTICULOS
		LEFT OUTER JOIN
		(SELECT D.ID_ARTICULO, SUM(D.CANTIDAD * D-PRECIO_COMPRA)
	MONTO_COMPRAS
		FROM B_DETALLE_COMPRAS D JOIN B_COMPRAS C 
		ON C.ID = D.ID_COMPRA
		WHERE EXTRACT(YEAR FROM C.FECHA) = 2011
		GROUP BY D.ID_ARTICULO) Compras
		ON Compras.id_articulo = a.id 
		(SELECT D.ID_ARTICULO, SUM(D.CANTIDAD * D-PRECIO_COMPRA)
	MONTO_VENTAS
		FROM B_DETALLE_VENTAS D JOIN B_VENTAS C 
		ON C.ID = D.ID_VENTA
		WHERE EXTRACT(YEAR FROM C.FECHA) = 2011
		GROUP BY D.ID_ARTICULO) Ventas
		ON Ventas.id = a.id;
	
		TYPE R_ART IS RECORD
		(ID_ARTICULO NUMBER(8),
		 NOMBRE VARCHAR(60),
		 MONTO_COMPRAS NUMBER(12),
	     MONTO_VENTAS(12)),
		TYPE T_ART  IS TABLE OF R_ART
			INDEX BY BINARY_INTEGER;
		V_ART T_ART;
		IND NUMBER;
	BEGIN
		FOR REG IN C_ART LOOP
			V_ART(REG.ID).ID_ARTICULO   := REG.ID;
			V_ART(REG.ID).NOMBRE 	    := REG.NOMBRE;
			V_ART(REG.ID).MONTO_COMPRAS := REG.MONTO_COMPRAS;
			V_ART(REG.ID).MONTO_VENTAS  := REG.MONTO_VENTAS;
		END LOOP;
		IND := V_ART.FIRST;
		WHILE IND <= V_ART.LAST LOOP
			DBMS_OUTPUT.PUT_LINE('Art'||to_char(V_ART(IND).ID_ARTICULO,'000000000') ||'-'|| V_ART(IND).NOMBRE);
			IND := V_ART.NEXT(IND);
		END LOOP;
	END;
	/