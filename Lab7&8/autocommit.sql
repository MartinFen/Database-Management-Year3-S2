drop database if exists concurrency ;
create database concurrency;
use concurrency;

create table t (field1 integer primary key) engine = innodb;
-- Innodb engine supports atomic STATEMENTS & TRANSACTIONS

show variables like 'autocommit'; --because this is on it writes to disk so rollback isnt going to work
--set autocommit=off;

insert into t values (1),(2),(3);
--  three rows are now stored in the table. We can of course attempt to roll back to undo these changes
select * from t;

rollback;

select * from t;
-- rows were automatically committed after the insert statement was executed: that is the meaning of autocommit. 

--Show global variables like '%tx%';

insert into t values (4),(5),(1);
-- statements execute atomically in Innodb, ALL or NOTHING

select * from t;

###############################################################################################################################

drop database if exists concurrency ;
create database concurrency;
use concurrency;

create table t (field1 integer primary key) engine = myisam;
-- MyISAM engine does not support atomic execution of statements & transactions
insert into t values (1),(2),(3);
--  three rows stored in  table. We can of course attempt to roll back to undo these changes
select * from t;

rollback;

select * from t;
-- rows were automatically committed right after the insert statement was executed: that is the meaning of autocommit. 

insert into t values (4),(5),(1);
-- statement was not executed atomically, part of the insert executed!!!

select * from t;