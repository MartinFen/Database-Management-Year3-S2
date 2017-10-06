-- INT(M),  M indicates the maximum display width but is only applicable when using zerofill for the cli
-- CLI only uses display width when the field is full of zeroes, but other client applications can use the 
-- display width to pad (with spaces, dashes, or whatever you like) the values.

Drop database if exists Numbers;
Show databases;
create database Numbers;
Use Numbers;
Show tables;
  
use Numbers;
		
drop table if exists numbers;

create table numbers ( 
columnname Int(6) unsigned zerofill not null auto_increment ,
primary key (columnname)	
);

insert into numbers (columnname) values (1),(12),(123),(1234),(12345),(123456),(1234567),(12345678);

select * from numbers;

		
INSERT INTO emp (empno, title, ename, degree, job, mgr, hiredate, currency_symbol,salary, comm, deptno,picture,picture_path) VALUES
(73699, 'Mr.','SMITH', ('B Sc,M Sc,Phd'),'CLERK', 7566, '2010-12-17', '€',999999.23, NULL, 20,load_file('c:/kittens/cat1.jpg'),'/cat1.jpg');