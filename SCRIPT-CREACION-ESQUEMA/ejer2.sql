--1)
select SUBSTR(FILE_NAME,INSTR(FILE_NAME,"/", -1,1) +1 ) AS FILE_DB 
FROM DBA_DATA_FILES;
--1)
select SUBSTR(FILE_NAME,0, INSTR(FILE_NAME,'/',-1,1)) from dba_data_files;

--2)
SELECT 
A.nombre_area,
B.NOMBRE ||' '|| B.APELLIDO "nombre y apellido",
C.FECHA_INI fecha_Ingreso,
D.NOMBRE_CAT categoria,
FROM B_POSICON_ACTUAL C A JOIN B_AREAS A
ON A.ID_AREA = C.ID JOIN B.EMPLEADOS B
ON B.CEDULA = C.CEDULA JOIN B_CATEGORIAS_SALARIALES D
ON D.COD_CATEGORIA = B.COD_CATEGORIA
WHERE C.FECHA_FIN IS NULL
	AND D.FECHA_FIN
order by A.nombre_area,B.apellido
;

--3)
Select 
		A.ID ID_ASIENTO,
		B.FECHA, 
		B.CONCEPTO,
		A.NRO_LINEA,
		C.CODIGO_CTA,
		C.NOMBRE_CTA,
		DECODE(A.DEBE_HABER,'D',A.IMPORTE,0) MONTO_DEBITO,
		DECODE(A.DEBE_HABER,'C',A.IMPORTE,0) MONTO_CREDITO
FROM B_DIARIO_DETALLE A 
JOIN B_DIARIO_CABECERA B ON B.ID = A.ID
JOIN B_CUENTAS C ON C.CODIGO_CTA = A.CODIGO_CTA
WHERE EXTRACT(MONTH FROM B.FECHA) = 1
AND  EXTRACT(YEAR FROM B.FECHA) = 2012;

-- EJERCICIO 4
--4. Algunos empleados de la empresa son también clientes. Obtenga dicha 
--lista a través de una operación de intersección. Liste cédula, nombre y 
--apellido, teléfono. Tenga en cuenta sólo a las personas físicas (F) que 
--tengan cédula. Recuerde que los tipos de datos para operaciones del álgebra 
--relacional tienen que ser los mismos.
SELECT TO_CHAR(E.CEDULA) CEDULA, E.NOMBRE ||' '|| E.APELLIDO NOMBRE, E.TELEFONO 
FROM B_EMPLEADOS E
  INTERSECT
SELECT P.CEDULA, P.NOMBRE ||' '|| P.APELLIDO AS NOMBRE, P.TELEFONO 
FROM B_PERSONAS P
WHERE P.TIPO_PERSONA LIKE 'F' 
  AND P.CEDULA IS NOT NULL;
  
 --4)
 SELECT TO_CHAR (E.CEDULA)
 
  
-- EJERCICIO 5
--5. Se pretende realizar el aumento salarial del 5% para todas las categorías. 
--Debe listar la categoría (código y nombre), el importe actual, el importe 
--aumentado al 5% (redondeando la cifra a la centena), y la diferencia.
--Formatee la salida para que los montos tengan los puntos de mil.
SELECT COD_CATEGORIA, NOMBRE_CAT, 
    TO_CHAR(ASIGNACION, '999,999,999') AS IMPORTE_ANTERIOR, 
    TO_CHAR(ROUND(ASIGNACION*1.05, 2), '999,999,999') AS IMPORTE_NUEVO,
    TO_CHAR(ROUND(ASIGNACION*1.05, 2) - ASIGNACION, '999,999,999') AS DIFERENCIA
FROM B_CATEGORIAS_SALARIALES;
