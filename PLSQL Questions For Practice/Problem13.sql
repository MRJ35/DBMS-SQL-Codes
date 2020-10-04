/*
Refer following tables. 
Student(std_id, std_name)     

 Assignment(assignment_no, date_given, last_date_of_submission)     

 Submission(std_id, assignment_no, submitted_on_date)
Write a procedure to display summary in the following format.

<<current_date>>
                                Summary of Assignment Submission
Total no. of assignments given till date : ___________

Assignments which are submitted by all the students on time : ____________

Assignments which are submitted by all the students on time or late : ____________ 

Student names who have submitted all the assignments on time : ____________

Student names who have not submitted any of the assignments : ____________ 
*/
create or replace procedure ass_summary as
   CURSOR cu_sub IS SELECT * FROM Submission;
   r_sub cu_sub%ROWTYPE;
   CURSOR cu_ass IS SELECT * FROM Assignment;
   r_ass cu_ass%ROWTYPE;
   CURSOR cu_st IS SELECT * FROM Student;
   r_st cu_st%ROWTYPE;
   cnt int;
   assign_on_time int;
   assign_on_time_late int;
   flag int;
   flag2 int;
begin
   dbms_output.Put_line(sysdate);
   dbms_output.Put_line('SUMMARY OF ASSIGNMENTS SUBMISSION');
   dbms_output.Put_line('---------------------------------');
   OPEN cu_ass;
   cnt := 0;
   LOOP
     FETCH cu_ass INTO r_ass;
     EXIT WHEN cu_ass%NOTFOUND;
     cnt := cnt + 1;
   END LOOP;
   dbms_output.Put_line('Total no. of assignments: '||cnt);
   CLOSE cu_ass;
   dbms_output.Put('Assignments which are submitted by all the students on time: ');
   OPEN cu_ass;
   flag := 1;
   LOOP
   FETCH cu_ass INTO r_ass;
   EXIT WHEN cu_ass%NOTFOUND;
   flag := 1;
   OPEN cu_st;
     LOOP
     FETCH cu_st INTO r_st;
     EXIT WHEN cu_st%NOTFOUND;
     OPEN cu_sub;
       LOOP
       FETCH cu_sub INTO r_sub;
       EXIT WHEN cu_sub%NOTFOUND;
          if(r_sub.std_id = r_st.std_id and r_sub.assignment_no = r_ass.assignment_no and                                  r_sub.submitted_on_date >  r_ass.last_date_of_submission) then
             flag := 0;
          end if;
       END LOOP;
       CLOSE cu_sub;
    END LOOP;
    CLOSE cu_st;
    if(flag=1)then
       dbms_output.Put_line(r_ass.assignment_no);
    end if;
   END LOOP;
   CLOSE cu_ass;
   if(flag=0) then
   dbms_output.Put_line('none');
   end if;
   dbms_output.Put('Assignments which are submitted by all the students on time or late: ');
   OPEN cu_ass;
   LOOP
   FETCH cu_ass INTO r_ass;
   EXIT WHEN cu_ass%NOTFOUND;
     dbms_output.Put(r_ass.assignment_no||' ');
   END LOOP;
   CLOSE cu_ass;
   dbms_output.Put_line(''); 
   dbms_output.Put('Student names who have submitted all the assignments on time: ');
   OPEN cu_st;
   LOOP
   FETCH cu_st INTO r_st;
   EXIT WHEN cu_st%NOTFOUND;
   flag := 1;
     OPEN cu_ass;
     LOOP
     FETCH cu_ass INTO r_ass;
     EXIT WHEN cu_ass%NOTFOUND;
      OPEN cu_sub;
      LOOP
      FETCH cu_sub INTO r_sub;
      EXIT WHEN cu_sub%NOTFOUND;
        if(r_sub.std_id = r_st.std_id and r_sub.assignment_no = r_ass.assignment_no and                                  r_sub.submitted_on_date > r_ass.last_date_of_submission) then
        flag := 0;
        end if;
      END LOOP;
      CLOSE cu_sub;
     END LOOP;
     if(flag=1)then
      dbms_output.Put_line(r_st.std_name);
     end if;
   CLOSE cu_ass;
   END LOOP;
   CLOSE cu_st;
   dbms_output.Put('Student names who have not submitted any of the assignments on time: ');
   OPEN cu_st;
   flag2 := 0;
   LOOP
   FETCH cu_st INTO r_st;
   EXIT WHEN cu_st%NOTFOUND;
    flag := 1;
    OPEN cu_ass;
    LOOP
    FETCH cu_ass INTO r_ass;
    EXIT WHEN cu_ass%NOTFOUND;
      OPEN cu_sub;
      LOOP
      FETCH cu_sub INTO r_sub;
      EXIT WHEN cu_sub%NOTFOUND;
       if(r_sub.std_id = r_st.std_id and r_sub.assignment_no = r_ass.assignment_no and                                   r_sub.submitted_on_date<= r_ass.last_date_of_submission) then
       flag := 0;
       end if;
     END LOOP;
     CLOSE cu_sub;
   END LOOP;
   if(flag=1)then
     flag2 := 1;
     dbms_output.Put_line(r_st.std_name);
   end if;
   CLOSE cu_ass;
   END LOOP;
   if(flag2=0)then
   dbms_output.Put_line('none');
   end if;
   CLOSE cu_st;
end;
/
declare 
begin
  ass_summary;
end;
/