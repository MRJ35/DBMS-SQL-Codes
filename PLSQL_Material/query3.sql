-- 1.	Input any number and display following patterns. Ex., inputted number is 5, program should display 5 lines.
--    	1
--    	2 3
--    	4 5 6
--    	7 8 9 10

--     1 
-- 	0 1
-- 	1 0 1 
-- 	0 1 0 1 
-- 	1 0 1 0 1

declare
    num int:=:num;
    cnt int:=1;
begin
    for i in 1..num loop
        for j in 1..i loop
            dbms_output.Put(cnt || ' ');
            cnt := cnt + 1;
        end loop;
        dbms_output.Put_line('');
    end loop;
    dbms_output.NEW_LINE();
    
    for i in 1..num loop
        cnt := mod(i,2);
        for j in 1..i loop
            dbms_output.Put(cnt || ' ');
            if (cnt=1) then
                cnt := 0;
            else
                cnt := 1;
            end if;
        end loop;
        dbms_output.Put_line('');
    end loop;
end;
/



-- 2.	An insurance company follows following rules to calculate premium.
-- a.	If a person’s health is excellent and the person is between 25 and 35 years of age and lives in a city and is a male then the premium is Rs. 4 per thousand and his policy amount can’t exceed Rs. 2 lakhs.
-- b.	If a person satisfies all the above conditions except that the gender is female then the premium is Rs. 3 per thousand and her policy amount can’t exceed Rs. 1 lakh.
-- c.	If a person’s health is poor and the person is between 25 and 35 years of age and lives in a village and is a male then the premium is Rs. 6 per thousand and his policy can’t exceed Rs. 10,000.
-- d.	In all other cases the person is not insured.
-- Input person’s health, age, location and gender. According to above conditions display whether person could be insured or not. If yes, display premium amount.


DECLARE
    health varchar(200):=:health;
    age varchar(200):=:age;
    location varchar(200):=:location;
    gender varchar(200):=:gender;
    policy_amount int:=:policy_amount;
    premium int:=0;
BEGIN
    if (health='excellent' and age>25 and age<35 and location='city' and gender='male' and policy_amount<200000) THEN
        premium := trunc(policy_amount/1000) * 4;
        dbms_output.PUT_LINE('Premium is Rs. ' || premium);
    elsif (health='excellent' and age>25 and age<35 and location='city' and gender='female' and policy_amount<100000) THEN
        premium := trunc(policy_amount/1000) * 3;
        dbms_output.PUT_LINE('Premium is Rs. ' || premium);
    elsif (health='poor' and age>25 and age<35 and location='village' and gender='male' and policy_amount<10000) THEN
        premium := trunc(policy_amount/1000) * 6;
        dbms_output.PUT_LINE('Premium is Rs. ' || premium);
    else
        dbms_output.PUT_LINE('Person is not insured');
    end if;
END;
/



-- 3.	A postal delivery company delivers parcels by air or rail transport. The price of delivery by air depends upon the weight of the parcel. There is a basic charge of 5 euros per kilo up to 50 kilos. Excess weight over 50 kilos is charged at 3 euros per kilo. Delivery by rail is charged at 3 euros per kilo up to 50 kilos and then 2 euros per kilo. There is a special service guaranteeing same day delivery which carries an additional flat rate charge of 20 euros. Any deliveries overseas are charged at double the normal rate.
-- Input mode of transport, weight of parcel, delivery is domestic or overseas and delivery to be done same day or not.  According to the mentioned rules, display charges. 


DECLARE
    transport varchar(200):=:transport;
    weight int:=:weight;
    delivery varchar(200):=:delivery;
    isday varchar(200):=:isday;
    charge int:=0;
BEGIN
    if(transport='air') then
        if(weight<50) then
            charge := weight*5;
        else
            charge := 50*5 + (weight-50)*8;
        end if;
    end if;
    if(transport='rail') then
        if(weight<50) then
            charge := weight*3;
        else
            charge := 50*3 + (weight-50)*5;
        end if;
    end if;
    if(delivery='overseas') then
            charge := charge * 2;
    end if;
    if(isday='yes') then
            charge := charge + 20;
    end if;
    dbms_output.Put_line('charge is ' || charge);
