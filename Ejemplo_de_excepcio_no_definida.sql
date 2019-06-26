DECLARE
	e_tiene_hijos EXCEPTION;
	PRAGMA EXCEPTION_INIT (e_tiene_hijos, -2292);
BEGIN
	DELETE FROM b_articulos WHERE id = %id;
	COMMIT;
EXCEPTION
	WHEN e_tiene_hijos THEN
		DBMS_OUTPUT.PUT.LINE ('no puede borrar; tiene 
		items que hacen referencia al articulos')
		END;
		/