-- 1
select AVG(salary) from staff;

-- 2
select payment_type, COUNT(order_id) from product_order group by payment_type;

-- 3
select supplier.supplier_id, name, COUNT(product.product_id) from supplier, product where supplier.supplier_id = product.supplier_id group by supplier.supplier_id, name having COUNT(product.product_id) > 2; 

-- 4
select apt_no from apartment where apt_rent_amt=(select max(apt_rent_amt) from apartment);

-- 5
create view family as (select tenant.tenant_ss, tenant_name, tenant_family.name from tenant full join tenant_family on tenant.tenant_ss = tenant_family.tenant_ss);
select * from family; 