<?php
    error_reporting(0); 
	$var=mysql_connect("localhost", "root");
    mysql_select_db("blobs") or die(mysql_error());
	$file_id = $_GET['id'];
    $sql = "Select FileDB from blobs where id=$file_id" ;
    $resultset = mysql_query("$sql") or die("Invalid query: " . mysql_error());
	$row = mysql_fetch_array($resultset);
	header('Content-type: application/pdf');
	echo $row[0];
   	mysql_close($var);
	
?> 


