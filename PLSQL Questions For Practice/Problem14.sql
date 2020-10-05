/*
Refer following tables.
Category(category_id, category_name)

Event(event_id, event_name, category_id)
Write a function which will take category_name as a parameter and will return all event names of that category.
*/
create table Category(category_id int primary key, category_name varchar(20));
create table Event(event_id int primary key, event_name varchar(50), category_id int references Category(category_id));

insert into Category values(1,'Fine Arts');
insert into Category values(2,'Literary ');
insert into Category values(3,'Programming');
begin
insert into Event values(1,'Glass Painting',1);
insert into Event values(2,'Pencil Sketching',1);
insert into Event values(3,'Debate',2);
insert into Event values(4,'JAM',2);
insert into Event values(5,'Quiz',3);
insert into Event values(6,'Workshop',3);
end

create or replace function disp_cat(cat_name varchar) RETURN varchar as
   temp1 varchar(50);
   CURSOR cu_cat IS SELECT * FROM Category;
   r_cat cu_cat%ROWTYPE;
   CURSOR cu_ent IS SELECT * FROM Event;
   r_ent cu_ent%ROWTYPE;
BEGIN
  OPEN cu_cat;
  LOOP
  FETCH cu_cat INTO r_cat;
  EXIT WHEN cu_cat%NOTFOUND;
  if(r_cat.category_name = cat_name)then
    OPEN cu_ent;
    LOOP
    FETCH cu_ent INTO r_ent;
    EXIT WHEN cu_ent%NOTFOUND;
    if(r_cat.category_id = r_ent.category_id)then
      temp1 := CONCAT(temp1,' ');
      temp1 := CONCAT(temp1,r_ent.event_name);
    end if;
    END LOOP;
    CLOSE cu_ent;
  end if;
  END LOOP;
  CLOSE cu_cat;
  RETURN temp1;
END;
/ 

declare
s varchar(50) := :category;
outp varchar(50);
begin
outp := disp_cat(s);
dbms_output.Put_line(outp);
end;
/