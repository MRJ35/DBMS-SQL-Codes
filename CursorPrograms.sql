create table customer(
    cno varchar(3) ,
    primary key(cno) ,
    title varchar(5),
    name varchar(20),
    zip int
);
begin
    insert into customer values('C1','Mr.','Amar',380008) ;
    insert into customer values('C2','Ms.','Bina',380026) ;
    insert into customer values('C3','Mrs.','Diana',380001) ;
    insert into customer values('C4','Mr.','Jatin',380009) ;
    insert into customer values('C5','Mr.','Akbar',380008) ;
end;

create table city(
    location varchar(20) ,
    primary key(location),
    state varchar(20)
);
begin
    insert into city values('Ahmedabad','Gujarat');
    insert into city values('Rajkot','Gujarat');
    insert into city values('Vadodara','Gujarat');
end;

create table htel(
    hno varchar(3) ,
    primary key(hno) ,
    h_name varchar(30) ,
    zip int,
    location varchar(50) REFERENCES city(location)
);
begin
insert into htel values('H1', 'Inder_rsidency',380026,'Ahmedabad');
insert into htel values('H2', 'Prithvi',380024,        'Ahmedabad');
insert into htel values('H3', 'Cama',380001,           'Ahmedabad');
end;


create table room(
    rno varchar(3) ,
    primary key(rno) ,
    type varchar(30) ,
    price float
);
begin
insert into room values('R1', 'Deluxe', 1500);
insert into room values('R2', 'Semi-Deluxe', 2000);
insert into room values('R3', 'Single', 1000);
end;


create table rservation(
    rs_no varchar(5),
    primary key(rs_no) ,
    cno varchar(3) REFERENCES customer(cno) ,
    hno varchar(3) REFERENCES htel(hno) ,
    rno varchar(3) REFERENCES room(rno) ,
    arrival_date date,
    departure_date date 
);
begin
insert into rservation values('rs1', 'C1', 'H1', 'R1','1-27-2020','1-30-2020');
insert into rservation values('rs2', 'C2', 'H3', 'R2','1-24-2020','1-27-2020');
insert into rservation values('rs3', 'C3', 'H2', 'R3','1-24-2020','1-26-2020');
insert into rservation values('rs4', 'C4', 'H1', 'R3','1-27-2020','1-28-2020');
insert into rservation values('rs5', 'C5', 'H1', 'R2','1-29-2020','1-31-2020');
end;

/*answer of - 3*/
create or replace procedure disp_room as 
    cursor cur_room is select * from room ;
    r cur_room%rowtype;
begin
    for r in cur_room loop
        dbms_output.put_line(r.rno||' '||r.type||' '||r.price);
    end loop;
end;

declare
begin
    disp_room;
end;
/*answer of 1*/
/*Question 1 start*/
create or replace function customer_details(customer_id varchar) return int as
    customer_title varchar(5);
    customer_name varchar(20);
    customer_zip int;

begin
    select title, name, zip into customer_title, customer_name, customer_zip from customer where cno = customer_id;

    dbms_output.put_line('The details of the custoer are:');
    dbms_output.put_line('Customer Id: ' || customer_id || ' || Customer Name: ' || customer_title || ' ' || customer_name || ' || Customer Zip: ' || customer_zip);

    return 1;
end;

declare
customer_id varchar(10) := :Customer_Number;
temp int;

begin
    temp := customer_details(customer_id);
