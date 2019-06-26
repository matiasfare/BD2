CREATE OR REPLACE PROCEDURE elim_articulo
	(p_id_articulo IN b_articulos.id%TYPE) IS
	v_id b_articulos.id%TYPE;
BEGIN
 /*verifico antes si no tengo registro de ventas*/
	BEGIN
		SELECT id_articulo INTO v_id
		FROM b_detalle_ventas
		WHERE id_articulo = p_id_articulo
		AND ROWNUM = 1;
	EXCEPTION
		WHEN NO_DATA_FOUNT THEN
		--No existen vetas, por lo tanto no puedo borrar--
			DELETE FROM b_articulosWHERE id = p_id_articulo;
			COMMIT;
	END;
EXCEPTION
	WHEN OTHERS THEN
	 ROLLBACK;
		DBMS_OUTPUT.PUT_LINE ('Error inesperado');
END elim_articulo;