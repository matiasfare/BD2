--ejercitario 11 
declare

-- declare variable first = 0, 
-- second = 1 and temp of datatype number 
first number := 0; 
second number := 1; 
temp number; 

n number := 5; 
i number; 

begin

	dbms_output.put_line('Series:'); 

--print first two term first and  
	dbms_output.put_line(first); 
	dbms_output.put_line(second); 

-- loop i = 2 to n 
	for i in 2..n 
	loop second
		temp:=first+second; 

first := second; 
second := temp; 

--print terms of fibonacci series 
	dbms_output.put_line(temp); 
end loop; 

end; 
--Program End 


CREATE OR REPLACE FUNCTION Fibo(n INTEGER) RETURNS DECIMAL(31, 0)
BEGIN
  DECLARE res DECIMAL(31, 0);
  CASE WHEN n = 0 THEN
         SET res = 0;
       WHEN n = 1 THEN
         SET res = 1;
       WHEN n > 1 THEN
         BEGIN
           DECLARE stmt STATEMENT;
           PREPARE stmt FROM 'SET ? = Fib(? - 1) + Fib(? - 2)';
           EXECUTE stmt INTO res USING n, n;
	 END;
       ELSE
         SIGNAL SQLSTATE '78000' SET MESSAGE_TEXT = 'Bad input';
  END CASE;
  RETURN res;
END;
/