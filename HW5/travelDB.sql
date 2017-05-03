drop table hotel_reservation;
drop table hotel;
drop table flight_ticket;
drop table ticket;
drop table travel_customer;
drop table flight;
drop table airline;

drop sequence tw_flight_sequence;
drop sequence gl_flight_sequence;
drop sequence travel_cust_sequence;
drop sequence ticket_sequence;
drop sequence hotel_reserve_sequence;
drop sequence hotel_id_sequence;

create table airline
(name varchar2(10) constraint airline_pk primary key,
street varchar2(30), 
city varchar2(15), 
state char(2), 
zip number(5),
phone varchar2(10)); 


create table flight
(flight_no varchar2(6) constraint flight_pk primary key, 
org_City varchar2(30), 
dest_city varchar2(30), 
depart_time date, 
arrival_time date, 
air_miles int, 
fare int,
seat int, 
model varchar2(5),
name varchar2(10) constraint flight_fk1 references airline, 
org_region varchar2(15), 
dest_region varchar2(15));


create table travel_customer
(customer_id int constraint travel_customer_pk primary key, 
first_name varchar2(15), 
last_name varchar2(15), 
street varchar2(30), 
city varchar2(15), 
state char(2), 
zip number(5), 
phone varchar2(10),
age int, 
meals char(1) default 'R' constraint customer_meals_ck check ((meals = 'S') or (meals = 'V') or (meals = 'K') or (meals = 'R')), 
asst char(1));


create table ticket
(ticket_no number(6) constraint ticket_pk primary key, 
issued_date date, 
flight_date date, 
origin_city varchar2(30), 
dest_city varchar2(30), 
quoted_fare number(6,2), 
customer_ID int constraint ticket_fk1 references travel_customer); 


create table flight_ticket
(flight_no varchar2(6) constraint flight_ticket_fk1 references flight, 
ticket_no number(6) constraint flight_ticket_fk2 references ticket,
constraint flight_ticket_pk primary key (flight_no,ticket_no));


create table hotel
(hotel_ID int constraint hotels_pk primary key, 
hotel_name varchar(25), 
street varchar2(30), 
city varchar2(15), 
state char(2), 
zip number(5),
phone varchar2(10),
rate number(3),
rooms number(2),
bed_type char(2) constraint hotel_bed_type_ck check ((bed_type = 'DT') or (bed_type = 'DQ')));


create table hotel_reservation
(reserve_no int constraint hotel_reservation_pk primary key, 
reserve_date date, 
arrival_date date, 
dep_date date, 
baby_crib char(1), 
num_adults int, 
num_kids int, 
customer_id int constraint hotel_reservation_fk1 references travel_customer, 
hotel_ID int constraint hotel_reservation_fk2 references hotel); 

create sequence tw_flight_sequence
start with 122
increment by 20;

create sequence gl_flight_sequence
start with 155
increment by 20;

insert into airline
values('Tranworld','123 S. LaSalle Ave.','Chicago','IL',60611,'3128879025');
insert into airline
values('Global','440 S. Lindberg','St. Louis','MO',63140,'3142326554');

