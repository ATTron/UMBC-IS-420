-- 1
select name from SPORTING_CLUBS where ROWNUM <= 3;

--2
select sequence_name from USER_SEQUENCES;

--3
create sequence MYSEQ increment by 5 start with 100;
select MYSEQ.nextval from dual;

--4
select first_name, last_name, concat(state,concat('_',zip)) from customer;

--5
select order_id, payment_type, round(months_between(to_date('10/10/2008','mm/dd/yyyy'), ship_date)) as order_date from product_order;
select ship_date from product_order;

--6
set serveroutput on;
declare
currseq number;
nextseq number;
begin
--currseq := myseq.currval;
select myseq.nextval into currseq from dual;
nextseq := myseq.nextval;
dbms_output.put_line(currseq);
dbms_output.put_line(nextseq);
end;
