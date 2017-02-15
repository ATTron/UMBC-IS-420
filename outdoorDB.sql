drop table order_details;
drop table product_order;
drop table club_membership;
drop table purchase_order;
drop table product;
drop table customer;
drop table club_activity;
drop table sporting_clubs;
drop table supplier;

drop sequence club_sequence;
drop sequence product_id_sequence;
drop sequence customer_sequence;
drop sequence membership_sequence;
drop sequence product_order_sequence;
drop sequence supplier_sequence;
drop sequence po_sequence;

create table sporting_clubs
(club_id number(3)constraint sporting_clubs_pk primary key,
name varchar2(30),
street varchar2(30),
city varchar2(15),
state char(2),
zip number(5),
phone varchar2(10));

create table club_activity
(club_id number(3)constraint club_activity_fk references sporting_clubs,
activity varchar2(15),
constraint club_activity_pk primary key (club_id,activity));

create table supplier
(supplier_id varchar2(4) constraint supplier_pk primary key,
name varchar2(30),
street varchar2(30),
city varchar2(15),
state char(2),
zip number(5),
phone varchar2(10));

create table product
(product_id number(5) constraint product_pk primary key,
product_name varchar2(30),
quantity_in_stock number(3),
reorder_point number(2),
price number(5,2),
supplier_id varchar2(4) constraint product_fk references supplier,
reorder_qty number(2));

create table purchase_order
(po_no varchar2(4) constraint purchase_order_pk primary key,
po_date date,
product_id number(5) constraint purchase_order_fk1 references product,
quantity number(3),
supplier_id varchar2(4) constraint purchase_order_fk2 references supplier);

create table customer
(customer_id number(3) constraint customer_pk primary key,
first_name varchar2(10),
last_name varchar2(10),
street varchar2(30),
city varchar2(15),
state char(2)default 'MO',
zip number(5),
phone varchar2(10));

create table club_membership
(membership_id number(5) constraint club_membership_pk primary key,
membership_date date,
duration number(2),
amount number(4),
payment_type varchar2(5)constraint membership_payment_type_ck check ((payment_type = 'CC') or (payment_type = 'Check')),
club_id number(3) constraint club_membership_fk1 references sporting_clubs,
customer_id number(3) constraint club_membership_fk2 references customer);

create table product_order
(order_id number(4) constraint product_order_pk primary key,
order_date date,
ship_date date,
payment_type varchar2(5)constraint prod_order_payment_type_ck check ((payment_type = 'CC') or (payment_type = 'Check')),
total number (6,2),
customer_id number(3) constraint product_order_fk1 references customer);

create table order_details
(order_id number(4),
product_id number(5),
quantity number(2),
constraint order_details_pk primary key (order_id,product_id),
constraint order_details_fk1 foreign key (order_id) references product_order,
constraint order_details_fk2 foreign key (product_id) references product);


create sequence club_sequence
start with 100
increment by 10
nocache;

insert into sporting_clubs
values(club_sequence.nextval, 'Hillside Mountain Club', '1 Winona St','Wichita','KS',34342,'3163997676');
insert into sporting_clubs
values(club_sequence.nextval, 'Branson Climbing Club', '2 Sherwood Dr.','Branson','MO',65670,'4174485676');
insert into sporting_clubs
values(club_sequence.nextval, 'Cherokee Rafting Club', '44 Kent Ave.','St. Charles','MO',66572,'3147780870');
insert into sporting_clubs
values(club_sequence.nextval, 'White Plains Club', '225 Tracy St.','New York','NY',13567,'2126678090');

insert into club_activity
values(100,'Hiking');
insert into club_activity
values(100,'Climbing');
insert into club_activity
values(100,'Walking');
insert into club_activity
values(110,'Hiking');
insert into club_activity
values(110,'Climbing');
insert into club_activity
values(110,'Conservation');
insert into club_activity
values(110,'Walking');
insert into club_activity
values(120,'Conservation');
insert into club_activity
values(120,'Canoeing');
insert into club_activity
values(130,'Conservation');
insert into club_activity
values(130,'Canoeing');
insert into club_activity
values(130,'Walking');

create sequence supplier_sequence
start with 500
increment by 10
nocache;

insert into supplier
values('S'||supplier_sequence.nextval,'Hillside Ski','2717 S. Western Ave.','Los Angeles','CA',90006,'7146654959');
insert into supplier
values('S'||supplier_sequence.nextval,'Tiger Mountain','2600 S. Vermont Ave.','Los Angeles','CA',90006,'7143327878');
insert into supplier
values('S'||supplier_sequence.nextval,'Asha Outdoor','44 S. LaSalle St.','Chicago','IL',60603,'3125554678');
insert into supplier
values('S'||supplier_sequence.nextval,'Sheraton Recreation','225 Tracy St.','New York','NY',13567,'2128889569');


create sequence product_id_sequence
start with 10010
increment by 1
nocache;

