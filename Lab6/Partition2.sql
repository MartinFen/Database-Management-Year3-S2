Drop database if exists Partitions;
Show databases;
-- create database Partitions CHARACTER SET utf8 COLLATE utf8_unicode_ci;
create database Partitions CHARACTER SET utf8 COLLATE utf8_bin;
Use Partitions;

Create Table Expenses ( 
	expense_date DATE NOT NULL, 
	category VARCHAR(30), 
	amount DECIMAL (10,2) 
);
--  Note category 
Alter table expenses 
partition by list columns (category) 

( 
partition p1 values in ( 'lodging', 'food'), 
partition p2 values in ( 'flights', 'ground transportation'), 
partition p3 values in ( 'leisure', 'customer entertainment'), 
partition p4 values in ( 'communications'), 
partition p5 values in ( 'fees') 
);
-- data files created in C:\wamp\bin\mysql\mysql5.6.17\data\partitions 

Insert into expenses values (curdate(), 'Food', 200.50);
Insert into expenses values (curdate(), 'customer entertainment', 2000.00);
Insert into expenses values (curdate(), 'Leisure', 100.00); 
Insert into expenses values (curdate(), 'Fees', 100.00);
Insert into expenses values (curdate(), 'Food', 200.50);
Insert into expenses values (curdate(), 'Flights', 2000.00);
Insert into expenses values (curdate(), 'communications', 100.00); 
Insert into expenses values (curdate(), 'Fees', 100.00); 
Insert into expenses values (curdate(), 'Food', 200.50);
Insert into expenses values (curdate(), 'communications', 2000.00);
Insert into expenses values (curdate(), 'Leisure', 100.00); 
Insert into expenses values (curdate(), 'Fees', 100.00); 

SELECT * FROM EXPENSES;

SELECT * FROM EXPENSES PARTITION (p5);

ALTER TABLE expenses DROP PARTITION p5;
