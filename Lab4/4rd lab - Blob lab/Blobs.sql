Drop database if exists Blobs;
Show databases;
create database Blobs;
Use Blobs;
Show tables;
Drop table if exists Blobs;


create table Blobs  (
  id integer auto_increment,
  picture LongBlob,
  picture_path varchar(20),
  video LongBlob,
  video_path varchar(20),
  fileDB LongBlob,
  file_path varchar(20),
  PRIMARY KEY (id)
  ) COLLATE latin1_general_ci, Engine=InnoDB;
  

  
Insert into Blobs values (1, load_file("C:/flower.jpg"),"/flower.jpg",load_file("C:/movie.ogg"),"/movie.ogg",load_file("C:/TEST.pdf"),"/test.pdf");
  
Insert into Blobs values (2, load_file("C:/flower.jpg"),"/flower.jpg",load_file("C:/movie.ogg"),"/movie.ogg",load_file("C:/TEST.pdf"),"/test.pdf");
