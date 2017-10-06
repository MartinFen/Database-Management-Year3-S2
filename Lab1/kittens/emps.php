<html>
	<head>
		<title>Php Picture Table Example</title>
	</head>	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<body>
		<h4>Select empno,title, ename, degree,job,mgr,hiredate,currency_symbol,salary,comm, deptno, last_update, picture, picture_path from emp </h4>
	
		<table border="1">
			
			<tr>
				<td><h2>empno</h2></td>
				<td><h2>title</h2></td>
				<td><h2>ename</h2></td>
				<td><h2>degree</h2></td>
				<td><h2>job</h2></td>
				<td><h2>mgr</h2></td>
				<td><h2>hiredate</h2></td>
				<td><h2>currency</h2></td>
				<td><h2>salary</h2></td>
				<td><h2>comm</h2></td>
				<td><h2>deptno</h2></td>
				<td><h2>last_update</h2></td>
				<td><h2>picture</h2></td>
				<td><h2>picture_path</h2></td>
	
			
			</tr>

			<?php			
				$host = "localhost";
				$host1 = "http://localhost";
				$user = "root";
				$password = "";
				$database = "db3";				
				
				$query = "Select empno,title, ename, degree,job,mgr,hiredate,currency_symbol,salary,comm, deptno, last_update, picture, picture_path from emp";

				$connect = mysqli_connect($host,$user,$password,$database) or die("Problem connecting.");
				$result = mysqli_query($connect,$query) or die("Bad Query.");

				mysqli_close($connect);

				while($row = $result->fetch_array())
				{
				
					echo "<tr>";
					echo "<td><h2>" .$row['empno'] . "</h2></td>";
					echo "<td><h2>" .$row['title'] . "</h2></td>";
					echo "<td><h2>" .$row['ename'] . "</h2></td>";
					echo "<td><h2>" .$row['degree'] . "</h2></td>";
					echo "<td><h2>" .$row['job'] . "</h2></td>";
					echo "<td><h2>" .$row['mgr'] . "</h2></td>";
					echo "<td><h2>" .$row['hiredate'] . "</h2></td>";
					echo "<td><h2>" .$row['currency_symbol'] . "</h2></td>";
					echo "<td><h2>" .$row['salary'] . "</h2></td>";
					echo "<td><h2>" .$row['comm'] . "</h2></td>";
					echo "<td><h2>" .$row['deptno'] . "</h2></td>";
					echo "<td><h2>" .$row['last_update'] . "</h2></td>";
					echo "<td><h2><img src=image_emp.php?empno=".$row['empno']." width=80 height=80/></h2></td>";
					echo "<td><h2><img src=".$host1.$row['picture_path'] . " width=80 height=80/></h2></td>";
					# echo "<td><h2><img src=".$row['picture_path'] . " width=100 height=100/></h2></td>";
				    echo "</tr>";
				}
			?>

		<table>
	</body>
</html>