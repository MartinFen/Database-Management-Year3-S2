-- Implementing a 1 : 1 relationship
Drop Database if exists Foreign_Keys;
Create Database Foreign_Keys default CHARACTER SET = utf8 default COLLATE = utf8_general_ci;
Use Foreign_Keys;
-- Documentation 13.1.17.5 version 5.6
-- Section 14.5.6  version 5.6

-- The Parent and Child tables must use the same storage engine
-- Foreign key and Primary key must be same datatype

-- RESTRICT Rejects the delete or update operation for the parent table

Create Table Customer 
(
    Customer_id Integer(3) zerofill not null auto_increment, -- INT(M),M is maximum display width but is only applicable when using zerofill
    Name varchar(30), -- max column length is 30 characters, VARCHAR is variable length field, storage requirements for VARCHAR varies depending on the character set and number of characters
    primary key (customer_id) # synonym for INDEX, also synonym for KEY
) Engine = INNODB;

Create Table Customer_Sales 
(
    Transaction_id Integer(3) zerofill not null auto_increment,
    Amount 	   Decimal(7,2) zerofill,
    Customer_id    Integer(3) zerofill UNIQUE NOT NULL, -- can be at most one row in Customer_Sales for every row in Customer
    Tx_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
    PRIMARY KEY(Transaction_id), # synonym for INDEX, also synonym for KEY
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id) ON DELETE RESTRICT ON UPDATE RESTRICT -- forbids Updates and Deletes TO PK in parent
) Engine= INNODB;

Insert Into customer values(100,'Kelly'),(200,'Smith'),(300,'O''Sullivan'),(400,'O''Byrne');
Insert Into customer_sales values(1,23.50,100,'2017-01-15 12:00:00'),(2,80.99,200,'2017-01-5 14:00:00'),(3,23.50,300,'2017-01-8 10:00:00'),(4,80.99,400,'2016-12-8 18:00:00');

select * from customer;
select * from customer_sales;
Insert Into customer_sales (Transaction_id,Amount,Customer_id) values(5,30.00,100); -- Duplicate error, already have customer_id = 1

Delete From customer_sales where customer_id=100;                                   -- Success : can delete child even if parent exists

SHOW CREATE TABLE CUSTOMER;
SHOW CREATE TABLE CUSTOMER_SALES;


--  Inserts 
Insert Into customer_sales values(7,39.99,500,'2016-01-20'); -- Failure : cannot insert into child when no corresponding parent entry exists !!!

Insert Into customer values(500,'Jones');                    -- Success : can insert into parent when no child exists, no insert constraint on parent
Insert Into customer_sales values(7,39.99,500,'2016-01-27'); -- Success : can now insert into child as corresponding parent data exists !!!
  

--  Deletes 
Delete From customer where customer_id=300;                   -- Failure : cannot delete parent when child exists
Insert Into customer values(600,'Fitzy'); 
Delete From customer where customer_id=600;                   -- Success : can delete parent when no child exist

--  Updates 
UPDATE customer SET customer_id=customer_id+10;               --  Failure : cannot update parent pk when child exists
UPDATE customer SET name='jones' where name='kelly';          --  Success : update doesn't involve pk or fk
Insert Into customer values(600,'Fitzy');
UPDATE customer_sales SET amount = 200.00 where customer_id = 100; --  Success : update doesn't involve pk or fk 

select * from customer;
select * from customer_sales;

Insert Into customer values(600,'Fitzy'); 
UPDATE customer SET customer_id=customer_id+10 where Name = 'Fitzy';--  can Update parent when no child exists
select * from customer;
select * from customer_sales;

SHOW CREATE TABLE customer_sales;
ALTER TABLE customer_sales drop FOREIGN KEY customer_sales_ibfk_1 ;-- Customer_sales has no longer got a foreign key restriction

Delete From customer where customer_id=300;                      -- Success as we have dropped the foreign key constraint
##################################################################################################################
-- Implementing a 1 : Many relationship take out UNIQUE in customer_id column
Drop Database if exists Foreign_Keys;
Create Database Foreign_Keys default CHARACTER SET = utf8 default COLLATE = utf8_general_ci;
Use Foreign_Keys;

Create Table Customer 
(
    Customer_id Integer(3) zerofill not null auto_increment,
    Name        varchar(30),
    primary key (customer_id)
) ;

