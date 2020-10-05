-- 12. Create a table PERSON with following fields. 
-- Person(first_name,middle_name,last_name,age,gender) 
-- Write procedure that will retrieve records from the PERSON table and will display person’s
-- name as following four formats. For Ex., if first name is Pooja, middle name is Harshad and last
-- name is Shah then it should be displayed as follows. Based on the gender display Ms. or Mr.
-- before name. 
-- Ms. Pooja Harshad Shah 
-- Ms. P. H. Shah 
-- Ms. Shah P.H. 
-- Ms. Shah Pooja Harshad
CREATE TABLE person 
( 
            first_name  VARCHAR(20), 
            middle_name VARCHAR(20), 
            last_name   VARCHAR(20), 
            age         INT, 
            gender      VARCHAR(10) 
);
INSERT INTO person 
( 
            first_name, 
            middle_name, 
            last_name, 
            age, 
            gender 
) 
VALUES 
( 
            'Pooja', 
            'Harshad', 
            'Shah', 
            19, 
            'female' 
);
INSERT INTO person 
( 
            first_name, 
            middle_name, 
            last_name, 
            age, 
            gender 
) 
VALUES 
( 
            'Ramakant', 
            'Harilal', 
            'Pujari', 
            37, 
            'male' 
);
DECLARE 
  f_name person.first_name%TYPE; 
  m_name person.middle_name%TYPE; 
  l_name person.last_name%TYPE; 
  g person.gender%TYPE; 
  f_initial  CHAR(1); 
  m_initial  CHAR(1); 
  salutation VARCHAR(2); 
  CURSOR c_person IS 
    SELECT first_name, 
           middle_name, 
           last_name, 
           gender 
    FROM   person; 

BEGIN 
  OPEN c_person; 
  LOOP 
    FETCH c_person 
    INTO  f_name, 
          m_name, 
          l_name, 
          g; 
     
    EXIT 
  WHEN c_person%NOTFOUND; 
    f_initial := Substr(f_name, 1, 1); 
    m_initial := Substr(m_name, 1, 1); 
    IF Lower(g) = 'male' THEN 
      salutation := 'Mr'; 
    ELSE 
      salutation := 'Ms'; 
    END IF; 
    dbms_output.Put_line(salutation 
    ||'. ' 
    ||f_name 
    ||'. ' 
    ||m_name 
    ||'. ' 
    ||l_name); 
    dbms_output.Put_line(salutation 
    ||'. ' 
    ||f_initial 
    ||'. ' 
    ||m_initial 
    ||'. ' 
    ||l_name); 
    dbms_output.Put_line(salutation 
    ||'. ' 
    ||l_name 
    ||' ' 
    ||f_initial 
    ||'. ' 
    ||m_initial 
    ||'.'); 
    dbms_output.Put_line(salutation 
    ||'. ' 
    ||l_name 
    ||'. ' 
    ||f_name 
    ||'. ' 
    ||m_name); 
    dbms_output.New_line(); 
  END LOOP; 
  CLOSE c_person; 
END;
/ 
