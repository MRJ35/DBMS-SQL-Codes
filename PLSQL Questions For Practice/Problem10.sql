-- 10. Write a function to input person’s age as total no. of days and return age of that person in years,
-- months and days.CREATE OR replace FUNCTION age_calculator(days INT)
CREATE TYPE age AS OBJECT(
  years int,
  months int,
  days int
);

CREATE OR replace FUNCTION Age_calculator(total_days INT) 
RETURN VARCHAR 
AS 
  years  INT; 
  months INT; 
  days   INT; 
BEGIN 
    years := Trunc(total_days / 365); 

    months := Trunc(( total_days - years * 365 ) / 30); 

    days := total_days - years * 365 - months * 30; 

    RETURN years 
           ||' years ' 
           ||months 
           ||' months ' 
           ||days 
           ||' days'; 
END; 

/ 

DECLARE 
    calculated_age VARCHAR(50); 
    total_days     INT := :total_days; 
BEGIN 
    calculated_age := Age_calculator(total_days); 

    dbms_output.Put_line(calculated_age); 
END; 

/ 
-- CREATE OR REPLACE FUNCTION age_calculator(total_days int) RETURN age AS
--   person_age age;
-- BEGIN
--   age.years = 
-- END;
-- /

SELECT Trunc(Months_between(sysdate, dob) / 12) 
       AS year 
       , 
       Trunc(Mod(Months_between(sysdate, dob), 12)) 
       AS month, 
       Trunc(sysdate - Add_months(dob, Trunc(Months_between(sysdate, dob)))) 
       AS DAY 
FROM   (SELECT To_date('01052000', 'DDMMYYYY') AS DOB 
        FROM   dual); 
