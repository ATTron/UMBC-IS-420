-- 1
create or replace procedure PrintClubName (club_in IN number) is
club_name sporting_clubs.name%type;
club_city sporting_clubs.city%type;
begin
  select name, city into club_name, club_city
  from sporting_clubs
  where club_id = club_in;
  dbms_output.put_line('Club Name: ' ||club_name);
  dbms_output.put_line('City: ' ||club_city);
end;

-- 2
set serveroutput on;
create or replace function ProdCheck(prod_in in number)
  return varchar2 is
pro_located product.product_name%type;
begin
  select product_name into pro_located
  from product 
  where product_id = prod_in;
  return pro_located;
  exception
    when no_data_found then
      pro_located := 'Empty';
      return pro_located;
end;


create or replace procedure ProdDetails(id_in in number) is
  pro_name product.product_name%type;
  pro_price product.price%type;
  pro_exists varchar2(60);
begin
  pro_exists := ProdCheck(id_in);
  if pro_exists = 'Empty' then
    dbms_output.put_line('Product not in database !');
  else
    select product_name, price into pro_name, pro_price
    from product
    where product_id = id_in;
    dbms_output.put_line('Product Name: ' ||pro_name);
    dbms_output.put_line('Product Price: ' ||pro_price);
  end if;
end;

Execute PRODDETAILS(10017);
Execute PRODDETAILS(10025);
