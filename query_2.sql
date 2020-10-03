-- Q1   Write a procedure to input any number as a parameter. Check whether the number is an Armstrong number or not. 

create or replace procedure checkArmstrong(n int) as
    s int;
    r int;
    i int;
    temp int;
begin
    i := 0;
    s := n;
    r := 0;
    temp := n;
    while (temp>0) loop
         r := r + power(mod(temp,10),3);
         temp := trunc(temp/10);
    end loop;
    if (r=s) then
       dbms_output.put_line(n||' is an Armstong number');
    else 
       dbms_output.put_line(n||' is not an armstong number');
    end if;
end;

declare
   n int:=:n;
begin
  checkArmstrong(n);
end;
/


-- Q2   Write a procedure to input product’s class and purchase amount and display discount along with the payable amount

create or replace procedure companyProfit(class char,purchase int) as
   discount int;
   payable int;
begin
   discount:=0;
   if (class='A' and purchase>5000) then
      discount := 10;
   elsif (class='B' and purchase>8000) then
      discount := 5;
   elsif (class='C' and purchase>=10000) then
      discount := 4;
   end if;
   payable := purchase - ((purchase*discount)/100);
   dbms_output.put_line('Discount is '||discount||'% and Payable amount is '||payable);
end;


declare
   class char:=:class;
   purchaseAmount int:=:purchaseAmount;
begin
  companyProfit(class,purchaseAmount);
end;
/





-- Q3   Write a function to input basic_salary of the employee and return net_salary

create or replace function salary(basic_salary float) return float as
   DA float;
   HRA float;
   MA float;
   CLA float;
   TA float;
   PF float;
   PT float;
   IT float;
   allowance float;
   deduction float;
   netsalary float;
begin
    if (basic_salary>=0 and basic_salary<2000) then
      PT := 20.00;
	elsif (basic_salary>=2000 and basic_salary<4000) then
      PT := 40.00;
    elsif (basic_salary>=4000 and basic_salary<6000) then
      PT := 60.00;
    elsif (basic_salary>=6000) then
      PT := 10.00; 
	end if;
    DA := trunc(basic_salary*43/100);
    HRA := trunc((basic_salary+DA)*15/100);
    MA := 10.00;
    CLA := 240.00;
    TA := 800.00;
    PF := trunc((basic_salary+DA)*12/100);
    IT := trunc(basic_salary*10/100);
    allowance := DA+HRA+MA+CLA+TA;
    deduction := PF+PT+IT;
    netsalary := allowance+basic_salary-deduction;
    return netsalary;	
end;   

declare
   basic_salary float:=:basic_salary;
   temp float;
begin
   temp := salary(basic_salary);
   dbms_output.put_line('Your net salary is '||temp);
end;
/






-- Q4   Write a function to input person’s age as total no. of days and return age of that person in years,  months and days.


create or replace function calculate_age(totaldays  int) return varchar as
   totalday int;
   temp int;
   years int;
   months int;
   days int;
   final_age varchar(100);
begin
   totalday := totaldays;
   temp := mod(totalday,365);
   years := trunc(totalday/365);
   totalday := temp;
   temp := mod(totalday,30);
   months := trunc(totalday/30);
   totalday := temp;
   days := totalday;
   final_age := 'Your age must be '||years||' years, '||months||' months and '||days||' days'; 
   return final_age;
end;

declare
   days int:=:days;
   ans varchar(100);
begin
   ans := calculate_age(days);
   dbms_output.put_line(ans);
end;
/






-- Q5  Write a procedure to input price of one computer and total no. of computers sold by the salesperson. Calculate and display total bonus, total commission and gross salary.

create or replace procedure calculate(unitprice int, totalsale int) as
   totalbonus int;
   totalcommission float;
   grosssalary float;
begin
   grosssalary := 10000;
   totalbonus := 500*totalsale;
   totalcommission := trunc((unitprice*totalsale)/50);
   grosssalary := grosssalary + totalbonus + totalcommission;
   dbms_output.put_line('Total Bonus : '||totalbonus);
   dbms_output.put_line('Total Commission : '||totalcommission);
   dbms_output.put_line('Gross Salary : '||grosssalary); 
end; 
   