Create Table Customer_Sales 
(
    Transaction_id Integer(3) zerofill not null auto_increment,
    Amount 	   Decimal(7,2) zerofill,
    Customer_id    Integer(3) zerofill NOT NULL, -- remove UNIQUE constraint
    Tx_Date timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(Transaction_id), # synonym for INDEX, also synonym for KEY
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ;

Insert Into customer values(100,'Kelly'),(200,'Smith'),(300,'O''Sullivan'),(400,'O''Byrne');
Insert Into customer_sales values(1,23.50,100,'2017-01-15 12:00:00'),(2,80.99,200,'2017-01-5 14:00:00'),(3,23.50,300,'2017-01-8 10:00:00'),(4,80.99,400,'2016-12-8 18:00:00');

select * from customer;
select * from customer_sales;
Insert Into customer_sales (Transaction_id,Amount,Customer_id) values(5,30.00,100); /* No error as 1 : Many relationship */
select * from customer;
select * from customer_sales;

SHOW CREATE TABLE CUSTOMER;
SHOW CREATE TABLE CUSTOMER_SALES;



########################################################################################################
--  Inserts 
Insert Into customer_sales values(7,39.99,500,'2016-01-20'); -- Failure : cannot insert into child when no corresponding parent entry exists !!!
Insert Into customer values(500,'Jones');                    -- Success : can insert into parent when no child exists,  
Insert Into customer_sales values(7,39.99,500,'2016-01-27'); -- Success : can now insert into child as corresponding parent data exists !!!
  

--  Deletes 
Delete From customer where customer_id=300;                   -- Failure : cannot delete parent as child exists
Insert Into customer values(600,'Fitzy'); 
Delete From customer where customer_id=600;                   -- Success : can delete parent as no child dependencies exist

--  Updates 

Insert Into customer values(600,'Fitzy'); 
UPDATE customer SET customer_id=customer_id+10;               --  Failure : cannot update parent when child exists
select * from customer;
select * from customer_sales;

UPDATE customer SET customer_id=customer_id+10 where Name = 'Fitzy';--  can update parent when no child exists
select * from customer;
select * from customer_sales;

SHOW CREATE TABLE customer_sales;
ALTER TABLE customer_sales drop FOREIGN KEY customer_sales_ibfk_1 ;

Delete From customer where customer_id=300;                      -- Success as we have dropped the foreign key constraint
#####################################################################################################
-- Implementing ON DELETE CASCADE and ON UPDATE CASCADE
Drop Database if exists Foreign_Keys;
Create Database Foreign_Keys default CHARACTER SET = utf8 default COLLATE = utf8_general_ci;
Use Foreign_Keys;
#13.1.17.5
Create Table Customer 
(
    customer_id Integer(3) zerofill not null auto_increment,
    name        varchar(30),
    primary key (customer_id)
) engine = innodb;

Create Table Customer_Sales 
(
    Transaction_id Integer(3) zerofill not null auto_increment,
    Amount 	   Decimal(7,2) zerofill,
    Customer_id    Integer(3) zerofill NOT NULL, # one to many relationship
    Tx_Date timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(Transaction_id), #    INDEX (customer_id),
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id) ON DELETE CASCADE ON UPDATE CASCADE
) engine= innodb;

Insert Into customer values(100,'Kelly'),(200,'Smith'),(300,'O''Sullivan'),(400,'O''Byrne');
Insert Into customer_sales values(1,23.50,100,'2017-01-15 12:00:00'),(2,80.99,200,'2017-01-5 14:00:00'),(3,23.50,300,'2017-01-8 10:00:00'),(4,80.99,400,'2016-12-8 18:00:00');

select * from customer;
select * from customer_sales;

UPDATE customer SET customer_id=customer_id+10; --  can update parent
select * from customer;
select * from customer_sales;

Delete from customer where customer_id=410 ;    --  can delete parent row and cascades to delete child row
select * from customer;
select * from customer_sales;
####################################################################################################
-- Implementing ON DELETE SET NULL and ON UPDATE SET NULL
Drop Database if exists Foreign_Keys;
Create Database Foreign_Keys default CHARACTER SET = utf8 default COLLATE = utf8_general_ci;
Use Foreign_Keys;
Create Table Customer 
(
    Customer_id Integer(3) zerofill null auto_increment , # change column to null
    name        varchar(30),
    primary key (customer_id)
) engine = innodb;

Create Table Customer_Sales 
(
    Transaction_id Integer(3) zerofill not null,
    Amount 	   Decimal(7,2) zerofill,
    Customer_id    Integer(3)  zerofill null, -- change column to null
    Tx_Date timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(transaction_id), #  INDEX (customer_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE set null ON UPDATE set null
) engine= innodb;

Insert Into customer values(100,'Kelly'),(200,'Smith'),(300,'O''Sullivan'),(400,'O''Byrne');

Insert Into customer_sales values(1,23.50,100,'2017-01-15 12:00:00'),(2,80.99,200,'2017-01-5 14:00:00'),(3,23.50,300,'2017-01-8 10:00:00'),(4,80.99,400,'2014-12-8 18:00:00');