insert into flight
values('TW'||tw_flight_sequence.nextval,'Detroit','Los Angeles',to_date('1:10PM','hh:miPM'),to_date('3:15PM','hh:miPM'),1500,120,14,'767','Tranworld','Americas','Americas');
insert into flight
values('TW'||tw_flight_sequence.nextval,'Detroit','Amsterdam',to_date('5:15PM','hh:miPM'),to_date('8:25AM','hh:miAM'),3500,760,15,'747','Tranworld','Americas','Europe');
insert into flight
values('TW'||tw_flight_sequence.nextval,'Detroit','Seoul',to_date('4:05PM','hh:miPM'),to_date('6:30AM','hh:miAM'),5500,700,11,'747','Tranworld','Americas','Asia');
insert into flight
values('TW'||tw_flight_sequence.nextval,'Los Angeles','Memphis',to_date('6:15PM','hh:miPM'),to_date('8:40PM','hh:miPM'),1250,155,2,'767','Tranworld','Americas','Americas');
insert into flight
values('TW'||tw_flight_sequence.nextval,'Detroit','New York',to_date('2:20PM','hh:miPM'),to_date('5:40PM','hh:miPM'),1250,55,6,'A300','Tranworld','Americas','Americas');
insert into flight
values('TW'||tw_flight_sequence.nextval,'St. Louis','Detroit',to_date('10:05AM','hh:miAM'),to_date('11:15AM','hh:miAM'),750,45,5,'737','Tranworld','Americas','Americas');
insert into flight
values('TW'||tw_flight_sequence.nextval,'Memphis','Detroit',to_date('8:30AM','hh:miAM'),to_date('10:15AM','hh:miAM'),750,82,18,'A300','Tranworld','Americas','Americas');
insert into flight
values('TW'||tw_flight_sequence.nextval,'Los Angeles','Tokyo',to_date('4:25PM','hh:miPM'),to_date('11:15AM','hh:miAM'),4570,650,12,'747','Tranworld','Americas','Asia');
insert into flight
values('TW'||tw_flight_sequence.nextval,'Amsterdam','Rome',to_date('10:40AM','hh:miAM'),to_date('2:20PM','hh:miPM'),2570,216,3,'767','Tranworld','Americas','Europe');
insert into flight
values('TW'||tw_flight_sequence.nextval,'Tokyo','Hong Kong',to_date('1:30PM','hh:miPM'),to_date('6:35PM','hh:miPM'),1750,103,8,'747','Tranworld','Asia','Asia');
insert into flight
values('TW'||tw_flight_sequence.nextval,'Seoul','Hong Kong',to_date('9:10AM','hh:miAM'),to_date('2:45PM','hh:miPM'),2750,148,6,'747','Tranworld','Asia','Asia');
insert into flight
values('TW'||tw_flight_sequence.nextval,'Los Angeles','Las Vegas',to_date('5:05PM','hh:miPM'),to_date('6:30PM','hh:miPM'),750,45,3,'737','Tranworld','Americas','Americas');
insert into flight
values('TW'||tw_flight_sequence.nextval,'Detroit','New Orleans',to_date('2:10PM','hh:miPM'),to_date('4:55PM','hh:miPM'),1500,79,8,'767','Tranworld','Americas','Americas');
insert into flight
values('TW'||tw_flight_sequence.nextval,'Detroit','Orlando',to_date('1:20PM','hh:miPM'),to_date('4:40PM','hh:miPM'),1670,120,4,'A300','Tranworld','Americas','Americas');
insert into flight
values('GL'||gl_flight_sequence.nextval,'Chicago','New York',to_date('11:15AM','hh:miAM'),to_date('4:05PM','hh:miPM'),1750,75,15,'767','Global','Americas','Americas');
insert into flight
values('GL'||gl_flight_sequence.nextval,'Chicago','London',to_date('6:05PM','hh:miPM'),to_date('9:50AM','hh:miAM'),4050,445,11,'A330','Global','Americas','Europe');
insert into flight
values('GL'||gl_flight_sequence.nextval,'Chicago','Seoul',to_date('5:25PM','hh:miPM'),to_date('7:05AM','hh:miAM'),4500,670,7,'747','Global','Americas','Asia');
insert into flight
values('GL'||gl_flight_sequence.nextval,'Dallas','Detroit',to_date('9:20AM','hh:miAM'),to_date('12:20PM','hh:miPM'),1250,68,3,'737','Global','Americas','Americas');
insert into flight
values('GL'||gl_flight_sequence.nextval,'Dallas','Frankfurt',to_date('4:45PM','hh:miPM'),to_date('11:10AM','hh:miAM'),3750,475,7,'A330','Global','Americas','Europe');
insert into flight
values('GL'||gl_flight_sequence.nextval,'Dallas','Tokyo',to_date('5:30PM','hh:miPM'),to_date('1:10PM','hh:miPM'),5750,620,8,'747','Global','Americas','Asia');
insert into flight
values('GL'||gl_flight_sequence.nextval,'New York','Frankfurt',to_date('6:15PM','hh:miPM'),to_date('8:50AM','hh:miAM'),3870,332,16,'767','Global','Americas','Europe');
insert into flight
values('GL'||gl_flight_sequence.nextval,'Frankfurt','Rome',to_date('1:40PM','hh:miPM'),to_date('4:55PM','hh:miPM'),1200,178,3,'767','Global','Europe','Europe');
insert into flight
values('GL'||gl_flight_sequence.nextval,'London','Rome',to_date('1:50PM','hh:miPM'),to_date('6:25PM','hh:miPM'),1670,140,1,'A330','Global','Europe','Europe');
insert into flight
values('GL'||gl_flight_sequence.nextval,'Memphis','Dallas',to_date('9:10AM','hh:miAM'),to_date('10:15AM','hh:miAM'),750,89,1,'737','Global','Americas','Americas');
insert into flight
values('GL'||gl_flight_sequence.nextval,'St. Louis','Chicago',to_date('10:25AM','hh:miAM'),to_date('11:25AM','hh:miAM'),750,55,5,'737','Global','Americas','Americas');
insert into flight
values('GL'||gl_flight_sequence.nextval,'Chicago','Los Angeles',to_date('1:05PM','hh:miPM'),to_date('3:30PM','hh:miPM'),1250,99,5,'A330','Global','Americas','Americas');
insert into flight
values('GL'||gl_flight_sequence.nextval,'Chicago','Las Vegas',to_date('2:25PM','hh:miPM'),to_date('4:05PM','hh:miPM'),1050,49,6,'767','Global','Americas','Americas');
insert into flight
values('GL'||gl_flight_sequence.nextval,'Dallas','New Orleans',to_date('1:40PM','hh:miPM'),to_date('2:55PM','hh:miPM'),750,55,5,'737','Global','Americas','Americas');
insert into flight
values('GL'||gl_flight_sequence.nextval,'St. Louis','Dallas',to_date('9:30AM','hh:miAM'),to_date('10:55AM','hh:miAM'),750,45,12,'737','Global','Americas','Americas');
insert into flight
values('GL'||gl_flight_sequence.nextval,'Dallas','Orlando',to_date('12:35PM','hh:miPM'),to_date('3:35PM','hh:miPM'),1050,89,5,'737','Global','Americas','Americas');

