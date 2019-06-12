---tema 1 by fare--
--se crea el objeto con sus atributos, se define el metodo y lo que retorna
CREATE OR REPLACE TYPE T_SESION AS OBJECT (
	FECHORA_INI DATE,
	FECHORA_FIN DATE,
	MEMBER FUNCTION VALIDAR_HORARIO(ID number) return boolean
	);
	/

CREATE OR REPLACE TYPE T_SESION AS OBJECT (
	FECHORA_INI DATE,
	FECHORA_FIN DATE,
	
BEGIN
	
