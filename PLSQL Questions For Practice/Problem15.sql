/*
Refer following tables.
Category(category_id, category_name)

Event(event_id, event_name, category_id)
Write a procedure to display category-wise events in the descending order of category and ascending order of events within each category in the following format. <<current_date>>
Category-wise list of events
Category Name : <<category_name>>		

Event Name             

Total no of events in the category <<category_name>> : ______

Category Name : <<category_name>>		

Event Name            

Total no of events in the category <<category_name>> : ______
Total no of categories : ____________
*/

create or replace procedure disp_category as
      CURSOR cu_cat IS SELECT * FROM Category ORDER BY category_name DESC;
      r_cat cu_cat%ROWTYPE;
      CURSOR cu_ent IS SELECT * FROM Event ORDER BY event_name;
      r_ent cu_ent%ROWTYPE;
      counte int;
      countc int;
BEGIN
     dbms_output.Put_line(sysdate);
     dbms_output.Put_line('                        CATEGORY WISE EVENTS');
     dbms_output.Put_line('                        ----------------------------');
     OPEN cu_cat;
     countc := 0;
     LOOP  
         FETCH cu_cat INTO r_cat; 
         EXIT WHEN cu_cat%NOTFOUND; 
         countc := countc+1;
         dbms_output.Put_line('Category Name: ' || r_cat.category_name);
         dbms_output.Put_line('Events:');
         OPEN cu_ent;
         counte := 0;
         LOOP             
             FETCH cu_ent INTO r_ent; 
             EXIT WHEN cu_ent%NOTFOUND;
             if(r_cat.category_id = r_ent.category_id ) then
                   counte := counte+1;
                   dbms_output.Put_line('          '||r_ent.event_name);    
             end if;       
         END LOOP;
         CLOSE cu_ent;
     dbms_output.Put_line('          Total no. of events in the category '|| r_cat.category_name|| ': ' || counte);       
     dbms_output.Put_line('---------------------------------------------------------------------------------------');
     END LOOP;
     CLOSE cu_cat;
     dbms_output.Put_line('Total no. of categories: '|| countc);  
     dbms_output.Put_line('---------------------------------------------------------------------------------------');     
END;
/

declare
begin
   disp_category;
end;