create sequence travel_cust_sequence
start with 101;

insert into travel_customer
values(travel_cust_sequence.nextval,'Jack','Russell','25 North Madison Ave.','Springfield','MO',65807,'4178823434',35,'R',null);
insert into travel_customer
values(travel_cust_sequence.nextval,'Betty','Trumbell','550 South Court Dr.','St. Louis','MO',63140,'3125556670',62,'V','Y');
insert into travel_customer
values(travel_cust_sequence.nextval,'Tracy','Bussell','125 North Madison Ave.','St. Louis','MO',63140,'3128823434',28,'R',null);
insert into travel_customer
values(travel_cust_sequence.nextval,'Lacy','George','550 South Court Dr.','Springfield','MO',65810,'4175556670',44,'R',null);
insert into travel_customer
values(travel_cust_sequence.nextval,'Sania','Raina','400 South Circle St.','Kansas City','MO',64530,'4316667171',31,'V',null);
insert into travel_customer
values(travel_cust_sequence.nextval,'Tom','Peters','2500 S. Grand St.','Springfield','MO',65810,'4178625577',28,'R',null);
insert into travel_customer
values(travel_cust_sequence.nextval,'Sharon','Key','1200 West Wagner St.','Springfield','MO',65807,'4176648450',66,'S','Y');

create sequence ticket_sequence
start with 100501;

insert into ticket
values(ticket_sequence.nextval,to_date('10/28/04','mm/dd/yy'),to_date('12/12/04','mm/dd/yy'),'St. Louis','Amsterdam',968.00,101);
insert into ticket
values(ticket_sequence.nextval,to_date('10/30/04','mm/dd/yy'),to_date('12/14/04','mm/dd/yy'),'Memphis','Tokyo',937.20,102);
insert into ticket
values(ticket_sequence.nextval,to_date('11/2/04','mm/dd/yy'),to_date('11/22/04','mm/dd/yy'),'Chicago','Frankfurt',447.70,103);
insert into ticket
values(ticket_sequence.nextval,to_date('11/2/04','mm/dd/yy'),to_date('11/28/04','mm/dd/yy'),'Chicago','New York',82.50,101);
insert into ticket
values(ticket_sequence.nextval,to_date('11/3/04','mm/dd/yy'),to_date('12/10/04','mm/dd/yy'),'Memphis','Las Vegas',271.70,104);
insert into ticket
values(ticket_sequence.nextval,to_date('11/5/04','mm/dd/yy'),to_date('12/15/04','mm/dd/yy'),'St. Louis','New Orleans',110.00,105);
insert into ticket
values(ticket_sequence.nextval,to_date('11/5/04','mm/dd/yy'),to_date('12/22/04','mm/dd/yy'),'Memphis','Dallas',97.90,106);
insert into ticket
values(ticket_sequence.nextval,to_date('11/8/04','mm/dd/yy'),to_date('12/8/04','mm/dd/yy'),'St. Louis','Los Angeles',169.40,107);
insert into ticket
values(ticket_sequence.nextval,to_date('11/8/04','mm/dd/yy'),to_date('12/10/04','mm/dd/yy'),'St. Louis','Chicago',60.50,101);