declare
   unitprice int:=:unitprice;
   totalsale int:=:totalsale;
begin
   calculate(unitprice,totalsale);
end; 
/





-- Q6   Write procedure that will retrieve records from the PERSON table and will display person’s name as following four formats. For Ex., if first name is Pooja, middle name is Harshad and last name is Shah then it should be displayed as follows. Based on the gender display Ms. or Mr. before name. 


create table person(
   first_name varchar(10),
   middle_name varchar(10),
   last_name varchar(10),
   age int,
   gender varchar(10)
);

create or replace procedure retrieve_records as
    cursor records is select * from person;
    name records%rowtype;
begin
    for name in records loop
        if (name.gender=UPPER('male') or name.gender='male' or name.gender='Male') then
            dbms_output.put_line('Mr. '||name.first_name||' '||name.middle_name||' '||name.last_name);
            dbms_output.put_line('Mr. '||substr(name.first_name,1,1)||'. '||substr(name.middle_name,1,1)||'. '||name.last_name);
            dbms_output.put_line('Mr. '||name.last_name||' '||substr(name.first_name,1,1)||'. '||substr(name.middle_name,1,1)||'.');
            dbms_output.put_line('Mr. '||name.last_name||' '||name.first_name||' '||name.middle_name);
        else 
            dbms_output.put_line('Ms. '||name.first_name||' '||name.middle_name||' '||name.last_name);
            dbms_output.put_line('Ms. '||substr(name.first_name,1,1)||'. '||substr(name.middle_name,1,1)||'. '||name.last_name);
            dbms_output.put_line('Ms. '||name.last_name||' '||substr(name.first_name,1,1)||'. '||substr(name.middle_name,1,1)||'.');
            dbms_output.put_line('Ms. '||name.last_name||' '||name.first_name||' '||name.middle_name);
        end if;
    end loop;
end;  

declare
begin
   retrieve_records();
end;
/





-- Q7   Write a procedure to display the details of STUDENT and CLASS table.


create table class(
   classcode int primary key,
   classdesc varchar(10)
);

create table student(
   stdno int primary key,
   classcode int,
   stdname varchar(10),
   birthdate date,
   admissiondate date,
   gender varchar(10),
   contact varchar(10),
   constraint fk_classcode foreign key (classcode) references class(classcode)    
);

insert into class values(100,'ICP');
insert into class values(200,'OOP');
insert into class values(300,'DBMS');

insert into student values(10,100,'abc',to_date('03/07/2020','mm/dd/yyyy'),to_date('03/01/2020','mm/dd/yyyy'),'male',213113);
insert into student values(30,200,'abc',to_date('03/07/2020','mm/dd/yyyy'),to_date('03/01/2020','mm/dd/yyyy'),'male',213113);
insert into student values(40,300,'abc',to_date('03/07/2020','mm/dd/yyyy'),to_date('03/01/2020','mm/dd/yyyy'),'male',213113);
insert into student values(20,100,'xyz',to_date('02/07/2020','mm/dd/yyyy'),to_date('02/01/2020','mm/dd/yyyy'),'male',213111);
insert into student values(50,200,'xyz',to_date('02/07/2020','mm/dd/yyyy'),to_date('02/01/2020','mm/dd/yyyy'),'male',213111);

create or replace procedure display_class as
   cursor records is select * from class;
   data_val records%rowtype;
begin
   open records;
   dbms_output.put_line('ClassCode  ClassDesc');
   loop
      fetch records into data_val; 
      exit when records%notfound;
      dbms_output.put_line(data_val.classcode||'        '||data_val.classdesc);
   end loop;
   close records;
end;

create or replace procedure display_student as
   cursor records is select * from student;
   data_val records%rowtype;
begin
   open records;
   dbms_output.put_line('Student Table');
   dbms_output.put_line('Stdno  Classcode  Stdname   Birthdate   AdmissDate  Gender Contact ');
   loop
      fetch records into data_val; 
      exit when records%notfound;
      dbms_output.put_line(data_val.stdno||'        '||data_val.classcode||'       '||data_val.stdname||'     '||data_val.birthdate||'  '||data_val.admissiondate||'   '||data_val.gender||' '||data_val.contact);
   end loop;
   close records;
end;


