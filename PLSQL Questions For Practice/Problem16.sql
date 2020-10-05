/*
Refer following tables.

Category(category_id, category_name)

Event(event_id, event_name, category_id)

Participant(participant_id, participant_name, event_id, gender)
Write a procedure to display participation report with summary in the following format.

<<current_date>>
                                                   PARTICIPATION DETAILS
Event name : _____________		

Sr No.			Participant name            

Total no of participants in the event <<event_name>> are : ______

Event name : _____________		

Sr No.			Participant name

Total no of participants in the event <<event_name>> are : _________

Total no of participants who are girls : _____________

Total no of participants who are boys : _____________

Overall total no. of participants : ____________
The maximum participation is in the event ___________________and the minimum participation is in the event____________.
*/

create table Participant(participant_id int primary key, participant_name varchar(30), event_id int references Event(event_id), gender varchar(6));
begin
insert into Participant values(1,'S',1,'Female');
insert into Participant values(2,'N',1,'Female');
insert into Participant values(3,'D',2,'Male');
insert into Participant values(4,'U',2,'Male');
insert into Participant values(5,'H',3,'Female');
insert into Participant values(6,'Na',3,'Male');
insert into Participant values(7,'Ha',4,'Male');
insert into Participant values(8,'Y',4,'Male');
insert into Participant values(9,'M',5,'Female');
insert into Participant values(10,'P',5,'Male');
insert into Participant values(11,'A',6,'Female');
insert into Participant values(12,'Dh',6,'Female');
end

create or replace procedure disp_details as
      CURSOR cu_cat IS SELECT * FROM Category;
      r_cat cu_cat%ROWTYPE;
      CURSOR cu_ent IS SELECT * FROM Event;
      r_ent cu_ent%ROWTYPE;
      CURSOR cu_par IS SELECT * FROM Participant;
      r_par cu_par%ROWTYPE;
      sr_no int;
      girl_t int;
      boy_t int;
      indi_t int;
      max1 int;
      min1 int;
      total1 int;
      max_e varchar(50);
      min_e varchar(50);
BEGIN
     dbms_output.Put_line(sysdate);
     dbms_output.Put_line('                        PARTICIPATION DETAILS');
     dbms_output.Put_line('                     ----------------------------');
     girl_t :=0;
     boy_t :=0;
     max1 := 0;
     min1 := 100;
     OPEN cu_ent;
     LOOP  
         FETCH cu_ent INTO r_ent;
         EXIT WHEN cu_ent%NOTFOUND;
         dbms_output.Put_line('Event Name: ' || r_ent.event_name);
         dbms_output.Put_line('Sr No.          Participant name   ');
         sr_no := 1;
         indi_t := 0;
         OPEN cu_par;
         LOOP            
             FETCH cu_par INTO r_par;
             EXIT WHEN cu_par%NOTFOUND;
             if(r_ent.event_id = r_par.event_id) then
             dbms_output.Put_line(sr_no||'                 '||r_par.participant_name);
             sr_no := sr_no+1;
             indi_t := indi_t + 1;
             if(r_par.gender = 'Male')then
                 boy_t := boy_t + 1;
             end if;
             if(r_par.gender = 'Female')then
                 girl_t := girl_t + 1;
             end if;
             end if;                
         END LOOP;
         CLOSE cu_par;
     dbms_output.Put_line('Total no. of participants in the event '|| r_ent.event_name||':'|| indi_t);
     if(indi_t>max1)then
        max1 := indi_t;
        max_e := r_ent.event_name;
     end if;  
     if(indi_t<min1)then
        min1 := indi_t;
        min_e := r_ent.event_name;
     end if;          
     dbms_output.Put_line('--------------------------------------------------------------------------------');
     END LOOP;
     CLOSE cu_ent;
     dbms_output.Put_line('Total no. of girls participant: '||girl_t);
     dbms_output.Put_line('Total no. of boys participant: '||boy_t);
     total1 := boy_t+girl_t;
     dbms_output.Put_line('Total no. of participant: '||total1);
     dbms_output.Put_line('The maximum participation is in the event: '||max_e);
     dbms_output.Put_line('The minimum participation is in the event '||min_e);  
     dbms_output.Put_line('--------------------------------------------------------------------------------');    
END;
/

declare
begin
   disp_details;
end;