end;
/*answer of 2*/
create or replace procedure disp_rs(from_date date, too_date date) as 
    cursor cur_rs is select rs_no,cno ,hno , rno , arrival_date, departure_date from rservation;
    c1 cur_rs%rowtype;
    begin
    dbms_output.put_line('rservation --- cno---hno----rno----arrival_date----departure_date');
      for c1 in cur_rs loop
        if(c1.arrival_date >= from_date and c1.arrival_date <= too_date) then 
            if(c1.departure_date >= from_date and c1.departure_date <= too_date) then 
                dbms_output.put_line(c1.rs_no || '            '|| c1.cno||'    ' || c1.hno||'     '||c1.rno||'       '||c1.arrival_date||'     '||c1.departure_date);
             else
                dbms_output.put_line(c1.rs_no || '            '|| c1.cno||'    ' || c1.hno||'     '||c1.rno||'       '||c1.arrival_date);
            end if;
        else
            if(c1.departure_date >= from_date and c1.departure_date <= too_date) then
                dbms_output.put_line(c1.rs_no || '            '|| c1.cno||'    ' || c1.hno||'     '||c1.rno||'       '||c1.arrival_date);
            end if;
        end if;
      end loop;
    end;
declare
ff date := :frm;
ll date := :too;
begin
    disp_rs(ff,ll);
end;
/*Q - 3*/
create or replace procedure disp_room as 
    cursor cur_room is select * from room ;
    r_room cur_room%rowtype;
begin
    dbms_output.put_line('Room no    Room type         Price');
    for r_room in cur_room loop
        dbms_output.put_line(r_room.rno||'        '||r_room.type||'           '||r_room.price);
    end loop;
end;

declare
begin
    disp_room;
end;


/*answer of 4*/
/*Question 4 start*/
create or replace procedure get_htel as   
    cursor ht is select * from htel;
    cursor rs is select * from reservation;
    cursor rm is select * from room;

    h1 ht%rowtype;
    r1 rs%rowtype;
    ro1 rm%rowtype;

    cnt int := 0;
    cus_no varchar(10);
    cus_title varchar(5);
    cus_name varchar(20);
    room_no varchar(10);
    room_type varchar(30);
    arr_date date;
    dep_date date;
    days int;
    cnt2 int := 0;

begin
    for h1 in ht loop
        dbms_output.put_line(cnt || '. hotel Name: ' || h1.h_name);
        dbms_output.put_line('Customer Name     ' || 'Room Type     ' || 'Arrivale Date     ' || 'Total Stay(In days)');

        cnt2 := 0;

        for r1 in rs loop
            if(r1.hno = h1.hno) then
                cnt2 := cnt2 + 1;
                cus_no := r1.cno;
                room_no := r1.rno;
                arr_date := r1.arrival_date;
                dep_date := r1.departure_date;

                select title, name into cus_title, cus_name from customer where cno = cus_no;
                select type__ into room_type from room where rno = room_no;
                select dep_date - arr_date into days from dual;

                dbms_output.put_line(cus_title || cus_name || '             ' || room_type || '         ' || arr_date || '          ' || days);

            end if;
        end loop;

        dbms_output.put_line('Total no. of bookings: ' || cnt2);

        cnt := cnt + 1;
    end loop;
end;

declare
begin
    get_htel;
end;


/*Q5*/
create or replace procedure disp_ht as 
    cursor cur_h is select * from htel ;
    r cur_h%rowtype;
begin
    dbms_output.put_line('htel No.  htel Name   Zip  Location' );
    for r in cur_h loop
        dbms_output.put_line(r.hno||' '||r.h_name||' '||r.zip||' '||r.location);
    end loop;
end;
declare
begin
    disp_ht;
end;
/*answer of 6*/
create or replace procedure del_rservation(rservation_no varchar) as
  cursor c_rsv is select * from rservation;
  r_rsv c_rsv%rowtype;
  
  BEGIN
     open c_rsv;
      loop
       fetch c_rsv into r_rsv; 
           if c_rsv%notfound then 
                  exit;
             end if;
            
            DELETE FROM rservation  WHERE rs_no = rservation_no;
      END loop;
      close c_rsv;
  END;
declare
rservation_no varchar(10) := :rservation_number;
begin
  del_rservation(rservation_no);
end
select * from rservation

