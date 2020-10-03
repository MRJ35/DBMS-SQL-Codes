/*

An Insurance company follows following rules to calculate premium.
a.) IF a person’s health is excellent and the person is between 25 and 35 years of age and lives IN a city and is a male THEN the premium is Rs. 4 per thousand and his
policy amount can’t exceed Rs. 2 lakhs.
b.) IF a person satisfies all the above conditions except that the gender is female THEN the premium is Rs. 3 per thousand and her policy amount can’t exceed Rs. 1 lakh.
c.) IF a person’s health is poor and the person is between 25 and 35 years of age and lives IN a village and is a male THEN the premium is Rs. 6 per thousand and his
policy can’t exceed Rs. 10,000.
d.) In all other cases the person is not Insured.

Input person’s health, age, location and gender. According to above conditions display whether person could be Insured or not. IF yes, display premium amount
*/

DECLARE 
    health     VARCHAR(200) := :health; 
    age        INTEGER := :age; 
    location   VARCHAR(200) := :location; 
    gender     VARCHAR(200) := :gender; 
    policy_amt INTEGER := :policy_amt; 
    premium    INTEGER := 0; 
BEGIN 
    IF ( health = 'excellent' 
         AND age > 25 
         AND age < 35 
         AND location = 'city' 
         AND gender = 'male' 
         AND policy_amt < 200000 ) THEN 
      premium := Trunc(policy_amt / 1000) * 4; 

      dbms_output.Put_line('Premium is Rs. ' 
                           || premium); 
    ELSIF ( health = 'excellent' 
            AND age > 25 
            AND age < 35 
            AND location = 'city' 
            AND gender = 'female' 
            AND policy_amt < 100000 ) THEN 
      premium := Trunc(policy_amt / 1000) * 3; 

      dbms_output.Put_line('Premium is Rs. ' 
                           || premium); 
    ELSIF ( health = 'poor' 
            AND age > 25 
            AND age < 35 
            AND location = 'village' 
            AND gender = 'male' 
            AND policy_amt < 10000 ) THEN 
      premium := Trunc(policy_amt / 1000) * 6; 

      dbms_output.Put_line('Premium is Rs. ' 
                           || premium); 
    ELSE 
      dbms_output.Put_line('Person is not INsured'); 
    END IF; 
END; 