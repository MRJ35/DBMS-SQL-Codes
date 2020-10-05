/*A travel agent has account customers and individual customers. Account customers who
have spent over 25,000 euros in the past year get a discount of 25%. Otherwise, they get
10% discount. Individual customers who have booked holidays previously get 5% discount.
New customers get no discount. Account customers who have spent over 10,000 euros in
any previous year will receive offers of free tickets on selected routes.
Display discount amount. Take required inputs from the user.*/

declare
typ varchar(20):= :type;
info varchar(20):= :info;
spent int:= :spent;
booked varchar(5):= :booked;
begin
if (typ = 'New') then
dbms_output.put_line('No discount');
end if;
if (typ = 'Old') then
if(booked = 'Yes') then
if (info = 'Account') then
if (spent > 250000 ) then
dbms_output.put_line('25% discount');
else
dbms_output.put_line('10% discount');
end if;