END;
/



-- 4.	Input any date with time. Extract time and day from inputted date. If time is not between 10 am to 6 pm and day is not weekdays, display the message “Office is closed” else display “Office is Open”.  


DECLARE
    d TIMESTAMP:=:d;
    hh int;
    mm int;
    ss int;
    dy varchar(200);
BEGIN
    hh := extract(hour from d);
    mm := extract(minute from d);
    ss := extract(second from d);
    dy := rtrim(to_char(d,'dy'));
    if hh>=10 and hh<=18 and dy not in ('sat','sun') THEN
        if hh=18 and (mm!=0 or ss!=0) THEN
            dbms_output.PUT_LINE('Office is closed');
        else
            dbms_output.PUT_LINE('Office is open');
        end if;
    else
        dbms_output.PUT_LINE('Office is closed.');
    end if;
    dbms_output.PUT_LINE(hh);
END;
/



-- 5.	Input any number. Display sum of digits of that number.


DECLARE
    num int:=:num;
    s int:=0;
BEGIN
    while num>0
    LOOP
        s := s + mod(num,10);
        num := trunc(num/10);
    END LOOP;
    dbms_output.PUT_LINE('Sum is ' || s);
END;
/


-- 6.	Input any number to generate following series.
-- 1	4	9	16	25	36…….
-- 1	2	4	8	16	32	64…….


DECLARE
    num int:=:num;
    temp int;
BEGIN
    for i in 1..num loop
        dbms_output.Put((i*i) || ' ');
    end loop;
    dbms_output.PUT_LINE(' ');

    temp := 1;
    for i in 1..num loop
        dbms_output.Put(temp || ' ');
        temp := temp*2;
    end loop;
    dbms_output.PUT_LINE(' ');
END;
/



-- 7.	Input any string and display whether it is palindrome or not.


DECLARE
    str varchar(200):=:str;
    len int;
    flag BOOLEAN;
BEGIN
    len := length(str);
    flag := true;
    For i in 1..len loop
        if(substr(str,i,1)!=substr(str,len-i+1,1)) THEN
            flag := false;
            exit;
        end if;
    end loop;
    if(flag) THEN
        dbms_output.PUT_LINE('Palindrome');
    else
        dbms_output.PUT_LINE('Not a Palindrome');
    end if;
END;
/


-- 8.	Input any string and display total no. of vowels in that string.


DECLARE
    str varchar(200):=:str;
    cnt int:=0;
    len int;
    ch varchar(2);
BEGIN
    len := length(str);
    For i in 1..len loop
        ch := substr(str,i,1);
        if ch in ('A','E','I','O','U','a','e','i','o','u') then
            cnt := cnt + 1;
        end if;
    end loop;
    dbms_output.PUT_LINE('No of vowels are ' || cnt);
END;
/


-- 9. Input marks of five subjects each out of 50. 
-- Display total marks and percentage only if student is passed in all the subjects. 
-- Passing marks are 25 out of 50.


DECLARE
    sub1 int:=:sub1;
    sub2 int:=:sub2;
    sub3 int:=:sub3;
    sub4 int:=:sub4;
    sub5 int:=:sub5;
    sm int:=0;
    percent float;
    flag BOOLEAN:=false;
BEGIN
    if(sub1>=25 and sub2>=25 and sub3>=25 and sub4>=25 and sub5>=25) THEN
            sm := sm + sub1 + sub2 + sub3 + sub4 + sub5;
            percent := (sm/250) * 100;
            flag := true;
    end if;

    if(flag) THEN
        dbms_output.PUT_LINE('Total Marks : ' || sm);
        dbms_output.PUT_LINE('Percentage  : ' || percent);
    else
        dbms_output.PUT_LINE('Student is fail');
    end if;
END;
/