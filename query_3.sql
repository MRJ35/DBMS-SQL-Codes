declare
    name varchar(10):=:name;
    gender varchar(10):=:gender;
    birthdate date:=:birthdate;
    age int;
begin
    age:= months_between(sysdate, birthdate)/12;
    if (gender='male' and age<=12) then
         dbms_output.put_line('Master '||name);
    elsif (gender='male' and age>12) then
         dbms_output.put_line('Mr '||name);
    elsif (gender='female' and age<=12) then
         dbms_output.put_line('Baby '||name);
    else
         dbms_output.put_line('Ms '||name);
    end if;
end;


declare
   num int:=:num;
   root int;
   i int;
   flag int;
begin
   root:= sqrt(num);
   flag:= 0;
   for i in 2..root loop
       if (mod(num,i)=0) then
           flag := 1;
           exit;
       end if;
   end loop;
   if (flag=0) then
       dbms_output.put_line(num||' is prime');
   else
        dbms_output.put_line(num||' is composite');
        dbms_output.put_line('Factors of '||num|| ' are ');
       for i in 1..num loop
         if mod(num,i)=0 then
            dbms_output.put_line(i);
         end if;       
       end loop;
   end if;
end; 


declare
   mail varchar(40):=:mail;
begin
   if (mail like '%@%') then
       dbms_output.put_line(mail||' is a valid mail id');
   else 
       dbms_output.put_line(mail||' is not a valid mail id');
   end if;
end;