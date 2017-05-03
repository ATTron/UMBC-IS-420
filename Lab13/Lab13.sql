-- 1
create or replace trigger tri_prod
before update
of price
on product
for each row
begin
dbms_output.put_line('Product Name: ' ||:OLD.product_name);
dbms_output.put_line('Old Price: ' ||:OLD.price);
dbms_output.put_line('New Price: ' ||:NEW.price);
end;

set serveroutput on;
update product set price=7 where product_id = 10020;

-- 2
create or replace trigger update_club_fee
after update 
of fee
on sporting_clubs
for each row
declare
  cursor club_c is select duration, club_id, amount from club_membership;
  club_row club_c%rowtype;
  old_amount number;
  new_amount number;
  club_in number;
begin
club_in := :old.club_id;
open club_c;
loop
  fetch club_c into club_row;
  exit when club_c%notfound;
  if (club_row.club_id = club_in ) then
    old_amount := club_row.amount;
    new_amount := club_row.duration * :new.fee;
    update club_membership set amount = new_amount 
    where club_in = club_membership.club_id;
    dbms_output.put_line('Club ID: ' ||:old.club_id);
    dbms_output.put_line('Previous Amount: ' ||old_amount);
    dbms_output.put_line('New Amount: ' ||new_amount);
  end if;
end loop;
close club_c;
end;

set serveroutput on;
update sporting_clubs set fee = 90 where club_id = 110;