select * from customer;
select * from customer_sales;

Delete from customer where customer_id=400 ; --  can delete parent row, set FK in child to null
select * from customer;
select * from customer_sales;

UPDATE customer SET customer_id=customer_id+10; --  can update parent, set child to null
select * from customer;
select * from customer_sales;

##########################################################################################################################

/*In relational database design, a many-to-many relationship is not allowed.  
To get around the problem of having a many-to-many relationship you need to break apart the many-to-many relationship into two one-to-many relationships.  Using a third table, commonly called a “join table”, does this.  Each record in the “join table” would have the foreign key fields of the two tables it is joining together.  */
-- Implementing a Many : Many relationship (ON UPDATE RESTRICT ON DELETE RESTRICT)
Drop Database if exists Foreign_Keys;
Create Database Foreign_Keys default CHARACTER SET = utf8 default COLLATE = utf8_general_ci;
Use Foreign_Keys;
#13.1.17.3
Create Table Students 
(
    Student_id Integer(3) not null auto_increment,
    Student_Name Varchar(30),
    primary key (Student_id)
) engine = innodb;

Create Table Subjects 
(
    Subject_id Integer(3) not null auto_increment,
    Subject_Name Varchar(30),	
    PRIMARY KEY(Subject_id) # synonym for INDEX, also synonym for KEY
) engine= INNODB;

