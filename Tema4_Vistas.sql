/*TEMA 4 */

CREATE MATERIALIZED VIEW V_HORARIO
BUILD IMMEDIATE
REFRESH NEXT SYSDATE +6/24 
AS
SELECT FI.NOMBRE||''||FI.APELLIDO FISIOTERAPEUTA,
DECODE(HOR.HORA_INICIO, '07:00', PAC.APELLIDO, '-') "07:00",
DECODE(HOR.HORA_INICIO, '08:00', PAC.APELLIDO, '-') "08:00",
DECODE(HOR.HORA_INICIO, '09:00', PAC.APELLIDO, '-') "09:00",
DECODE(HOR.HORA_INICIO, '10:00', PAC.APELLIDO, '-') "10:00",
DECODE(HOR.HORA_INICIO, '11:00', PAC.APELLIDO, '-') "11:00",
DECODE(HOR.HORA_INICIO, '12:00', PAC.APELLIDO, '-') "12:00",
DECODE(HOR.HORA_INICIO, '13:00', PAC.APELLIDO, '-') "13:00",
DECODE(HOR.HORA_INICIO, '14:00', PAC.APELLIDO, '-') "14:00",
DECODE(HOR.HORA_INICIO, '15:00', PAC.APELLIDO, '-') "15:00",
DECODE(HOR.HORA_INICIO, '16:00', PAC.APELLIDO, '-') "16:00",
DECODE(HOR.HORA_INICIO, '17:00', PAC.APELLIDO, '-') "17:00",
DECODE(HOR.HORA_INICIO, '18:00', PAC.APELLIDO, '-') "18:00"
FROM TRATAMIENTO TRA
JOIN PACIENTE PAC
	ON TRA.CEDULA = PAC.CEDULA
JOIN FISIOTERAPEUTA FI
	ON TRA.COD_FISIOTERAPEUTA = FI.COD_FISIOTERAPEUTA
JOIN HORARIO HOR
	ON TRA.NRO_TURNO = HOR.NRO_TURNO
WHERE TRA.FECHA_FIN IS NULL AND TRUNC(TRA.FECHA_INICIO) <= TRUNC(SYSDATE);