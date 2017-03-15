-- 1
set serveroutput on
create or replace procedure ProductCheck(id_in in number) is
  prod_name product.product_name%type;
  prod_price product.price%type;
begin
  select price, product_name into prod_price, prod_name
  from product
  where product_id = id_in;
  dbms_output.put_line('Product Name ' ||prod_name);
  dbms_output.put_line('Product Price ' ||prod_price);
exception
  when no_data_found then
  dbms_output.put_line('No such product found in database!');
end;

Execute ProductCheck(10010);
Execute ProductCheck(100101);

-- 2
set serveroutput on;
create or replace procedure AvgInvoiceDueCheck(rental_in in number) is
  avg_invoice number;
  High_Invoice_Exception exception;
begin
  select avg(invoice_due) into avg_invoice from rental_invoice ri, rental r
  where r.rental_no = rental_in AND ri.rental_no = rental_in;
  if avg_invoice >= 400 then
    raise High_Invoice_Exception;
  else
    dbms_output.put_line('Average Invoice Due: ' ||avg_invoice);
  end if;
  Exception
    when High_Invoice_Exception then
      dbms_output.put_line('High Invoice Due!');
end;

Execute AVGINVOICEDUECHECK(100104);
Execute AVGINVOICEDUECHECK(100103);

-- 3
set serveroutput on;
create or replace procedure SupplyAndProductCheck(supp_in in varchar2, prod_in in number) is
  prod_name product.product_name%type;
  supp_name supplier.name%type;
  msg varchar2(200);
begin
  msg := 'Supplier id is incorrect!';
  select name into supp_name from supplier where supplier_id = supp_in;
  msg := 'Product id is incorrect!';
  select product_name into prod_name from product where product_id = prod_in;
  select p.product_name, s.name into prod_name, supp_name 
  from product p, supplier s
  where s.supplier_id = supp_in AND p.product_id = prod_in;
  dbms_output.put_line('Product Name: ' ||prod_name);
  dbms_output.put_line('Supplier Name: ' ||supp_name);
  Exception
    when no_data_found then
      dbms_output.put_line(msg);
end;

Execute SUPPLYANDPRODUCTCHECK('S20', 10014);
Execute SUPPLYANDPRODUCTCHECK('S500', 100101);
Execute SUPPLYANDPRODUCTCHECK('S510', 10019);
