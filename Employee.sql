/*Write a function to input employee’s working experience in no. of days. Calculate and return
his/her joining date on the basis of this.*/

create or replace function work_exp(days int) return date as
temp date;
begin
temp:= to_date(trunc(sysdate) - days);
return temp;
end;
declare
days int := :Days;
temp date;
begin
temp:= work_exp(days);
dbms_output.put_line('Joining Date is '|| temp);
end;
/
