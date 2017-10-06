/*
-- Use test;
-- Use mysql;
-- Use information_schema;
-- source f:/createempdepttable.sql;
-- Notice the forward slash  / in above statement
*/
-- section 13.1.28. MySQL Documentation DROP TABLE Syntax
Drop database if exists db3;
Show databases;
create database db3 CHARACTER SET utf8 COLLATE UTF8_GENERAL_CI ;
Use db3;
Show tables;
Drop table if exists dept;

-- Section 13.1.14. MySQL Documentation CREATE TABLE Syntax
-- The main 5 constraints are NOT NULL,PRIMARY KEY,FOREIGN KEY,UNIQUE KEY and CHECK 
-- Section  11.4.4 ENUM DATATYPES
create table dept (
  deptno tinyint unsigned NOT NULL auto_increment ,  
  dname varchar(45) NOT NULL, -- maximum column length is 45 characters
  location ENUM ('New York','Chicago','Boston','Dallas') Not Null,  -- default value is first element in list
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (deptno)
  ) DATA DIRECTORY='c:/wamp';

-- SELECT  @@innodb_file_per_table;
-- show variables like 'innodb_file_per_table';

/* CHAR is a fixed length, and VARCHAR is variable length field.
CHAR always takes the same amount of space, 
storage requirements for  VARCHAR varies depending on the specific string stored.
*/

show tables;
select * from dept;
-- section 13.2.5. MySQL Documentation INSERT Syntax
Insert into dept values (10, 'Accounting', 'New York', CURRENT_TIMESTAMP), (20, 'Research', 'Dallas',CURRENT_TIMESTAMP),(30, 'Sales', 'Chicago',CURRENT_TIMESTAMP),(40, 'Operations', 'Boston',CURRENT_TIMESTAMP);
-- Inserting data into SOME (not all) columns of the table, just specify column name 
-- Note default columns will also get populated 
Insert into dept (deptno,dname) values (50,'Human Resources'); /* If an ENUM column is declared NOT NULL, its default value is the first element of the list of permitted

Insert into dept (deptno,dname,location) values (60,'IT','Dublin'); #MySQL actually truncates the illegal value to  ' ' (an empty string). */

Delete from dept where deptno = 60;


Drop table if exists emp;

Show databases;
Use db3;
-- section 13.1.14. MySQL Documentation CREATE TABLE Syntax
-- section 13.1.7.2 MySQL Documentation FOREIGN KEYS Syntax
create table emp (
  empno Int(6) unsigned zerofill auto_increment, -- see Numbers.sql 
  title ENUM ('Mr.', 'Mrs.', 'Miss.', 'Ms.','Dr.','Fr.'), --  constraint on values entered into the column, default value is first element in list, if wrong data entered MySQL truncates the illegal value to  ' ' (an empty string).
  ename varchar(45) not null default 'Smith',
  degree SET ('B Sc','B Eng','B Comm','M Sc','Phd') not null ,
  job ENUM ('CLERK','SALESMAN','MANAGER','ANALYST','PRESIDENT'),
  mgr smallint unsigned,
  hiredate date not null,
  currency_symbol varchar(10),
  salary DECIMAL(6,2) unsigned,# M is the total number of digits and D is the number of digits after the decimal point, max value is 9999.99
  comm DECIMAL(6,2) unsigned, # Section 12.19.2 max value is 9999.99
  deptno TINYINT unsigned not null default 20,
  last_update  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  picture LONGBLOB DEFAULT NULL,           # Picture in DATABASE as BLOB (up to 4.2GB)
  picture_path varchar(20) DEFAULT NULL,   # Path to where picture is stored in file system,
  primary key (empno),
  foreign key (deptno) references dept(deptno) ON DELETE CASCADE ON UPDATE CASCADE 
  -- if we delete the parent row, the child row AUTOMATICALLY gets deleted 
) DATA DIRECTORY='c:/wamp', Engine=InnoDB;

describe emp;

select * from emp;

