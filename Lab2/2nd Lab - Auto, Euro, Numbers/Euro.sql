-- 4.5.1.6.2 Unicode Support on Windows

-- http://dev.mysql.com/doc/refman/5.6/en/mysql-tips.html
-- mysql -u root --default-character-set=utf8
-- add 3 lines below to my.ini 
-- 1. [client]   --  mysql client 
-- 2.   default-character-set=utf8
-- 3. [mysql]     --  mysql COMMAND LINE CLIENT ONLY
-- 4.   default-character-set=utf8
-- 5. [mysqld]    --  mysql server
-- 6.   character-set-server = utf8

-- Lucida Typeface

-- The € (euro) symbol is a three byte character, with byte values in file (UTF-8) of 0xE2, 0x82, 0xAC.
-- 10.1.3 Unicode Support
-- 10.1.10 Unicode Support

show character set;
show collation;

status;
-- look at various character sets and collations
-- Server character set
-- Database character set
-- Client character set
-- Connection character set 
-- http://www.ltg.ed.ac.uk/~richard/utf-8.cgi?input=%E2%82%AC&mode=char

SHOW VARIABLES LIKE '%character%';
SET global character_set_server=utf8; 
SET session character_set_server=utf8; 
SHOW VARIABLES LIKE '%collations%';

drop database if exists euro;
create database euro CHARACTER SET utf8 COLLATE UTF8_GENERAL_CI;
use euro;
create table euro 
(  symbol varchar(10) CHARACTER SET utf8 COLLATE UTF8_GENERAL_CI );

-- 10.1.3.5  Character String Literal Character Set and Collation v5.6

Show full columns from euro;
insert into euro values (_utf32 0x000020ac);
insert into euro values (_utf16 0x20ac);
insert into euro values (0xE282AC);
insert into euro values ('€');
select * from euro;

