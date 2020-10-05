/*Write a function to input any number. Check whether the inputted number is a Dudeney
number or not and return appropriate message. (A Dudeney number is a positive integer
that is a perfect cube such that the sum of its digits is equal to the cube root of the number.*/

create or replace function dudeney_fun(n int) return int as
flag int;
temp int;
sum1 int;
temp1 int;
begin
if(n<=0)then
flag:=0;
end if;
if(n>0)then
sum1:=0;
flag:=0;
temp:=n;
for i in 1..length(n) LOOP
temp1 := MOD(TEMP,10);
temp := Trunc(temp/10);
sum1 := sum1 + temp1;
END LOOP;
if((sum1*sum1*sum1)=n)then
flag := 1;
end if;
end if;
return flag;
end;

declare
number int := :number;
s int;
begin
s:=dudeney_fun(number);
if(s=1)then
dbms_output.put_line('It is a Dudeney number');
end if;
if(s=0)then
dbms_output.put_line('Not a Dudeney number');
end if;
