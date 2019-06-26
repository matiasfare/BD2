----Ejemplo 2: DBMS_SQL con parámetros

CREATE OR REPLACE PROCEDUREP_INSERTAR_FILA(nom_tab VARCHAR2, pid NUMBER, pnom VARCHAR2) IS
v_cursor INTEGER;
v_sentencia VARCHAR2(200);
v_cantidad NUMBER;
BEGIN
v_sentencia := 'INSERT INTO ' || nom_tab || ' (ID, APELLIDO) VALUES (:cid, :cnom) ';
v_cursor := DBMS_SQL.OPEN_CURSOR;
DBMS_SQL.PARSE(v_cursor, v_sentencia, DBMS_SQL.NATIVE);
DBMS_SQL.BIND_VARIABLE(v_cursor, ':cid', pid);
DBMS_SQL.BIND_VARIABLE(v_cursor, ':cnom', pnom);
v_cantidad := DBMS_SQL.EXECUTE(v_cursor);
DBMS_SQL.CLOSE_CURSOR(v_cursor);
DBMS_OUTPUT.PUT_LINE(v_cantidad);
END;