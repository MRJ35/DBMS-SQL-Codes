/*
A postal delivery company delivers parcels by air or rail transport. The price of delivery by air depends upon the weight of the parcel. There is a basic charge of 5 euros per kilo up to 50 kilos. Excess weight over 50 kilos is charged at 3 euros per kilo. Delivery by rail is charged at 3 euros per kilo up to 50 kilos and THEN 2 euros per kilo. There is a special service guaranteeing same day delivery which carries an additional flat rate charge of 20 euros. Any deliveries overseas are charged at double the normal rate. Input mode of transport, weight of parcel, delivery is domestic or overseas and
delivery to be done same day or not. According to the mentioned rules, display charges.
*/

DECLARE
    transport varchar(200):=:transport;
    weight INTEGER:=:weight;
    delivery varchar(200):=:delivery;
    isday varchar(200):=:isday;
    charge INTEGER:=0;
BEGIN
    IF(transport='air') THEN
        IF(weight<50) THEN
            charge := weight*5;
        ELSE
            charge := 50*5 + (weight-50)*8;
        END IF;
    END IF;
    IF(transport='rail') THEN
        IF(weight<50) THEN
            charge := weight*3;
        ELSE
            charge := 50*3 + (weight-50)*5;
        END IF;
    END IF;
    IF(delivery='overseas') THEN
            charge := charge * 2;
    END IF;
    IF(isday='yes') THEN
            charge := charge + 20;
    END IF;
    dbms_output.put_line('charge is ' || charge);
END;
/