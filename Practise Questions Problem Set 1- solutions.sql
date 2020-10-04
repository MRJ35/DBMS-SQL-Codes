update city set state = null where location = 'Surat';  
begin
insert into reservation values('Res3','C3','H2','R3','01/24/20','1/26/20');
insert into reservation values('Res6','C3','H3','R1',null,null);
end ;

--Q-1
create or replace trigger t1 before insert on city
for each row
begin
     if :new.state is null then
          :new.state := 'Gujarat';
     end if;
end;
insert into city values('Surat',null)
select * from city


--Q 2
Assignment 6 Q-2

create or replace trigger t2
before insert on room 
for each row
declare
     cursor c_check is select rno from room;
     r_check c_check%rowtype;
begin
     for r_check in c_check loop
     dbms_output.put_line(r_check.rno);
     if(r_check.rno = :new.rno) then
          raise_application_error(-20001,'Duplicate Found');
     end if;
     end loop;
end;

insert into room values('R1','Sasta',250,'C7')






--Q-3
create or replace trigger t3 before insert on reservation
for each row
begin
     if :new.arrival_date is null then
          :new.arrival_date := sysdate;
          :new.departure_date := sysdate + 2;
     end if;
end;
insert into reservation values('Res6', 'C3', 'H3', 'R1', null, null);
select * from reservation;

--Q - 4

create or replace trigger del_child_res before delete on room for each row
begin
    delete from reservation where rno = :old.rno ;
end;

delete from room where rno = 'R1' ;
select * from reservation order by res_no;
select * from room ;

--Q - 5
Question 5


create or replace trigger remRecHotel for delete on Hotel
COMPOUND trigger
TYPE get_hotel IS RECORD(hotelNo Hotel.hno%TYPE);
x int := 1;
after each row is
begin
    x := x + 1;
end after each row;

after statement is
begin
    dbms_output.put_line(x);
end after statement;
end;


create or replace trigger childDelHotel before delete on Hotel for each row
begin
    delete from Reservation where hno = :old.hno ;
end;

delete from Hotel where hno = 'H1';
select * from Hotel