declare
begin
   dbms_output.put_line('Class Table');
   display_class();
   dbms_output.put_line('');
   display_student();
end;
/





-- Q8   Create a procedure to display employee name, salary and joining date from the EMPLOYEE table. Also, display total no. of years of experience of each employee from the joining_date field  and retirement date of each employee from the birth_date field

create table employee(empno int primary key, empname varchar(10), salary int, jdate date, bdate date);
insert all 
into employee values(1,'sagar',50000,to_date('01/01/2012','dd/mm/yyyy'),to_date('01/01/1990','dd/mm/yyyy'))
into employee values(2,'dhaval',70000,to_date('10/10/2005','dd/mm/yyyy'),to_date('01/01/1980','dd/mm/yyyy'))
into employee values(3,'gaurav',80000,to_date('01/09/2000','dd/mm/yyyy'),to_date('05/01/1975','dd/mm/yyyy'))
into employee values(11,'aman',40000,to_date('03/03/2001','dd/mm/yyyy'),to_date('01/05/1980','dd/mm/yyyy'))
into employee values(10,'sagar',50000,to_date('05/09/2015','dd/mm/yyyy'),to_date('02/04/1995','dd/mm/yyyy'))
select * from dual

create or replace procedure emp_details as
    cursor c_emp is select * from employee;
    record c_emp%rowtype;
    expe int;
    ret date;
    curdate date;
begin
    open c_emp;
    select sysdate into curdate from dual;
    dbms_output.put_line('Emp Name    Salary     JoinDate    Exp    RetDate');
    loop
        fetch c_emp into record;
        if c_emp%notfound then
           exit;
        end if;
        ret := add_months(record.bdate,720);
        select floor(months_between(curdate,record.jdate) /12) into expe from dual;
        dbms_output.put_line(' '||record.empname||'     '||record.salary||'     '||record.jdate||'    '||expe||'    '||ret);
    end loop;     
    close c_emp;
end;

declare
begin
  emp_details();
end;
/





-- Q9   Create a procedure which will display department wise employee details in ascending order of department name and descending order of employee names within each department as per the following format. Also, display total no of employees in each department and overall total no of employees at the end.


create table depart(deptno int primary key, deptname varchar(10));

create table employee(empno int primary key, deptno int references depart(deptno), empname varchar(10), salary int, jdate date, bdate date);


insert all 
into depart values(1,'IT')
into depart values(2,'Sales')
into depart values(3,'RnD')
select * from dual

insert all 
into employee values(1,1,'sagar',50000,to_date('01/01/2012','dd/mm/yyyy'),to_date('01/01/1990','dd/mm/yyyy'))
into employee values(2,1,'dhaval',70000,to_date('10/10/2005','dd/mm/yyyy'),to_date('01/01/1980','dd/mm/yyyy'))
into employee values(3,2,'gaurav',80000,to_date('01/09/2000','dd/mm/yyyy'),to_date('05/01/1975','dd/mm/yyyy'))
into employee values(11,2,'aman',40000,to_date('03/03/2001','dd/mm/yyyy'),to_date('01/05/1980','dd/mm/yyyy'))
into employee values(10,3,'sagar',50000,to_date('05/09/2015','dd/mm/yyyy'),to_date('02/04/1995','dd/mm/yyyy'))
into employee values(12,3,'deep',51000,to_date('01/04/2013','dd/mm/yyyy'),to_date('02/08/1993','dd/mm/yyyy'))
select * from dual

create or replace procedure company_details as
  emp_dept_id depart.deptno%TYPE;
 temp int;
 total_emp int;
 CURSOR cur_dept IS
  SELECT * 
  FROM depart
  ORDER BY deptname;
 CURSOR cur_emp IS
  SELECT * 
  FROM employee
  WHERE deptno = emp_dept_id
  ORDER BY empname desc;
