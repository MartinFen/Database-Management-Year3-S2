<?php
    $var = mysqli_connect("localhost", "root");
    mysqli_select_db($var, "blobs") or die(mysqli_error());
	$image_id = $_GET['id'];
    $sql = "Select picture from blobs where id=$image_id" ;
    $resultset = mysqli_query($var, "$sql") or die("Invalid query: " . mysqli_error());
	$row = mysqli_fetch_array($resultset);
	header('Content-type: image/jpeg');
	echo $row[0];
   	mysqli_close($var);
?>

