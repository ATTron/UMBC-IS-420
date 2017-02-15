-- 18
drop view customer_view;
create view customer_view as (select DISTINCT c.first_name, c.last_name, po.order_id, p.product_name, od.quantity from customer c, product p, order_details od, product_order po where c.customer_id = po.customer_id AND po.order_id = od.order_id AND od.product_id = p.product_id) order by order_id;
select * from customer_view;

-- 19
select first_name, last_name from customer_view group by first_name, last_name having COUNT(order_id) > 2;