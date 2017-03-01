-- 1
set serveroutput on;
Declare
  sumOfNum number:= 0;
  itr number:=0;
Begin
  loop
    sumOfNum := sumOfNum + itr;
    itr := itr + 2;
    exit when itr > 200;
  end loop;
  dbms_output.put_line('Sum of of even numbers from 1 to 200: ' || sumOfNum);
End;

-- 2
set serveroutput on;

declare
  p_name product.product_name%type;
  p_price product.price%type;
begin
  select product_name, price into p_name, p_price from product
  where product_id = 10016;
  dbms_output.put_line('Product Name: ' || p_name);
  dbms_output.put_line('Product Price: ' || p_price);
end;

-- 3
set serveroutput on;

declare 
  cursor club_c is
  select name, street, city 
  from sporting_clubs 
  where state = 'MO';
  club_row club_c%rowtype;
begin
  dbms_output.put_line('NAME   ||  Street  ||  City');
  dbms_output.put_line('---------------------------');
  dbms_output.put_line('---------------------------');
  open club_c;
  loop
  fetch club_c into club_row;
  exit when club_c%notfound;
  dbms_output.put_line(club_row.name||'  ||  '||club_row.street||'  ||  '||club_row.city);
  end loop;
  close club_c;
end;
