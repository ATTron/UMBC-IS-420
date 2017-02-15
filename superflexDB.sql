drop table complaints;
drop table rental_invoice;
drop table tenant_family;
drop table tenant_auto;
drop table tenant;
drop table rental;
drop table apartment;
drop table staff;

drop sequence apartment_sequence1;
drop sequence apartment_sequence2;
drop sequence rental_sequence;
drop sequence rental_invoice_sequence;
drop sequence staff_sequence;
drop sequence complaints_sequence;

create table apartment
(apt_no number(3) constraint apartment_pk primary key,
apt_type number(1) constraint apartment_type_ck check ((apt_type = 0) or (apt_type = 1) or (apt_type = 2) or (apt_type = 3)),
apt_status char(1) constraint apartment_status_ck check ((apt_status = 'R') or (apt_status = 'V')),
apt_utility char(1) constraint apartment_utility_ck check ((apt_utility = 'Y') or (apt_utility = 'N')),
flooring varchar2(10),
balcony char(1),
apt_deposit_amt number(3),
apt_rent_amt number(3));

create table staff
(staff_no varchar2(5) constraint staff_pk primary key,
first_name varchar2(15),
last_name varchar2(15),
position varchar2(12),
status char(1) constraint staff_status_ck check ((status='T') or (status='P')),
gender char(1),
dob date,
salary number(5));

create table rental
(rental_no number(6) constraint rental_pk primary key,
rental_date date constraint rental_date_nn NOT NULL,
rental_status char(1)constraint rental_status_ck check ((rental_status = 'S') or (rental_status = 'O')),
lease_type varchar2(3) default 'One' constraint lease_type_ck check ((lease_type = 'One') or (lease_type = 'Six')),
lease_start date,
lease_end date,
staff_no varchar2(5) constraint rental_apt_fk1 references staff,
apt_no number(3) constraint rental_apt_fk2 references apartment);

create table tenant
(tenant_ss number(9) constraint tenant_pk primary key,
tenant_name varchar2(25),
tenant_dob date,
marital char(1)constraint tenant_marital_ck check ((marital = 'M') or (marital = 'S')),
work_phone varchar2(10),
home_phone varchar2(10),
employer_name varchar2(25),
gender char(1) constraint tenant_gender_ck check ((gender = 'M') or (gender = 'F')),
rental_no number(6) constraint tenant_rental_fk references rental);

create table tenant_auto
(tenant_ss number(9) constraint tenant_auto_fk references tenant,
license_no varchar2(6),
auto_make varchar2(15),
auto_model varchar2(15),
auto_year number(4),
auto_color varchar2(10),
constraint tenant_auto_pk primary key (tenant_ss,license_no));

create table tenant_family
(tenant_ss number(9) constraint tenant_family_fk references tenant,
family_ss number(9),
name varchar2(25),
spouse char(1) constraint family_spouse_ck check ((spouse = 'Y') or (spouse = 'N')),
child char(1) constraint family_child_ck check ((child = 'Y') or (child = 'N')),
gender char(1) constraint family_gender_ck check ((gender = 'M') or (gender = 'F')),
dob date,
constraint tenant_family_pk primary key(tenant_ss,family_ss));

create table rental_invoice
(invoice_no number(6) constraint rental_invoice_pk primary key,
invoice_date date,
invoice_due number(4),
cc_no number(16),
cc_type varchar2(10),
cc_exp_date date,
rental_no number(6) constraint rental_invoice_fk references rental);

create table complaints
(complaint_no number(6) constraint complaints_pk primary key,
complaint_date date,
rental_complaint varchar2(100),
apt_complaint varchar2(100),
rental_no number(6) constraint complaints_fk1 references rental,
apt_no number(3) constraint complaints_fk2 references apartment,
status char(1) constraint complaint_status_ck check ((status = 'F') or (status = 'P') or (status = NULL)));

create sequence apartment_sequence1
start with 100
nocache;

create sequence apartment_sequence2
start with 200
nocache;

create sequence staff_sequence
start with 200
increment by 10
nocache;

create sequence rental_sequence
start with 100101
nocache;

create sequence rental_invoice_sequence 
start with 1000
nocache;

create sequence complaintS_sequence
start with 10010
nocache;

insert into apartment
values (apartment_sequence1.nextval,0,'R','Y','Carpet','N',200,300);
insert into apartment
values (apartment_sequence1.nextval,0,'R','N','Carpet','N',200,300);
insert into apartment
values (apartment_sequence1.nextval,0,'R','Y','Carpet','N',200,300);
insert into apartment
values (apartment_sequence1.nextval,1,'V','N','Carpet','N',300,400);
insert into apartment
values (apartment_sequence1.nextval,1,'R','Y','Carpet','N',300,400);

