-- 5.1.5 Server System Variables
-- 13.7.5.40 SHOW VARIABLES Syntax

/* Session variables 
Scope of your session with the MySQL server, session starts with a connection to the server and ends when the connection is closed. Variables go out of scope once the connection is terminated.

Variables created during your connection cannot be referenced from other sessions.
SET SESSION max_connections = 300;
SET @max_connections = 300;
*/
/* Global variables

Global variables exist across connections.

SET GLOBAL max_connections = 300;
SET @@max_connections = 300;
*/


SHOW GLOBAL VARIABLES LIKE 'auto_increment_offset';
SHOW GLOBAL VARIABLES LIKE 'auto_increment_increment';

SHOW SESSION VARIABLES LIKE 'auto_increment_offset';
SHOW SESSION VARIABLES LIKE 'auto_increment_increment';
-- offset determines the starting point for the AUTO_INCREMENT column value
-- increment determines the step size for the AUTO_INCREMENT column value
Drop database if exists Numbers;
Create database Numbers;
Use Numbers;

Drop table if exists auto;

create table auto ( 
	id int(6) unsigned zerofill not null auto_increment ,
	columnname Integer(6) ,
	primary key (id)
);

insert into auto (columnname) values (1),(12),(123),(1234),(12345),(123456),(1234567),(12345678);
select * from auto;

show create table auto;

-- --------------------------------------------------------------------------------------------------


SET GLOBAL auto_increment_offset=1; # start value 
SET GLOBAL auto_increment_increment=1; # increment value
SHOW GLOBAL VARIABLES LIKE 'auto_inc%';	
-- Alternate

SET session auto_increment_offset=100; # start value 
SET session auto_increment_increment=1000; # increment value	
SHOW SESSION VARIABLES LIKE 'auto_inc%';	
-- If the global value of either variable is set, its effects persist until the global value is changed or overridden by setting the session value, or until mysqld is restarted.

SHOW VARIABLES LIKE '%auto_increment_offset%';
SHOW VARIABLES LIKE 'auto_inc%';
-- offset determines the starting point for the AUTO_INCREMENT column value
drop table if exists auto;	
create table auto ( 
	id int(6) unsigned zerofill not null auto_increment ,
	columnname Integer(6),
	primary key (id)
);

insert into auto (columnname) values (1),(12),(123),(1234),(12345),(123456),(1234567),(12345678);
select * from auto;