BEGIN
    total_emp := 0;
    FOR r_dept IN cur_dept
    LOOP
      emp_dept_id:=r_dept.deptno;
      DBMS_OUTPUT.PUT_LINE('----------------------------------');
      DBMS_OUTPUT.PUT_LINE('Department Name : '||r_dept.deptname);
      DBMS_OUTPUT.PUT_LINE('----------------------------------');
      DBMS_OUTPUT.PUT_LINE('EmpNo     EmpName     Salary    BirthDate     JoinDate');
           FOR r_emp IN cur_emp 
           LOOP
             DBMS_OUTPUT.PUT_LINE('  '||r_emp.empno||'       '||r_emp.empname||'       '||r_emp.salary||'     '||r_emp.bdate||'    '||r_emp.jdate);
           END LOOP;
           select count(*) into temp from employee where employee.deptno=r_dept.deptno;
           DBMS_OUTPUT.PUT_LINE('----------------------------------');
           DBMS_OUTPUT.PUT_LINE('Total No. of Employees in '||r_dept.deptname||' : '||temp);
           DBMS_OUTPUT.PUT_LINE('');
           temp:=0;
    END LOOP;
    select count(*) into total_emp from employee;
    DBMS_OUTPUT.PUT_LINE('Total No. of Employees in the company are '||total_emp);
    DBMS_OUTPUT.PUT_LINE('');
END;


declare 
begin
  company_details();
end;
/





-- Q10   Create a procedure to input from date and to date. Display details of bills between these dates as per the following format. Use lineitem, item and sale tables.


create table sale(
  saleno int primary key,
  saledate date,
  saletext char(100)
);

create table item(
  itemno int primary key,
  itemname char(20),
  itemtype char,
  itemcolor char(20)
);

create table lineitem(
lineno int,
lineqty int,
lineprice float,
saleno int references sale(saleno),
itemno int references item(itemno),
primary key (saleno,itemno)
);

insert all
into sale values(1,to_date('15-01-1995','dd-mm-yyyy'),'Scruffy Australian-called himself bruce')
into sale values(2,to_date('15-01-1995','dd-mm-yyyy'),'Man. Rather fond of hats')
into sale values(3,to_date('15-01-1995','dd-mm-yyyy'),'Woman. Planning to row atlantic-lengthwise')
into sale values(4,to_date('15-01-1995','dd-mm-yyyy'),'Man. Trip to new york-thinks new york is a jungle')
into sale values(5,to_date('16-01-1995','dd-mm-yyyy'),'Expedition leader for African safari')
select * from dual;


create or replace procedure sale_details(from_date date, to_date date) as
   total_price float;
   total_bill float;
   sale_no sale.saleno%TYPE;
   item_no lineitem.itemno%TYPE;
   sale_date sale.saledate%TYPE;
   cursor cur_saledetail is
      select * from sale where saledate = sale_date;
   cursor cur_sale is
      select distinct(saledate) from sale where saledate between from_date and to_date;
   cursor cur_lineitem is 
      select * from lineitem where saleno = sale_no;
   cursor cur_item is
      select * from item where itemno = item_no;
begin
   for sale_record in cur_sale
   loop
      sale_date := sale_record.saledate;
      DBMS_OUTPUT.PUT_LINE('');
      DBMS_OUTPUT.PUT_LINE('');
      DBMS_OUTPUT.PUT_LINE('Sale Date: '||sale_record.saledate);
      for saledetail_rec in cur_saledetail
      loop
          total_bill := 0;
          sale_no := saledetail_rec.saleno;
          DBMS_OUTPUT.PUT_LINE('Sale No: '||saledetail_rec.saleno);
          DBMS_OUTPUT.PUT_LINE('SrNo.    ItemName         Price     Quantity    Total_Price');
          for l_item in cur_lineitem
          loop
              item_no := l_item.itemno;
              for item_det in cur_item
              loop
                 total_price := l_item.lineqty * l_item.lineprice;
                 total_bill := total_bill + total_price;
                 DBMS_OUTPUT.PUT_LINE(' '||item_no||'     '||item_det.itemname||'       '||l_item.lineprice||'        '||l_item.lineqty||'        '||total_price);
              end loop;
          end loop;
          DBMS_OUTPUT.PUT_LINE('');
          DBMS_OUTPUT.PUT_LINE('Total Bill Amount : '||total_bill);
          DBMS_OUTPUT.PUT_LINE('');
      end loop;
   end loop;
end;

declare
  from_date date:=:from_date;
  to_date date:=:to_date;
begin
  sale_details(from_date,to_date);
end;
/
