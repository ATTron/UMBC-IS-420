-- 4
select DISTINCT c.first_name, c.last_name from customer c where c.customer_id IN (select customer_id from product_order);

-- 5
select DISTINCT c.first_name, c.last_name from customer c right join product_order p on c.customer_id = p.customer_id;

-- 9
select product_name from product where product_name like '%Pole';

-- 11
select product_name, reorder_point from product;

-- 14
select product_id, product_name, (quantity_in_stock - reorder_point) as remaining_stock from product;