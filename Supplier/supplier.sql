create database supplier;
use supplier;

create table suppliers (sid int primary key, sname varchar(30), city varchar(30));
insert into suppliers (sid, sname, city) values
(10001,"Acme Widget","Bengaluru"),
(10002,"Johns","Kolkata"),
(10003,"Vimal","Mumbai"),
(10004,"Reliance","Delhi");
select * from suppliers;


create table parts (pid int primary key, pname varchar(30), color varchar(30));
insert into parts (pid, pname, color) values
(20001,"Book","Red"),
(20002,"Pen","Red"),
(20003,"Pencil","Green"),
(20004,"Mobile","Green"),
(20005,"Charger","Black"); 
select * from parts;

create table catalog (sid int, pid int, cost float(6), foreign key(sid) references suppliers(sid), foreign key(pid) references parts(pid), primary key(sid,pid));
insert into catalog(sid,pid,cost) values
(10001,20001,10),
(10001,20002,10),
(10001,20003,30),
(10001,20004,10),
(10001,20005,10),
(10002,20001,10),
(10002,20002,20),
(10003,20003,30),
(10004,20003,40);
select * from catalog;

select distinct(p.pname) from parts p, catalog c where p.pid=c.pid;

select s.sname from suppliers s where((select count(p.pid) from parts p)=(select count(c.pid) from catalog c where c.sid=s.sid));

select s.sname from suppliers s where ((select count(p.pid) from parts p where color='Red')=(select count(c.pid) from catalog c, parts p where c.sid=s.sid and c.pid=p.pid and p.color='Red'));

select p.pname from parts p, catalog c, suppliers s where s.sid=c.sid and p.pid=c.pid and s.sname="Acme Widget" and not exists (select * from catalog a, suppliers b where a.sid=b.sid and p.pid=a.pid and b.sname<>'Acme Widget');

select distinct(c.sid) from catalog c where c.cost> (select avg(a.cost) from catalog a where a.pid=c.pid);