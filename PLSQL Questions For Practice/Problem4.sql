/*
Input any date with time. Extract time and day from Inputted date. IF time is not between 10 am to 6 pm and day is not weekdays, display the message “Office is closed” ELSE display “Office is Open”.
*/

DECLARE
    d TIMESTAMP:=:d;
    hh INTEGER;
    mm INTEGER;
    ss INTEGER;
    dy varchar(200);
BEGIN
    hh := extract(hour from d);
    mm := extract(mINute from d);
    ss := extract(second from d);
    dy := rtrim(to_char(d,'dy'));
    IF hh>=10 and hh<=18 and dy not IN ('sat','sun') THEN
        IF hh=18 and (mm!=0 or ss!=0) THEN
            dbms_output.put_line('Office is closed');
        ELSE
            dbms_output.put_line('Office is open');
        END IF;
    ELSE
        dbms_output.put_line('Office is closed.');
    END IF;
    dbms_output.put_line(hh);
END;
/