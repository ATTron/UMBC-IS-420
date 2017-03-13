-- 1 A
create sequence KR_ORDER_SEQUENCE increment by 100 start with 1000;

-- 1 B
create table KR_Order(Order_Number number, 
Customer_name varchar2(50), 
Salesperson_name varchar2(50),
Amount number,
Constraint K_PK primary key(Order_Number));

-- 1 C
insert into KR_Order values(KR_ORDER_SEQUENCE.nextval, 'Jackie Foods', 'Anita Raina', 700);
insert into KR_Order values(KR_ORDER_SEQUENCE.nextval, 'Indie professional', 'Tom Selleck', 1200);
insert into KR_Order values(KR_ORDER_SEQUENCE.nextval, 'Tom Construction', 'Joe Walton', 1500);
insert into KR_Order values(KR_ORDER_SEQUENCE.nextval, 'Jackie Foods', 'Tom Selleck', 850);


-- 2
select membership_id, customer_id, add_months(membership_date, duration) as expiration_date from club_membership;

-- 3
set serveroutput on;

declare
  f_name customer.first_name%type;
  l_name customer.last_name%type;
  c_name sporting_clubs.name%type;
begin
  select first_name, last_name, sc.name into f_name, l_name, c_name
  from customer c, sporting_clubs sc, club_membership cm
  where c.customer_id = 102 AND sc.club_id = cm.club_id AND c.customer_id = cm.customer_id;
  dbms_output.put_line('First Name || Last Name || Club Name');
  dbms_output.put_line(f_name|| ' || ' || l_name || ' || ' || c_name);
end;

-- 4
set serveroutput on;

declare
  cursor pro_cur is
  select product_name, price from product;
  pro_row pro_cur%rowtype;
  price_status varchar2(15);
begin
  dbms_output.put_line('Product Name    ||    Price Status');
  dbms_output.put_line('------------          ------------');
  open pro_cur;
  loop
  fetch pro_cur into pro_row;
  exit when pro_cur%notfound;
  if pro_row.price  < 5 then
    price_status := 'low';
  elsif pro_row.price >= 5 AND pro_row.price =< 20 then
    price_status := 'medium';
  else
    price_status := 'high';
  end if;
  dbms_output.put_line(pro_row.product_name|| ' || ' ||price_status);
  end loop;
  close pro_cur;
end;