Create Table Students_Subjects_Join 
(
    Student_id Integer(3),
    Subject_id Integer(3),
    PRIMARY KEY(Student_id,Subject_id), # synonym for INDEX, also synonym for KEY
    FOREIGN KEY (Student_id) REFERENCES Students(Student_id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    FOREIGN KEY (Subject_id) REFERENCES Subjects(Subject_id) ON DELETE RESTRICT ON UPDATE RESTRICT
 ) engine= INNODB;
 


Insert Into Students values(100,'Mary Kelly'),(200,'Joe Smith'),(300,'John O''Sullivan'),(400,'Ann O''Byrne'),(500,'Patrick Kelly');
Insert Into Subjects values(1,'Maths'),(2,'English'),(3,'Irish'),(4,'French'),(5,'German');
Insert Into Students_Subjects_Join values(100,1),(100,2),(100,3),(200,3),(200,4),(200,5),(400,1),(400,2),(400,3),(400,4);

select * from Students;
select * from Subjects;
select * from Students_Subjects_Join order by student_id;

SHOW CREATE TABLE Students;
SHOW CREATE TABLE Subjects;
SHOW CREATE TABLE Students_Subjects_Join;


Delete from Students where Student_id=400; --  Restrict => cannot delete parent if child exists
										 						  
Delete from Students where Student_id=500;  -- can delete from parent if no child exists

Delete from Subjects where Subject_id=5;   --  Restrict => cannot delete parent if child exists
										  									  
Delete from Students_Subjects_Join where Student_id=400; --  Can delete from child
										   										  																					   
UPDATE Students SET Student_id=Student_id+10; -- RESTRICT : cannot update parent  										   
										
UPDATE Subjects SET Subject_id=Subject_id+10; -- RESTRICT : cannot update parent 
																			     
UPDATE Students_Subjects_Join SET Student_id=Student_id+10; --  Cannot UPDATE child
										 									   
select * from Students;
select * from Students_sales;


############################################################################################################################
-- Implementing a Many : Many relationship (ON UPDATE CASCADE ON DELETE CASCADE)
Drop Database if exists Foreign_Keys;
Create Database Foreign_Keys default CHARACTER SET = utf8 default COLLATE = utf8_general_ci;
Use Foreign_Keys;
#13.1.17.3
Create Table Students 
(
    Student_id Integer(2) not null auto_increment,
    Student_Name Varchar(30),
    primary key (Student_id)
) engine = innodb;

Create Table Subjects 
(
    Subject_id Integer(2) not null auto_increment,
    Subject_Name Varchar(30),	
    PRIMARY KEY(Subject_id) # synonym for INDEX, also synonym for KEY
) engine= INNODB;

Create Table Students_Subjects_Join 
(
    Student_id Integer(2),
    Subject_id Integer(2),
    PRIMARY KEY(Student_id,Subject_id), # synonym for INDEX, also synonym for KEY
    FOREIGN KEY (Student_id) REFERENCES Students(Student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Subject_id) REFERENCES Subjects(Subject_id) ON DELETE CASCADE ON UPDATE CASCADE
 ) engine= INNODB;
 


Insert Into Students values(100,'Mary Kelly'),(200,'Joe Smith'),(300,'John O''Sullivan'),(400,'Ann O''Byrne'),(500,'Patrick Kelly');
Insert Into Subjects values(1,'Maths'),(2,'English'),(3,'Irish'),(4,'French'),(5,'German');
Insert Into Students_Subjects_Join values(100,1),(100,2),(100,3),(200,3),(200,4),(200,5),(400,1),(400,2),(400,3),(400,4);

select * from Students;
select * from Subjects;
select * from Students_Subjects_Join order by student_id;

SHOW CREATE TABLE Students;
SHOW CREATE TABLE Subjects;
SHOW CREATE TABLE Students_Subjects_Join;


Delete from Students where Student_id=400;--  Cascade => cascade parent changes to child
										  
Delete from Students where Student_id=500;  -- can delete from parent as no child exists

Delete from Subjects where Subject_id=5;  --  Cascade => cascade parent changes to child
										  
Delete from Students_Subjects_Join where Student_id=400; --  can delete from child
										  																							   
UPDATE Students SET Student_id=Student_id+10; --  Cascade => cascade parent changes to child
										  
UPDATE Subjects SET Subject_id=Subject_id+10; --  Cascade => cascade parent changes to child
										     
UPDATE Students_Subjects_Join SET Student_id=Student_id+10;  --  cannot update child

										   
select * from Students;
select * from Student_sales;

###################################################################################################################
-- Implementing a Many : Many relationship (ON UPDATE set null ON DELETE set null)
Drop Database if exists Foreign_Keys;
Create Database Foreign_Keys default CHARACTER SET = utf8 default COLLATE = utf8_general_ci;
Use Foreign_Keys;
#13.1.17.3
Create Table Students 
(
    Student_id Integer(2) null auto_increment,
    Student_Name Varchar(30),
    primary key (Student_id)
) engine = innodb;

Create Table Subjects 
(
    Subject_id Integer(2) null auto_increment,
    Subject_Name Varchar(30),	
    PRIMARY KEY(Subject_id) # synonym for INDEX, also synonym for KEY
) engine= INNODB;

Create Table Students_Subjects_Join 
(
    Student_id Integer(2) null,
    Subject_id Integer(2) null,
    PRIMARY KEY(Student_id,Subject_id) ,# synonym for INDEX, also synonym for KEY
	-- From the MySQL documentation : A PRIMARY KEY must be defined as NOT NULL.
    FOREIGN KEY (Student_id) REFERENCES Students(Student_id) ON DELETE set null ON UPDATE set null,
    FOREIGN KEY (Subject_id) REFERENCES Subjects(Subject_id) ON DELETE set null ON UPDATE set null
 ) engine= INNODB;
 


Insert Into Students values(100,'Mary Kelly'),(200,'Joe Smith'),(300,'John O''Sullivan'),(400,'Ann O''Byrne'),(500,'Patrick Kelly');
Insert Into Subjects values(1,'Maths'),(2,'English'),(3,'Irish'),(4,'French'),(5,'German');
Insert Into Students_Subjects_Join values(100,1),(100,2),(100,3),(200,3),(200,4),(200,5),(400,1),(400,2),(400,3),(400,4);

select * from Students;
select * from Subjects;
select * from Students_Subjects_Join order by student_id;

SHOW CREATE TABLE Students;
SHOW CREATE TABLE Subjects;
SHOW CREATE TABLE Students_Subjects_Join;


Delete from Students where Student_id=400;
										  
Delete from Students where Student_id=500;  

Delete from Subjects where Subject_id=5; 
										  
Delete from Students_Subjects_Join where Student_id=400; 
										  																							   
UPDATE Students SET Student_id=Student_id+10; 
										  
UPDATE Subjects SET Subject_id=Subject_id+10; 
										     
UPDATE Students_Subjects_Join SET Student_id=Student_id+10;  

										   
select * from Students;
select * from Student_sales;

###################################################################################################################
# Query to display name of all students taking Irish


select student_name from students where student_id in (Select student_id from students_subjects_join where subject_id in (select subject_id from subjects where subject_name = 'Irish')); 

# Alternate Query to display name of all students taking Irish

select student_name from students as t 
join students_subjects_join as p on t.student_id=p.student_id 
join subjects as j on p.subject_id=j.subject_id 
where subject_name = "irish";

# Query to display all of the subjects that Ann O''Byrne is taking

select subject_name from subjects where subject_id in (select subject_id from students_subjects_join where student_id in (select student_id from students where student_name='Ann o''byrne'));

# Alternate Query to display all of the subjects Ann O''Byrne is taking

select subject_name from students as t 
join students_subjects_join as p on t.student_id=p.student_id join subjects as j on p.subject_id=j.subject_id where student_name = "Ann o''byrne"; 



