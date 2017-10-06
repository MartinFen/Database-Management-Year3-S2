/*https://dev.mysql.com/doc/refman/5.7/en/partitioning-overview.html
*/
Drop database if exists Partitions;
Show databases;
create database Partitions CHARACTER SET utf8 COLLATE utf8_unicode_ci;
Use Partitions;
Show tables;
drop table if exists employees ;
CREATE TABLE employees (
    id INT NOT NULL ,
    fname VARCHAR(30),
    lname VARCHAR(30),
    hired DATE NOT NULL DEFAULT '2017-01-01',
    resignation DATE DEFAULT '2016-12-31',
    job_code INT,
    store_id varchar(3),
	primary key (id,hired)
)
PARTITION BY RANGE ( YEAR(hired) ) (
    PARTITION p0 VALUES LESS THAN (2012) DATA DIRECTORY='c:/wamp/p0',
    PARTITION p1 VALUES LESS THAN (2014) DATA DIRECTORY='c:/wamp/p1',
    PARTITION p2 VALUES LESS THAN (2016) DATA DIRECTORY='c:/wamp/p2',
    PARTITION p3 VALUES LESS THAN MAXVALUE DATA DIRECTORY='c:/wamp/p3'
);

-- data files created in C:/wamp/
insert into employees  (id,fname,lname,hired,resignation,job_code,store_id) values(1,'Sarah','O''Donoghue','2014-02-01',null,222,'GAO');
insert into employees  (id,fname,lname,hired,resignation,job_code,store_id) values(2,'Mary','O''Byrne','2012-02-14',null,222,'GAO');
insert into employees  (id,fname,lname,hired,resignation,job_code,store_id) values(3,'John','Kelly','2016-02-01','2014-12-01',222,'GAO');
insert into employees  (id,fname,lname,hired,resignation,job_code,store_id) values(4,'Thomas','Smyth','2015-03-17','2015-04-24',222,'GAO');
insert into employees  (id,fname,lname,hired,resignation,job_code,store_id) values(5,'Sarah','O''Donoghue','2014-02-01',null,222,'GAO');
insert into employees  (id,fname,lname,hired,resignation,job_code,store_id) values(6,'Mary','O''Byrne','2012-02-14',null,222,'GAO');
insert into employees  (id,fname,lname,hired,resignation,job_code,store_id) values(7,'John','Kelly','2016-02-01','2014-12-01',222,'GAO');
insert into employees  (id,fname,lname,hired,resignation,job_code,store_id) values(8,'Thomas','Smyth','2015-03-17','2015-04-24',222,'GAO');


select * from employees;

select * from employees PARTITION (p2);

-- Partitions allows performance improvements when e.g.:

-- Dropping old data by simply:

ALTER TABLE employees DROP PARTITION p0;

-- Database can speed up a query like this:

SELECT COUNT(*) FROM employees WHERE hired BETWEEN '2014-01-01' AND '2015-12-31' GROUP BY job_code;

-- Knowing that all data is stored only on the p2 partition. */

