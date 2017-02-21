-- 1
select FIRST_NAME, LAST_NAME from customer;

-- 2
select PRODUCT_ID, PRODUCT_NAME, PRICE from product where price > 20;

-- 3
select t.TENANT_NAME, r.APT_NO from TENANT t INNER JOIN RENTAL r on t.RENTAL_NO = r.RENTAL_NO;

-- 4
select s.CLUB_ID, s.NAME, c.AMOUNT from SPORTING_CLUBS s, CLUB_MEMBERSHIP c where s.CLUB_ID = c.CLUB_ID AND AMOUNT > 100;

-- 5
select c.FIRST_NAME, c.LAST_NAME, cm.CLUB_ID from customer c RIGHT JOIN club_membership cm on c.customer_id = cm.customer_id;

-- 6
select staff_no, first_name, last_name, salary from staff order by salary DESC;
