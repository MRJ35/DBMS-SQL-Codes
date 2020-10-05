/*A certain steel is graded according to the results of three tests given below:
Carbon content < 0.7
Rockwell hardness > 50
Tensile strength > 30,000 kg./cm2
The steel is graded 10 if it passes all 3 tests, 9 if it passes only tests 1 and 2, 8 if it passes only test
1 and 7 if it passes none of the tests. Find grade of a steel on the basis of criterion given.*/


declare
carbon_count float:= :carbon_count;
rockwell_hardness float:= :rockwell_hardness;
tensil_strength float:= :tensil_strength;
t1 int;
t2 int;
t3 int;
grade int;
begin
t1 := 0;
t2 := 0;
t3 := 0;
if(carbon_count<0.7) then
t1 := 1;
end if;
if(rockwell_hardness>50) then
t2 := 1;
end if;
if(tensil_strength>30000) then
t3 := 1;
end if;
if(t1=1 and t2=1 and t3=1) then
grade := 10;
elsif (t1=1 and t2=1) then
grade := 9;
elsif (t1=1) then
grade := 8;
else
grade:=7;
end if;
dbms_output.put_line('Grade of a steel : '||grade||'');
end;
/
