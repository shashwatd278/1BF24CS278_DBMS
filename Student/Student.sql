create database students;
use students;

create table student_info ( sid int, Sname varchar(50), DOB date, DOJ date, Fee int, gender char(1));

insert into student_info (sid, Sname, DOB, DOJ, Fee, gender) values
(1,"Shas","2006-10-05","2010-10-06",10000,"M"),
(2,"Amar","2006-11-09","2010-12-06",11000,"M");

alter table student_info add phone_no int;
alter table student_info rename column phone_no to student_no;

delete from student_info where sid=2;

select* from student_info;