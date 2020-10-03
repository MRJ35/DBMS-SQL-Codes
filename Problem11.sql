  -- 11. A computer manufacturing company has the following monthly compensation policy for their
  -- salespersons. 
  -- Basic Salary : 10000.00 
  -- Bonus for every computer sold : 500.00 
  -- Commission on the total monthly sales : 2% 
  -- Write a procedure to input price of one computer and total no. of computers sold by the
  -- salesperson. Calculate and display total bonus, total commission and gross salary.
CREATE OR replace PROCEDURE price_calculator(unit_price INT, 
                                            quantity   INT) 
AS 
    basic_salary    INT := 10000; 
    unit_bonus      INT := 500; 
    commission_rate INT := 2; 
    total_bonus     INT; 
    total_commission FLOAT; 
    gross_salary FLOAT; 
BEGIN 
    total_bonus := unit_bonus * quantity; 
    dbms_output.put_line('Total bonus: ' 
    ||total_bonus); 
    total_commission := commission_rate * quantity / 100; 
    dbms_output.put_line('Total commission: ' 
    ||total_commission); 
    gross_salary := basic_salary + total_bonus + total_commission; 
    dbms_output.put_line('Gross salary: ' 
    ||gross_salary); 
END;
/
DECLARE 
unit_price INT := :unit_price; 
quantity   INT := :quantity; 
BEGIN 
  Price_calculator(unit_price, quantity); 
END;
/ 
