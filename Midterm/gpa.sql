create table student(
	s_id number,
	c_id number,
	grade number,
	Constraint STU_PK primary_key(s_id);
);

insert into student values(1234, 5678, 5);
insert into student values(1234, 5674, 2);
insert into student values(1234, 5578, 1);
insert into student values(1234, 5678, 4);

create or replace function change_student_grade(stu_in in number, cour_in in number, grade_in in number)
  return number is
  gpa number;
  total_classes number;
  No_Such_Student exception;
begin
  
  update student
  set grade = grade_in
  where s_id = stu_in and c_id = cour_in;
  
  select avg(grade) into gpa from student where s_id = stu_in;
  return gpa;
  
  Exception
    when no_data_found then
      raise No_Such_Student;
    when No_Such_Student then
      dbms_output.put_line('Student not found');
end;

set serveroutput on;
declare
gpa number;
begin
gpa := CHANGE_STUDENT_GRADE(1234, 5578, 3);
dbms_output.put_line('Student GPA: ' ||gpa);
end;
-- expected output is 3.5