insert into apartment
values (apartment_sequence2.nextval,2,'V','Y','Hardwood','Y',400,500);
insert into apartment
values (apartment_sequence2.nextval,2,'R','Y','Carpet','N',400,500);
insert into apartment
values (apartment_sequence2.nextval,3,'V','Y','Hardwood','Y',500,700);
insert into apartment
values (apartment_sequence2.nextval,3,'R','Y','Hardwood','Y',500,700);

insert into staff
values('SA'||staff_sequence.nextval,'Joe','White','Assistant','T','M',to_date('7/8/82','mm/dd/yy'),24000);
insert into staff
values('SA'||staff_sequence.nextval,'Ann','Tremble','Assistant','T','F',to_date('6/12/81','mm/dd/yy'),26000);
insert into staff
values('SA'||staff_sequence.nextval,'Terry','Ford','Manager','P','M',to_date('10/20/67','mm/dd/yy'),53000);
insert into staff
values('SA'||staff_sequence.nextval,'Susan','Brandon','Supervisor','P','F',to_date('3/10/77','mm/dd/yy'),46000);
insert into staff
values('SA'||staff_sequence.nextval,'Julia','Roberts','Assistant','T','F',to_date('9/12/82','mm/dd/yy'),28000);



insert into rental values
(rental_sequence.nextval,to_date('05/12/2007','mm/dd/yyyy'),'O','One',to_date('6/1/2007','mm/dd/yyyy'),to_date('5/31/2008','mm/dd/yyyy'),'SA200',201);
insert into rental values
(rental_sequence.nextval,to_date('05/21/2007','mm/dd/yyyy'),'O','Six',to_date('6/1/2007','mm/dd/yyyy'),to_date('11/30/2007','mm/dd/yyyy'),'SA220',102);
insert into rental values
(rental_sequence.nextval,to_date('10/12/2007','mm/dd/yyyy'),'O','Six',to_date('11/1/2007','mm/dd/yyyy'),to_date('4/30/2008','mm/dd/yyyy'),'SA240',203);
insert into rental values
(rental_sequence.nextval,to_date('03/6/2008','mm/dd/yyyy'),'O','One',to_date('4/1/2008','mm/dd/yyyy'),to_date('3/31/2009','mm/dd/yyyy'),'SA210',101);
insert into rental values
(rental_sequence.nextval,to_date('4/15/2008','mm/dd/yyyy'),'O','One',to_date('5/1/2008','mm/dd/yyyy'),to_date('4/30/2009','mm/dd/yyyy'),'SA220',104);
insert into rental values
(rental_sequence.nextval,to_date('7/15/2008','mm/dd/yyyy'),'S','One',to_date('8/1/2008','mm/dd/yyyy'),to_date('7/31/2009','mm/dd/yyyy'),'SA200',100);

insert into tenant values
(123456789,'Jack Robin',to_date('6/21/1960','mm/dd/yyyy'),'M','4173452323','4175556565','Kraft Inc.','M',100101);
insert into tenant values
(723556089,'Mary Stackles',to_date('8/2/1980','mm/dd/yyyy'),'S','4175453320','4176667565','Kraft Inc.','F',100102);
insert into tenant values
(450452267,'Ramu Reddy',to_date('4/11/1962','mm/dd/yyyy'),'M','4178362323','4172220565','MSU','M',100103);
insert into tenant values
(223056180,'Marion Black',to_date('5/25/1981','mm/dd/yyyy'),'S','4174257766', '4176772364', 'MSU','M',100104);
insert into tenant values
(173662690,'Venessa Williams',to_date('3/12/1970','mm/dd/yyyy'),'M','4175557878', '4173362565','Kraft Inc.','F',100105);

insert into tenant_auto values
(123456789,'SYK332','Ford','Taurus',1999,'Red');
insert into tenant_auto values
(123456789,'TTS430','Volvo','GL 740',1990,'Green');
insert into tenant_auto values
(723556089,'ABC260','Toyota','Lexus',2000,'Maroon');
insert into tenant_auto values
(450452267,'LLT322','Honda','Accord',2001,'Blue');
insert into tenant_auto values
(450452267,'KYK100','Toyota','Camry',1999,'Black');
insert into tenant_auto values
(223056180,'FLT232','Honda','Civic',1999,'Red');
insert into tenant_auto values
(173662690,'LLT668','Volvo','GL 980',2000,'Velvet');

insert into tenant_family values
(123456789,444663434,'Kay Robin','Y','N','F',to_date('6/21/1965','mm/dd/yyyy'));
insert into tenant_family values
(450452267,222664343,'Sarla Reddy','Y','N','F',to_date('6/11/1965','mm/dd/yyyy'));
insert into tenant_family values
(450452267,222663434,'Anjali Reddy','N','Y','F',to_date('8/10/1990','mm/dd/yyyy'));
insert into tenant_family values
(173662690,111444663,'Terry Williams','Y','N','F',to_date('3/21/1968','mm/dd/yyyy'));
insert into tenant_family values
(173662690,242446634,'Tom Williams','N','Y','M',to_date('5/20/1991','mm/dd/yyyy'));


insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('5/12/2007','mm/dd/yyyy'),500,1234567890123456,'visa',to_date('12/10','mm/yy'),100101);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('6/30/2007','mm/dd/yyyy'),500,1234567890123456,'visa',to_date('12/10','mm/yy'),100101);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('7/30/2007','mm/dd/yyyy'),500,1234567890123456,'visa',to_date('12/10','mm/yy'),100101);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('8/30/2007','mm/dd/yyyy'),500,1234567890123456,'visa',to_date('12/10','mm/yy'),100101);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('9/30/2007','mm/dd/yyyy'),500,1234567890123456,'mastercard',to_date('12/10','mm/yy'),100101);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('10/30/2007','mm/dd/yyyy'),500,1234567890123456,'mastercard',to_date('12/10','mm/yy'),100101);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('11/30/2007','mm/dd/yyyy'),500,1234567890123456,'visa',to_date('12/10','mm/yy'),100101);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('12/30/2007','mm/dd/yyyy'),500,1234567890123456,'visa',to_date('12/10','mm/yy'),100101);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('1/30/2008','mm/dd/yyyy'),500,1234567890123456,'visa',to_date('12/10','mm/yy'),100101);

insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('5/21/2007','mm/dd/yyyy'),300,3343567890123456,'mastercard',to_date('10/11','mm/yy'),100102);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('6/30/2007','mm/dd/yyyy'),300,3343567890123456,'mastercard',to_date('10/11','mm/yy'),100102);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('7/30/2007','mm/dd/yyyy'),300,3343567890123456,'mastercard',to_date('10/11','mm/yy'),100102);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('8/30/2007','mm/dd/yyyy'),300,3343567890123456,'mastercard',to_date('10/11','mm/yy'),100102);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('9/30/2007','mm/dd/yyyy'),300,3343567890123456,'mastercard',to_date('10/11','mm/yy'),100102);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('10/30/2007','mm/dd/yyyy'),300,3343567890123456,'mastercard',to_date('10/11','mm/yy'),100102);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('11/30/2007','mm/dd/yyyy'),300,3343567890123456,'mastercard',to_date('10/11','mm/yy'),100102);

insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('10/12/2007','mm/dd/yyyy'),700,8654567890123296,'discover',to_date('11/11','mm/yy'),100103);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('11/30/2007','mm/dd/yyyy'),700,8654567890123296,'discover',to_date('11/11','mm/yy'),100103);

insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('3/6/2008','mm/dd/yyyy'),500,7766567890123203,'visa',to_date('09/10','mm/yy'),100104);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('4/30/2008','mm/dd/yyyy'),300,7766567890123203,'visa',to_date('09/10','mm/yy'),100104);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('5/30/2008','mm/dd/yyyy'),300,7766567890123203,'visa',to_date('09/10','mm/yy'),100104);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('6/30/2008','mm/dd/yyyy'),300,7766567890123203,'visa',to_date('09/10','mm/yy'),100104);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('7/30/2008','mm/dd/yyyy'),300,7766567890123203,'visa',to_date('09/10','mm/yy'),100104);

insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('4/15/2008','mm/dd/yyyy'),700,6599567890126211,'visa',to_date('12/12','mm/yy'),100105);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('5/30/2008','mm/dd/yyyy'),400,6599567890126211,'visa',to_date('12/12','mm/yy'),100105);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('6/30/2008','mm/dd/yyyy'),400,6599567890126211,'discover',to_date('12/11','mm/yy'),100105);
insert into rental_invoice values
(rental_invoice_sequence.nextval,to_date('7/30/2008','mm/dd/yyyy'),400,6599567890126211,'discover',to_date('12/11','mm/yy'),100105);



insert into complaints values
(complaints_sequence.nextval,to_date('12/12/2007','mm/dd/yyyy'),'kitchen sink clogged',null,100103,203,'F');
insert into complaints values
(complaints_sequence.nextval,to_date('8/17/2008','mm/dd/yyyy'),'water heater not working',null,100105,104,'F');
insert into complaints values
(complaints_sequence.nextval,to_date('9/17/2008','mm/dd/yyyy'),'room heater problem',null,100105,104,NULL);
insert into complaints values
(complaints_sequence.nextval,to_date('9/17/2008','mm/dd/yyyy'),null,'air conditioning not working',null,103,NULL);
insert into complaints values
(complaints_sequence.nextval,to_date('10/20/2008','mm/dd/yyyy'),'car parking not proper',null,100103,null,NULL);
insert into complaints values
(complaints_sequence.nextval,to_date('11/8/2008','mm/dd/yyyy'),'delay in payment',null,100104,null,'F');
insert into complaints values
(complaints_sequence.nextval,to_date('11/16/2008','mm/dd/yyyy'),null,'utility not working',null,202,NULL);

commit;


