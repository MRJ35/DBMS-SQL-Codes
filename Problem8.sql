-- 8. A company makes three products which are codified as class A, class B and class C. On class
-- A items for purchase above Rs. 5000, 10% discount is given. For class B for purchase
-- above Rs. 8000, a discount of 5% is given. On class C on a purchase of Rs. 10000 and above,
-- 4% discount is given. Write a procedure to input product’s class and purchase amount and
-- display discount along with the payable amount.
CREATE OR replace PROCEDURE Company_product(product_class   CHAR,
                                            purchase_amount NUMBER) 
AS 
  discount       INT; 
  payable_amount NUMBER(10,2); 
BEGIN 
  IF Lower(product_class) = 'a' 
    AND 
    purchase_amount >= 5000 THEN 
    discount := 10; 
  ELSIF Lower(product_class) = 'b' 
    AND 
    purchase_amount >= 8000 THEN 
    discount := 5; 
  ELSIF Lower(product_class) = 'c' 
    AND 
    purchase_amount >= 10000 THEN 
    discount := 4; 
  ELSE 
    discount := 0; 
  END IF; 
  payable_amount := (1-discount/100) * purchase_amount; 
  dbms_output.Put_line('Please pay: ' 
  ||payable_amount); 
END;
/

DECLARE 
  product_class   CHAR(1):= :product_class; 
  purchase_amount NUMBER(10,2):= :purchase_amount; 
BEGIN 
  Company_product(product_class, purchase_amount); 
END;
/
