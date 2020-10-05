/*An insurance company follows the following rules to calculate premium.
a. If a person’s health is excellent and the person is between 25 and 35 years of age and
lives in a city and is a male then the premium is Rs. 4 per thousand.
b. If a person satisfies all the above conditions except that the gender is female then the
premium is Rs. 3 per thousand.
c. If a person’s health is poor and the person is between 25 and 35 years of age and lives in
a village and is a male then the premium is Rs. 6 per thousand.
d. In all other cases the person is not insured.
Write a PL/SQL block to input person’s health, age, city and gender. From the rules given
above, display the message whether the person is insured or not. If insured, display
premium amount.*/

declare
health char(20) := :health;
age int := :age;
gender char(20) := :gender;
village_city char(20):= :village_city;
flag int;
begin
flag := 0;
if(age>=25 and age<= 35 and gender='male' and health='excellent' and village_city = 'city') then
dbms_output.put_line('premium is Rs 4 per thousand');
flag :=1;
end if;
if(age>=25 and age<= 35 and gender='female' and health='excellent' and village_city = 'city') then
dbms_output.put_line('premium is Rs 3 per thousand');
flag :=1;
end if;
if(age>=25 and age<= 35 and gender='male' and health='excellent' and village_city = 'village')
then
dbms_output.put_line('premium is Rs 6 per thousand');
flag :=1;
end if;
if(flag=0) then
dbms_output.put_line('Not insured');
end if;
end
/
