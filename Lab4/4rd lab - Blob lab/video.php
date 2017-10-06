<?php
    $var = mysqli_connect("localhost", "root");
    mysqli_select_db($var, "blobs") or die(mysqli_error());
	$video_id = $_GET['id'];
    $sql = "Select video from blobs where id=$video_id" ;
    $resultset = mysqli_query($var, "$sql") or die("Invalid query: " . mysqli_error());
	$row = mysqli_fetch_array($resultset);
	header('Content-type: video/ogg');
	echo $row[0];
   	mysqli_close($var);
?>

