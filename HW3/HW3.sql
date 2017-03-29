-- 1
set serveroutput on;
create or replace procedure ex3b_membership(mem_in in number) is
  cursor club_c is
  select cm.membership_id, c.first_name, c.last_name, c.city
  from customer c, club_membership cm
  where cm.customer_id = mem_in and cm.customer_id = c.customer_id;
  row_c club_c%rowtype;
begin
  open club_c;
  loop
  fetch club_c into row_c;
  exit when club_c%notfound;
  dbms_output.put_line('Membership ID: ' ||row_c.membership_id);
  dbms_output.put_line('First Name: ' ||row_c.first_name);
  dbms_output.put_line('Last Name: ' ||row_c.last_name);
  dbms_output.put_line('City: ' ||row_c.city);
  end loop;
  close club_c;
end;

execute EX3B_MEMBERSHIP(101);

-- 2
set serveroutput on;
create or replace function ex3b_check_quantity(q_in in number, prod_in in number)
return boolean is
av_num product.QUANTITY_IN_STOCK%type;
begin
av_num := 0;
select QUANTITY_IN_STOCK into av_num from PRODUCT
where PRODUCT_ID = prod_in;
if av_num > q_in then
  return true;
else 
  return false;
end if;
end;

create or replace procedure ex3b_new_order(cust_in in number, prod_in in number, q_in in number, pay_in in varchar2) is
  cust_id customer.customer_id%type;
  prod_id product.product_id%type;
  pay product_order.payment_type%type;
  p_price product.price%type;
  msg varchar2(200);
begin
  msg := 'Product ID is not correct.';
  select product_id
  into prod_id
  from product
  where product_id = prod_in;

  msg := 'Customer ID is not correct.';
  select  customer_id
  into cust_id
  from customer
  where customer_id = cust_in;

  msg := 'Payment Type is not correct.';
  select distinct payment_type
  into pay
  from product_order
  where upper(payment_type) = upper(pay_in)
  and customer_id = cust_in;

  select price
  into p_price
  from product
  where product_id = prod_in;

  if ex3b_check_quantity(q_in, prod_in) then
    insert into product_order values (product_order_sequence.nextval, sysdate, sysdate + 5, pay_in, p_price * q_in, cust_id);
    dbms_output.put_line('Order Placed!');
  else
    dbms_output.put_line('Order cannot be place at this time.');
  end if;
  Exception 
  when no_data_found then
    dbms_output.put_line(msg);
end;

execute EX3B_NEW_ORDER(150,10010,15,'CC');
execute EX3B_NEW_ORDER(105,100100,15,'CC');
execute EX3B_NEW_ORDER(105,10010,15,'KK');
execute EX3B_NEW_ORDER(105,10010,50,'CC');
execute EX3B_NEW_ORDER(105,10010,15,'CC');
