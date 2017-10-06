<html>
	<head>
		<title>Php Picture Table Example</title>
	</head>	
	
	<body>
		<h4>Select id,picture, picture_path, video, video_path, fileDB, file_path from blobs </h4>
	
		<table border="1">
			
			<tr>
				<td><h2>id</h2></td>
				<td><h2>picture</h2></td>
				<td><h2>picture_path</h2></td>
				<td><h2>video</h2></td>
				<td><h2>video_path</h2></td>
				<td><h2>fileDB</h2></td>
				<td><h2>file_path</h2></td>
			
			</tr>

			<?php			
				$host = "localhost";
				$host1 = "http://localhost";
				$user = "root";
				$password = "";
				$database = "blobs";				
				
				$query = "SELECT id,picture, picture_path, video, video_path, fileDB, file_path from blobs ";

				$connect = mysqli_connect($host,$user,$password,$database) or die("Problem connecting.");
				$result = mysqli_query($connect,$query) or die("Bad Query.");

				mysqli_close($connect);

				while($row = $result->fetch_array())
				{
				
					echo "<tr>";
					echo "<td><h2>" .$row['id'] . "</h2></td>";
					echo "<td><h2><img src=image_blobs.php?id=".$row['id']." width=150 height=150/></h2></td>";
					echo "<td><h2><img src=".$row['picture_path'] . " width=150 height=150/></h2></td>";
					echo "<td><h2><embed src=video.php?id=".$row['id']." width=150 height=150/></h2></td>";
					echo "<td><h2><embed src=".$row['video_path'] . " width=150 height=150/></h2></td>";
					echo "<td><h2><embed src=PDFFile.php?id=".$row['id']." width=350 height=150/></h2></td>";
					echo "<td><h2><embed src=".$row['file_path'] . " width=350 height=150/></h2></td>";
				    echo "</tr>";
				}
			?>

		<table>
	</body>
</html>


