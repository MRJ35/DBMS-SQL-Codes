--Q1 Input any number and display following patterns. Ex., inputted number is 5, program should display 5 lines.

declare 
   i int:=:i;
   s int;
   j int;
   k int;
begin
   s:=1;   
   for j in 1..i-1 loop
      for k in 1..j loop
        dbms_output.put(s||' ');
        s := s+1;
      end loop;
      dbms_output.put_line(' ');
   end loop;
   s:=1;   
   for j in 1..i loop
      s:= MOD(j,2);
      for k in 1..j loop
        dbms_output.put(s||' ');
        s := 1-s;
      end loop;
      dbms_output.put_line(' ');
   end loop;
end;
/
-- Result

--Q2 Input person’s health, age, location and gender. According to above conditions display whether person could be insured or not. If yes, display premium amount.

declare
   health varchar(10):=:health;
   age int:=:age;
   location varchar(20):=:location;
   gender varchar(10):=:gender;
   amount int:=:amount;
   premium int;
begin
   premium := 0;
   if health='excellent' and age<=35 and age>=25 and location='city' and gender='male' and amount<=200000 then
       dbms_output.put_line('YES');
       dbms_output.put_line('Premium Amount is '||(amount*4)/1000);
   elsif health='excellent' and age<=35 and age>=25 and location='city' and gender='female' and amount<=100000 then
       dbms_output.put_line('YES');
       dbms_output.put_line('Premium Amount is '||(amount*3)/1000);
   elsif health='poor' and age<=35 and age>=25 and location='village' and gender='male' and amount<=10000 then
       dbms_output.put_line('YES');
       dbms_output.put_line('Premium Amount is '||(amount*6)/1000);
   else
       dbms_output.put_line('NO Premium');
   end if;
end;
/
-- Result

--Q3 Input mode of transport, weight of parcel, delivery is domestic or overseas and delivery to be done same day or not.  According to the mentioned rules, display charges. 
declare
   transport_mode varchar(10):=:transport_mode;
   parcel_weight int:=:parcel_weight;
   delivery_type varchar(10):=:delivery_type;
   same_day varchar(10):=:same_day;
   charges int:=0;
   extra_charges int:=0;
   total_charges int:=0;
begin
   if transport_mode = 'air' then
      if parcel_weight>50 then
         extra_charges:= (parcel_weight-50)*3;
         parcel_weight := 50;
      end if;
      charges := parcel_weight*5;
   elsif transport_mode = 'rail' then
      if parcel_weight>50 then
         extra_charges:= (parcel_weight-50)*3;
         parcel_weight :=50;
      end if;
      charges := parcel_weight*2;
   end if;
   if same_day = 'yes' then
      extra_charges:= extra_charges + 20;
   end if;
   total_charges:= extra_charges+charges;
   if delivery_type = 'overseas' then
      total_charges:= total_charges*2;
   end if;
   dbms_output.put_line('Basic Charge is '||charges||' Extra Charge is '||extra_charges||' Total Charge is '||total_charges)
 end;
/
-- Result


--Q4 Input any date with time. Extract time and day from inputted date. If time is not between 10 am to 6 pm and day is not weekdays, display the message “Office is closed” else display “Office is Open”.  
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
-- Result


--Q5 Input any number. Display sum of digits of that number.
declare
   i integer:=:i;
   su integer;
   temp integer;
begin
   su:=0;
   while i<>0 loop
      temp:= MOD(i,10);
      su := su + temp;
      i := trunc(i/10);
   end loop; 
   dbms_output.put_line('Sum of digits is '||su);   
end;
/
-- Result


--Q6.	Input any number to generate following series.
declare
  i int:=:i;
  temp int:=0;
  j int;
begin
  for j in 1..i loop
    temp:= j*j;
    dbms_output.put(temp||' ');
  end loop;
  dbms_output.put_line(' '); 
end;
/
-- Result


--Q7 Input any string and display whether it is palindrome or not.
declare
  str varchar(20):=:str;
  f int:=0;
  i int:=0;
  j int:=0;
begin
  j:= length(str);
  for i in 1..length(str) loop
     if substr(str,i,1)!=substr(str,j-i+1,1) then
        dbms_output.put_line('Labad'||i||' '||j);
        f := 1;
        exit;
     end if;
  end loop;
if f=1 then
   dbms_output.put_line('Not a palindrome');
else
   dbms_output.put_line('Palindrome');
end if;
end;
/
-- Result

--Q8	Input any string and display total no. of vowels in that string.
declare
  str varchar(20):=:str;
  n int:=0;
  j int:=0;
begin
  for j in 1..length(str) loop
     if substr(str,j,1) in ('A','E','I','O','U') or substr(str,j,1) in ('a','e','i','o','u') then
          n := n + 1;
     end if;
  end loop; 
  dbms_output.put_line('Total number of vowels are '||n);  
end;
/
-- Result


--Q9	Input marks of five subjects each out of 50. Display total marks and percentage only if student is passed in all the subjects. Passing marks are 25 out of 50.
declare
   marks1 int:=:marks1;
   marks2 int:=:marks2;
   marks3 int:=:marks3;
   marks4 int:=:marks4;
   marks5 int:=:marks5;
   f int:=0;
   tm int:=0;
   j int:=0; 
begin
     tm := marks1 + marks2 + marks3 +marks4 + marks5;
     if marks1<25 or marks2<25 or marks3<25 or marks4<25 or marks5<25 then
         f:=1;
     end if;
   if f=0 then
      dbms_output.put_line('Percentage is '||((tm/250)*100)||' and Total marks are '||tm);
   else
      dbms_output.put_line('Fail');
   end if;
end;
/
-- Result