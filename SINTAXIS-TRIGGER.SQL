	create or replace TRIGGER
	<nombre de trigger>
	before | after operacion [OR
	operacion.. ] [OF campo, ... campo]
	ON <nombre_tabla>
	REFERENCIMG new| old AS <alias>
	[for each row] [when (condicion)]
	DECLARE
	BEGIN
	
	END;
	
	EJEMPLO
	
	-- CADA ve que se inserta un linea de detalle en la factura..
	-- resta del stock porque esta vendiendo un artigulo..
	
	CREATE OR REPLACE TRIGGER
	actualizar_stock AFTER INSERT ON
	b_detalle_ventas
	FOR EACH ROW WHEN (new.cantidad>0)
	DECLARE
	BEGIN
		update b_articulos set
		stock_actual=stock_actual -
		: new.cantidad
		where id=:new.id_articulo;
	
	END;
	/
	
	-- Creación del trigger sobre la tabla ‘VENDEDOR’
	
	CREATE OR REPLACE TRIGGER T_CONTROL_DML
		AFTER INSERT OR UPDATE OR DELETE ON 
		vendedor
		DECLARE
		tipo CHAR(1);
		V_ID NUMBER;
	BEGIN
		IF INSERTING THEN
			tipo:= 'I';
			V_ID:= :NEW.ID;
		IF UPDATING THEN
			tipo:= 'U';
		IF DELETING THEN
			tipo:= 'D';
			V_ID := :OLD.ID;
		END IF;
			INSERT INTO control_abm VALUES(
		SYSDATE, Tipo, User, V_ID);
	END T_CONTROL_DML;
	/
	
		CREATE OR REPLACE TRIGGER
	actualizar_stock_del AFTER INSERT ON
	b_detalle_ventas
	FOR EACH ROW WHEN (old.cantidad>0)
	DECLARE
	BEGIN
		update b_articulos set
		stock_actual=stock_actual +
		:OLD.cantidad
		where id:=OLD.id_articulo;
	END;
	/
	
	
	CREATE OR REPLACE TRIGGER
	AFTER INSERT, UPDATE, DELETE ON
	b_detalle_ventas 