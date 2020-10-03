/*
Input any number to generate following series.
1 4 9 16 25 36 ……
1 2 4 8 16 32 64 ……
*/

DECLARE
   n INTEGER:=:n;
   i INTEGER;
BEGIN
   FOR i IN 1..n LOOP
      dbms_output.Put((i*i)||' ');
   END LOOP;
   dbms_output.put_line(' ');
END;

DECLARE
   n INTEGER:=:n;
   i INTEGER;
BEGIN
   FOR i IN 0..n LOOP
      dbms_output.Put(POWER(2,i)||' ');
   END LOOP;
   dbms_output.put_line(' ');
END;
/