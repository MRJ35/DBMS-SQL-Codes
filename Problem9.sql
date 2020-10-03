-- 9. Write a function to input basic_salary of the employee and return net_salary by applying the
-- following formulas. 
-- DA=43% of basic_salary 
-- HRA=15% of (basic_salary+DA) 
-- MA=100.00 
-- CLA=240.00 
-- TA=800.00 
-- PF=12% of (basic_salary+DA) 
-- IT=10% of basic_salary 
-- PT : if basic_salary>=0 and <2000 then PT=20.00 
-- if basic_salary>=2000 and <4000 then PT=40.00 
-- if basic_salary>=4000 and <6000 then PT=60.00 
-- if basic_salary>=6000 then PT=100.00 
-- Allowances=DA+HRA+MA+CLA+TA 
-- Deductions=PF+IT+PT 
-- Net_salary=basic_salary+allowances-deductions
CREATE OR replace FUNCTION Salary_calculator(basic_salary FLOAT) 
RETURN FLOAT 
AS 
  da         FLOAT; 
  hra        FLOAT; 
  ma         INT := 100; 
  cla        INT := 240; 
  ta         INT := 800; 
  pf         FLOAT; 
  it         FLOAT; 
  pt         INT; 
  allowances FLOAT; 
  deductions FLOAT; 
  net_salary FLOAT; 
BEGIN 
    da := 0.43 * basic_salary; 

    hra := 0.15 * ( basic_salary + da ); 

    pf := 0.12 * ( basic_salary + da ); 

    it := 0.1 * basic_salary; 

    IF basic_salary >= 6000 THEN 
      pt := 100; 
    ELSIF basic_salary >= 4000 THEN 
      pt := 60; 
    ELSIF basic_salary >= 2000 THEN 
      pt := 40; 
    ELSIF basic_salary >= 0 THEN 
      pt := 20; 
    END IF; 

    allowances := da + hra + ma + cla + ta; 

    deductions := pf + it + pt; 

    net_salary := basic_salary + allowances - deductions; 

    RETURN net_salary; 
END; 

/ 

DECLARE 
  basic_salary FLOAT := :basic_salary; 
  net_salary FLOAT; 
BEGIN 
  net_salary := Salary_calculator(basic_salary); 
  dbms_output.Put_line('Net salary ' 
  ||net_salary); 
END;
/
