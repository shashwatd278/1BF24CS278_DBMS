create database Employee;
use Employee;

create table DEPT (Dept_no int primary key, Dname varchar(50), Dlocation varchar(50));
insert into dept (Dept_no, Dname, Dlocation) values
(10,"Accounting","Mumbai"),
(20,"Research","Bengaluru"),
(30,"Sales","Delhi"),
(40,"Operations","Chennai");
select * from dept;

create table EMP (empno int primary key, ename varchar(30), mgr_no int, hiredate date, salary decimal(7,2), Dept_no int, foreign key(Dept_no) references DEPT(Dept_no) on delete cascade on update cascade);
insert into EMP(empno, ename, mgr_no, hiredate, salary, Dept_no) values
(7369,"Adarsh",7902,"2012-12-17",80000.00,20),
(7499,"Shruthi",7968,"2013-02-20",16000.00,30),
(7521,"Anvita",7698,"2015-02-22",12500.00,30),
(7566,"Tanvir",7839,"2008-04-02",29750.00,20),
(7654,"Ramesh",7698,"2014-09-28",12500.00,30),
(7698,"Kumar",7839,"2015-05-01",28500.00,30),
(7782,"Clark",7839,"2017-06-09",24500.00,10),
(7788,"Scott",7566,"2010-12-09",30000.00,20),
(7839,"King",null,"2009-11-17",50000.00,10),
(7844,"Turner",7698,"2010-09-08",15000.00,30),
(7876,"Adams",7788,"2013-01-12",11000.00,20),
(7900,"James",7698,"2017-12-03",9500.00,30),
(7902,"Ford",7566,"2010-12-03",30000.00,20);
select * from emp;

create table incentives (empno int, incentive_date date, incentive_amt decimal(10,2),primary key(empno,incentive_date), foreign key(empno) references emp(empno) on delete cascade on update cascade);
insert into incentives (empno, incentive_date, incentive_amt) values
(7499,"2019-02-01",5000.00),
(7521,"2019-03-01",2500.00),
(7566,"2022-02-01",5070.00),
(7654,"2020-02-01",2000.00),
(7654,"2022-04-01",879.00),
(7521,"2019-02-01",8000.00),
(7698,"2019-03-01",500.00),
(7698,"2020-03-01",9000.00),
(7698,"2022-04-01",4500.00);
select * from incentives;


create table project (pno int primary key, pname varchar(30), ploc varchar(30));
INSERT INTO project(pno, pname, ploc) VALUES
(101,"AI project","Bengaluru"),
(102,"IOT","Hyderabad"),
(103,"Block Chain","Bengaluru"),
(104,"Data science","Mysuru"),
(105,"Autonomus Systems","Pune");
select * from project;

Create table assigned_to (empno int, pno int, job_role varchar(30), primary key(empno,pno),foreign key(empno) references emp(empno) on delete cascade on update cascade, foreign key(pno) references project(pno) on delete cascade on update cascade);
insert into assigned_to (empno,pno,job_role) values
(7499,101,"Software Engineer"),
(7521,101,"Software Architect"),
(7566,101,"Project Manager"),
(7654,102,"Sales"),
(7521,102,"Software Engineer"),
(7499,102,"Software Engineer"),
(7654,103,"Cyber Security"),
(7698,104,"Software Engineer"),
(7900,105,"Software Engineer"),
(7839,104,"General Manager");
select * from assigned_to;

SELECT * FROM emp WHERE emp.empno IN (SELECT mgr_no FROM emp) AND emp.sal > (SELECT avg(e.sal) FROM emp e WHERE e.mgr_no = emp.empno );
select e.empno from emp e, assigned_to a, project p where e.empno=a.empno and a.pno=p.pno and p.ploc in ("Bengaluru","Hyderabad","Mysuru");
select m.ename, count(*) from emp e,emp m where e.mgr_no = m.empno group by m.ename having count(*) =(select max(mycount) from (select COUNT(*) mycount from emp group by mgr_no) a);
select distinct e.ename from emp e,incentives i where (select max(salary+incentive_amt) from emp,incentives) >= ANY (select salary from emp e1 where e.deptno=e1.deptno);
select * from emp e where e.Dept_no = (select e1.Dept_no from emp e1 where e1.empno=e.mgr_no);
