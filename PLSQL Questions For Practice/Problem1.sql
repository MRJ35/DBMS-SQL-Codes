/*
Input any number and display following patterns. Ex., Inputted number is 5, program
should display 5 lines.
1
2 3
4 5 6
7 8 9 10
1
0 1
1 0 1
0 1 0 1
1 0 1 0 1
*/

DECLARE
    s INTEGER:=:s;
    i INTEGER;
    j INTEGER;
    temp INTEGER;
BEGIN
    temp := 1;
    FOR i IN 1..(s-1) LOOP
        FOR j IN 1..i LOOP
           dbms_output.put(temp||' ');
           temp := temp + 1;
        END LOOP;
    dbms_output.put_line(' ');
    END LOOP;
END;

DECLARE
    s INTEGER:=:s;
    i INTEGER;
    j INTEGER;
    temp2 boolean;
BEGIN
    temp2 := true;
    FOR i IN 1..s LOOP
        IF MOD(i,2)=0 THEN
            temp2 := false;
        ELSE
            temp2 := true;
        END IF;
        FOR j IN 1..i LOOP
           IF temp2 = true THEN
              dbms_output.put(1||' ');
           ELSE
              dbms_output.put(0||' ');
           END IF;
           temp2 := NOT temp2;
        END LOOP;
    dbms_output.put_line(' ');
    END LOOP;
END;