insert into flight_ticket
values('TW222',100501);
insert into flight_ticket
values('TW142',100501);
insert into flight_ticket
values('TW242',100502);
insert into flight_ticket
values('TW122',100502);
insert into flight_ticket
values('TW262',100502);
insert into flight_ticket
values('GL155',100503);
insert into flight_ticket
values('GL275',100503);
insert into flight_ticket
values('GL155',100504);
insert into flight_ticket
values('TW242',100505);
insert into flight_ticket
values('TW122',100505);
insert into flight_ticket
values('TW342',100505);
insert into flight_ticket
values('GL435',100506);
insert into flight_ticket
values('GL415',100506);
insert into flight_ticket
values('GL335',100507);
insert into flight_ticket
values('GL355',100508);
insert into flight_ticket
values('GL375',100508);
insert into flight_ticket
values('GL355',100509);

create sequence hotel_id_sequence
start with 10
increment by 1;

insert into hotel
values(hotel_id_sequence.nextval,'Iberville Suites','123 Baronne St.','New Orleans','LA',70115,'5042237642',125,12,'DT');
insert into hotel
values(hotel_id_sequence.nextval,'Iberville Suites','20 Gold Street','New York','NY',10038,'2128879056',150,5,'DT');
insert into hotel
values(hotel_id_sequence.nextval,'Imperial Palace','5200 Paradise Road','Las Vegas','NV',89119,'7024823156',68,5,'DQ');
insert into hotel
values(hotel_id_sequence.nextval,'Imperial Palace','350 South Orange Ave.','Orlando','FL',32801,'3216677878',144,10,'DQ');
insert into hotel
values(hotel_id_sequence.nextval,'La Quinta','1605 Sand Lake Road','Orlando','FL',32809,'3218776432',135,15,'DT');
insert into hotel
values(hotel_id_sequence.nextval,'La Quinta','175 St. Charles Ave.','New Orleans','LA',70130,'5047789090',100,4,'DQ');
insert into hotel
values(hotel_id_sequence.nextval,'La Quinta','4500 Paradise Road','Las Vegas','NV',89119,'7025528856',45,3,'DT');
insert into hotel
values(hotel_id_sequence.nextval,'Iberville Suites','900 Canal Street','New Orleans','LA',70112,'5042228989',115,2,'DT');
insert into hotel
values(hotel_id_sequence.nextval,'Iberville Suites','140 St. Charles Ave.','New Orleans','LA',70130,'5041123030',120,8,'DQ');
insert into hotel
values(hotel_id_sequence.nextval,'Iberville Suites','135 Lafayette Street','New York','NY',10013,'2125550770',167,12,'DQ');
insert into hotel
values(hotel_id_sequence.nextval,'Imperial Palace','4940 North Rancho','Las Vegas','NV',89130,'7021223058',60,3,'DQ');
insert into hotel
values(hotel_id_sequence.nextval,'La Quinta','300 E. Flamingo Road','Las Vegas','NV',89109,'7028884155',48,6,'DT');

create sequence hotel_reserve_sequence
start with 100601;

insert into hotel_reservation
values(hotel_reserve_sequence.nextval,to_date('11/2/04','mm/dd/yy'),to_date('11/28/04','mm/dd/yy'),to_date('11/30/04','mm/dd/yy'),'N',1,0,101,19);
insert into hotel_reservation
values(hotel_reserve_sequence.nextval,to_date('11/3/04','mm/dd/yy'),to_date('12/10/04','mm/dd/yy'),to_date('12/16/04','mm/dd/yy'),'N',2,1,104,12);
insert into hotel_reservation
values(hotel_reserve_sequence.nextval,to_date('11/5/04','mm/dd/yy'),to_date('12/15/04','mm/dd/yy'),to_date('12/22/04','mm/dd/yy'),'N',2,0,105,17);
insert into hotel_reservation
values(hotel_reserve_sequence.nextval,to_date('12/12/04','mm/dd/yy'),to_date('12/22/04','mm/dd/yy'),to_date('12/28/04','mm/dd/yy'),'N',1,0,107,14);
insert into hotel_reservation
values(hotel_reserve_sequence.nextval,to_date('12/2/04','mm/dd/yy'),to_date('12/23/04','mm/dd/yy'),to_date('12/30/04','mm/dd/yy'),'N',2,1,104,14);

commit;