-- Load data local infile "f:/emp.tsv" into table emp lines terminated by "\r\n"; 

INSERT INTO emp (empno, title, ename, degree, job, mgr, hiredate, currency_symbol,salary, comm, deptno,picture,picture_path) VALUES
(7369, 'Mr.','SMITH', ('B Sc,M Sc,Phd'),'CLERK', 7566, '2010-12-17', 0xE282AC,800.23, NULL, 20,load_file('c:/kittens/cat1.jpg'),'/cat1.jpg'),
(7499, 'Mr.','ALLEN', ('B Eng,Phd'),'SALESMAN', 7698, '2011-02-20',0xE282AC, 1600.56, 300.23, 30, load_file('c:/kittens/cat2.jpg'),'/cat2.jpg'),
(7521, 'Mr.','WARD', ('B Eng,B Comm'),'SALESMAN', 7566, '2011-02-22',0xE282AC, 1250, 500, 30,load_file('c:/kittens/cat3.jpg'),'/cat3.jpg'),
(7566, 'Mr.','JONES', ('B Sc,M Sc,Phd'),'MANAGER', 7839, '2011-04-02',0xE282AC, 2976, NULL, 20, load_file('c:/kittens/cat4.jpg'),'/cat4.jpg'),
(7654, 'Mr.','MARTIN', ('B Comm,Phd'),'SALESMAN', 7698, '2011-09-28',0xE282AC, 1250, 1400, 30,load_file('c:/kittens/cat5.jpg'),'/cat5.jpg'),
(7698, 'Mr.','BLAKE', ('B Sc,B Eng,B Comm,M Sc,Phd'),'MANAGER', 7839, '2011-01-05', 0xE282AC,2850, NULL, 30, load_file('c:/kittens/cat6.jpg'),'/cat6.jpg'),
(7782, 'Mr.','CLARK', ('B Comm,Phd'),'MANAGER', 7839, '2011-09-06',0xE282AC, 2450, NULL, 10, load_file('c:/kittens/cat7.jpg'),'/cat7.jpg'),
(7788, 'Mr.','SCOTT', ('B Comm,Phd'),'ANALYST', 7788, '2012-12-09',0xE282AC, 3000, NULL, 20, load_file('c:/kittens/cat8.jpg'),'/cat8.jpg'),
(7839, 'Miss.','KING',('B Comm'), 'PRESIDENT', NULL, '2011-11-17',0xE282AC, NULL, NULL, 10, load_file('c:/kittens/cat9.jpg'),'/cat9.jpg'),
(7844, 'Mr.','TURNER', ('B Comm,Phd'),'SALESMAN', 7698, '2011-09-08', 0xE282AC,1500, 0, 30, load_file('c:/kittens/cat10.jpg'),'/cat10.jpg'),
(7876, 'Mr.','ADAMS',('B SC,M Sc') ,'CLERK', 7788, '2013-12-01',0xE282AC, 1100, NULL, 20, load_file('c:/kittens/cat11.jpg'),'/cat11.jpg'),
(7900, 'Mr.','JAMES', ('B Comm,Phd'),'CLERK', 7698, '2011-12-03', 0xE282AC,950, NULL, 30, load_file('c:/kittens/cat12.jpg'),'/cat12.jpg'),
(7902, 'Mr.','FORD', ('B Comm,M Sc,Phd'),'ANALYST', 7902, '2011-12-01', 0xE282AC,3000, NULL, 20,load_file('c:/kittens/cat6.jpg'),'/cat6.jpg'),
(7934, 'Mr.','MILLER',('B SC,M Sc') ,'CLERK', 7782, '2012-06-23',0xE282AC, 1300, NULL, 10, load_file('c:/kittens/cat8.jpg'),'/cat8.jpg');


show warnings;

describe emp;
explain emp;


-- 13.7.5.23 SHOW INDEX Syntax
show index from emp;
show index from dept;
select user();
select current_user();
select database();
select version();
status;


