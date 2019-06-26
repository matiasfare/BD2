--2)
desc b_tipo_cuenta;
desc b_personas;
desc b_diario_detalle;

--3)
select * from b_cuentas;

--4)
column nombre_cta format a20;

--5)
select * from b_cuentas
where NIVEL = &cnivel ;

--6)
--Defina la variable CNIVEL con valor 2 y ejecute de vuelta la sentencia:--5)

DEFINE cnivel = 2;
select * from b_cuentas
where NIVEL = &cnivel;

--7)
set pagesize 80;
 set linesize 300;
--8)

select id_venta, numero_cuota, monto_cuota from b_plan_pago
where extract(year from vencimiento)= 2011
;

--9)
select NOMBRE, CORREO_ELECTRONICO from b_personas
where tipo_persona = 'F' 
AND 
UPPER(correo_electronico) like'%GMAIL%'
OR
UPPER(correo_electronico) like'%HOTMAIL%' 
;

--10)
select distinct id from b_articulos
;

--11)
SELECT ID "Id Articulo", NOMBRE,
 UNIDAD_MEDIDA "Unidad de Medida", 
 PRECIO,
PORC_COMISION "% Comision",
 (&CANTIDAD * PRECIO) "SUB-TOTAL", 
((&CANTIDAD * PRECIO) * PORC_COMISION) "Comision"
FROM B_ARTICULOS;

--12)
SELECT COD_CATEGORIA, ID_AREA 
FROM B_POSICION_ACTUAL 
WHERE CEDULA IN ('1607843','2204219','3008180') 
AND 
FECHA_FIN IS NULL;


