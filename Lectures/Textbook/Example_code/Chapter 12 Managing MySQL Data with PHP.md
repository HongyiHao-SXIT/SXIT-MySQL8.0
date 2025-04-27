### Chapter 12 Managing MySQL Data with PHP

#### Example 12-1
Use the `mysqli_connect()` function to connect to the local MySQL server.
```php
<?php 
$conn = mysqli_connect("localhost", "root", "123456") 
    or die("Failed to connect to the database server! ".mysql_error()); 
?> 
```

#### Example 12-2
Connect to the `teaching` database with the username `root` and the password `123456` locally.
```php
<?php 
$conn = mysqli_connect("localhost", "root", "123456"); // Connect to the MySQL database server
$select = mysqli_select_db($conn, "teaching"); // Connect to the teaching database on the server
if ($select) { // Check if the connection is successful
    header("Content-Type:text/html; charset=gb2312"); // Set the character set
    echo "Database connection successful!"; 
}
?>
```

#### Example 12-3
Query the data in the `student` table using PHP.
```php
<?php 
$conn1 = mysqli_connect("localhost", "root", "123456"); // Connect to the MySQL database server
$select = mysqli_select_db($conn1, "teaching"); // Connect to the teaching database on the server
if ($select) {
    header("Content-Type:text/html;charset=gb2312"); // Set the character set
    echo "Database connection successful!"; // Check if the connection is successful
} 
$query = "select * from  student";
$result = mysqli_query($conn1, $query) or die("Query failed! ".mysqli_error()); 
echo mysqli_affected_rows($conn1); 
?>
```

#### Example 12-4
Insert data into the `score` table.
```php
$sqlinsert = "insert into score values('20120210009', 'c05108', 88, 99)";
$result = mysqli_query($conn1, $sqlinsert) 
    or die("Insertion failed! ".mysqli_error());
```

#### Example 12-5
Delete data from the `score` table.
```php
$sqldelete = "delete from score where studentno = '20120210009' and courseno = 'c05108'";
mysqli_query($conn1, $sqldelete);
```

#### Example 12-6
Update data in the `score` table.
```php
$sqldelete = "update score set final = 99 where studentno = '20120210009' and courseno = 'c06108'";
mysqli_query($conn1, $sqldelete);
```

#### Example 12-7
Execute multiple SQL statements using the `multi_query()` function.
```php
$query = "insert into score values('20120210009', 'c05109', 87, 97);"; // Insert a row of data into the score table
$query = "select * from score;"; // Set the query to retrieve data from the score table
mysqli_multi_query($conn1, $query);
```

#### Example 12-8
Query the score information of the course with the course number `c08171` and output the results using both the `echo` command and the `print_r()` function.
```php
<?php 
$conn1 = mysqli_connect("localhost", "root", "123456"); // Connect to the MySQL database server
$select = mysqli_select_db($conn1, "teaching"); // Connect to the teaching database on the server
if ($select) {
    header("Content-Type:text/html;charset=gb2312"); // Set the character set
    echo "Database connection successful!"; // Check if the connection is successful
} 
$sql = "select * from score where courseno = 'c08171';";
if ($result = mysqli_query($conn1, $sql)) {
    while ($row = mysqli_fetch_assoc($result)) {
        echo  "<br />";
        echo  "Format using echo: <br />";
        echo  "Student ID: ".$row['studentno'];
        echo  "  Course ID: ".$row['courseno'];
        echo  "  Daily Score: ".$row['daily'];
        echo  "  Final Score: ".$row['final']."<br/>";
        echo  "Format using print_r() function: <br />";
        print_r($row);
    }
    mysqli_free_result($result); // Free the memory
}
mysqli_close($conn1); // Close the connection object
?>
```