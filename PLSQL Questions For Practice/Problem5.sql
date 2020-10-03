/*
Input any number. Display sum of digits of that number.
*/

DECLARE 
    n        INTEGER :=:n;  
    temp_sum INTEGER;  
    r        INTEGER;  
BEGIN  
    temp_sum := 0;  
    WHILE n <> 0 LOOP  
        r := MOD(n, 10);  
        temp_sum := temp_sum + r;  
        n := Trunc(n / 10);  
    END LOOP;  
    dbms_output.put_line('Sum of digits = '|| temp_sum);  
END;  