/*answer of 7*/
create or replace procedure inc_price(room_type varchar) as
    cursor c7 is select rno, type , price from room;
    r7 c7%rowtype;
    p int;
    begin
    for r7 in c7 loop
      if(room_type = r7.type) then
        p := (1.05)*(r7.price);
        dbms_output.put_line(p);
        UPDATE room SET price = p WHERE type = r7.type;
      end if;
    end loop;
      
    end;

declare
room_type varchar(30) := :room_type;
begin
  inc_price(room_type);
end;

select * from room

/*answer of 8*/
create or replace function count_room_from_type(roomtype in varchar2) return int as
         s int;
         cursor c1 is select count(rs_no) from rservation group by rno having rno in(select rno from room where type=roomtype);
begin
         open c1;
         fetch c1 into s;
         if c1%notfound then
              s := 0;
         end if;
         close c1;
         return s;
end;
select count_room_from_type('Deluxe') from dual

/*answer of 9*/
create or replace function rt return varchar2 as t varchar(30);
cursor cc is select rno, type, price from room;
p int := 100000;
rr cc%rowtype;
begin
  for rr in cc loop
    if(rr.price < p) then
       p := rr.price;
       t := rr.type;
    end if;
  end loop;
  return t;
end;

declare
room_type varchar(30) ;
begin
  room_type := rt();
dbms_output.put_line(room_type);
end;

/*answer of 10*/
create or replace function fooo(room_type varchar2) return int as p int;
cursor cc is select type,price from room;
rr cc%rowtype;
begin
  p := 0;
  for rr in cc loop
    if(rr.type = room_type) then
     p := rr.price;
     exit;
    end if;
  end loop;
  return p;
end;

declare
room_type  varchar(30):= :room_type;
price int;
begin
  price := fooo(room_type);
dbms_output.put_line(price);
end;

/*answer of 11*/
create or replace function tot_rs(from_date date, too_date date) return int as cnt int;
    cursor cur_rs is select arrival_date, departure_date from rservation;
    c1 cur_rs%rowtype;
    begin
      cnt := 0;
      for c1 in cur_rs loop
        if(c1.arrival_date >= from_date and c1.arrival_date <= too_date) then
            cnt := cnt + 1; 
        end if;
      end loop;
    return cnt;
    end;

declare
ff date := :frm;
ll date := :too;
total int;
begin
    total := tot_rs(ff,ll);
    dbms_output.put_line(total);
end;

/*answer of 12*/
create or replace function all_customer_details return int as
    cursor c_customer is select * from customer;
    cursor c_reservation is select * from reservation;
    cursor c_htl is select * from hotel;
    cursor c_room is select * from room;
    
    c1 c_customer%rowtype;
    r1 c_reservation%rowtype;
    h1 c_htl%rowtype;
    r2 c_room%rowtype;

begin
    dbms_output.put_line('The details of customers are:');
    for c1 in c_customer loop
        dbms_output.put_line('The name of customer: ' || c1.title ||''||c1.name );
        dbms_output.put_line('ID:'||c1.cno);
        for r1 in c_reservation loop
            if(r1.cno = c1.cno) then
                for r2 in c_room loop
                    if(r2.rno = r1.rno) then
                 
                        dbms_output.put_line('Room type:' ||r2.type);
                        dbms_output.put_line('Price payed:' ||r2.price);
            
                        exit;
                    end if;
                end loop;

                for h1 in c_htl loop
                    if(h1.hno = r1.hno) then
                         dbms_output.put_line('Hotel booked:' ||h1.h_name);
                        exit;
                    end if;
                end loop;
               
                
                dbms_output.put_line('Arrival date:' ||r1.arrival_date);
                dbms_output.put_line('Departed date:'||r1.departure_date);
                
            end if;
        end loop;

        dbms_output.put_line('');
    end loop;

    return 0;
end;

declare
    temp int;
begin
    temp := all_customer_details;
end;
