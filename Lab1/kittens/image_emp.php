<?php
    $var = mysqli_connect("Localhost", "root", "");
    mysqli_select_db($var, "db3") or die(mysqli_error());
	$image_empno = $_GET['empno'];
    $sql = "Select picture from emp where empno=$image_empno" ;
    $resultset = mysqli_query($var, "$sql") or die("Invalid query: " . mysqli_error());
	$row = mysqli_fetch_array($resultset);
	header('Content-type: image/jpeg');
	echo $row[0];
   	mysqli_close($var);
?>

