-- 7. Write a procedure to input any number as a parameter. Check whether the number is an
-- Armstrong number or not. (Note : A number is an Armstrong number if sum of cube of digits is
-- equal to that number itself. For ex., 153=(1) 3 + (5) 3 + (3) 3 ) 
CREATE OR replace PROCEDURE Check_armstrong(num INT) 
AS 
  numtemp INT; 
  sumcube INT:= 0; 
BEGIN 
  numtemp:= num; 
  WHILE (numtemp != 0) 
  LOOP 
    sumcube := sumcube + Power(MOD(numtemp,10),3); 
    numtemp := Trunc(numtemp / 10); 
  END LOOP; 
  IF sumcube = num THEN 
    dbms_output.Put_line('Number is Armstrong'); 
  ELSE 
    dbms_output.Put_line('Number is not Armstrong'); 
  END IF; 
END;
/

DECLARE 
  num INT:= :num; 
BEGIN 
  Check_armstrong(num); 
END;
/ 