insert into product
values(product_id_sequence.nextval,'Beginner''s Ski Boot',20,5,9.75,'S500',25);
insert into product
values(product_id_sequence.nextval,'Intermediate Ski Boot',18,5,12.99,'S500',20);
insert into product
values(product_id_sequence.nextval,'Pro Ski Boot',21,7,15.49,'S510',25);
insert into product
values(product_id_sequence.nextval,'Beginner''s Ski Pole',15,3,25.49,'S500',20);
insert into product
values(product_id_sequence.nextval,'Intermediate Ski Pole',20,3,29.99,'S520',22);
insert into product
values(product_id_sequence.nextval,'Pro Ski Pole',21,5,34.99,'S530',25);
insert into product
values(product_id_sequence.nextval,'Road Bicycle',15,4,34.95,'S520',18);
insert into product
values(product_id_sequence.nextval,'Mountain Bicycle',19,4,49.99,'S520',20);
insert into product
values(product_id_sequence.nextval,'Tire Pump',8,2,7.99,'S530',10);
insert into product
values(product_id_sequence.nextval,'Water Bottle',25,4,2.49,'S510',25);
insert into product
values(product_id_sequence.nextval,'Bicycle Tires',30,5,4.99,'S500',33);
insert into product
values(product_id_sequence.nextval,'Bicycle Helmet',23,6,10.95,'S510',25);

create sequence po_sequence
start with 11
nocache;

insert into purchase_order
values('PO'||po_sequence.nextval,to_date('5/25/08','mm/dd/yy'),10011,20,'S500');
insert into purchase_order
values('PO'||po_sequence.nextval,to_date('5/12/08','mm/dd/yy'),10015,25,'S530');
insert into purchase_order
values('PO'||po_sequence.nextval,to_date('6/25/08','mm/dd/yy'),10011,20,'S500');
insert into purchase_order
values('PO'||po_sequence.nextval,to_date('6/15/08','mm/dd/yy'),10018,10,'S530');
insert into purchase_order
values('PO'||po_sequence.nextval,to_date('7/10/08','mm/dd/yy'),10015,25,'S530');
insert into purchase_order
values('PO'||po_sequence.nextval,to_date('7/25/08','mm/dd/yy'),10019,25,'S510');


create sequence customer_sequence
start with 101
nocache;

insert into customer
values(customer_sequence.nextval,'Jack','Russell','25 North Madison Ave.','Springfield','MO',65807,'4178823434');
insert into customer
values(customer_sequence.nextval,'Betty','Trumbell','550 South Court Dr.','St. Louis','MO',63140,'3125556670');
insert into customer
values(customer_sequence.nextval,'Anil','Kaul','400 South Circle St.','Kansas City','MO',64530,'4316667070');
insert into customer
values(customer_sequence.nextval,'Tom','Wiley','1500 North Grand St.','Springfield','MO',65810,'4178825560');
insert into customer
values(customer_sequence.nextval,'Sharon','Stone','200 West Wagner St.','Springfield','MO',65807,'4176668890');

create sequence membership_sequence
start with 10010
increment by 10
nocache;

insert into club_membership
values(membership_sequence.nextval,to_date('6/12/08','mm/dd/yy'),4,200,'CC',100,101);
insert into club_membership
values(membership_sequence.nextval,to_date('6/15/08','mm/dd/yy'),2,100,'Check',110,102);
insert into club_membership
values(membership_sequence.nextval,to_date('6/21/08','mm/dd/yy'),5,250,'Check',120,103);

create sequence product_order_sequence
start with 1001
nocache;

insert into product_order
values(product_order_sequence.nextval,to_date('5/27/08','mm/dd/yy'),to_date('6/1/08','mm/dd/yy'),'CC',134.95,102);
insert into product_order
values(product_order_sequence.nextval,to_date('5/28/08','mm/dd/yy'),to_date('6/2/08','mm/dd/yy'),'CC',134.85,103);
insert into product_order
values(product_order_sequence.nextval,to_date('5/28/08','mm/dd/yy'),to_date('6/3/08','mm/dd/yy'),'Check',12.45,104);
insert into product_order
values(product_order_sequence.nextval,to_date('6/5/08','mm/dd/yy'),to_date('6/10/08','mm/dd/yy'),'CC',44.43,105);
insert into product_order
values(product_order_sequence.nextval,to_date('6/6/08','mm/dd/yy'),to_date('6/8/08','mm/dd/yy'),'Check',52.48,103);
insert into product_order
values(product_order_sequence.nextval,to_date('6/8/08','mm/dd/yy'),to_date('6/12/08','mm/dd/yy'),'CC',131.94,104);


insert into order_details values(1001,10011,2);
insert into order_details values(1001,10015,3);
insert into order_details values(1002,10011,5);
insert into order_details values(1002,10016,2);
insert into order_details values(1003,10019,5);
insert into order_details values(1004,10018,3);
insert into order_details values(1004,10011,1);
insert into order_details values(1004,10019,3);
insert into order_details values(1005,10017,1);
insert into order_details values(1005,10019,1);
insert into order_details values(1005,10021,1);
insert into order_details values(1006,10012,4);
insert into order_details values(1006,10015,2);

commit;
