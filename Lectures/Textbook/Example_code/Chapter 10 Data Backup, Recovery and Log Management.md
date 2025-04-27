### Chapter 10 Data Backup, Recovery and Log Management

#### Example 10.1
Use the `mysqldump` command to back up all tables in the `mytest` database.
```
mysqldump -u root -p mytest > d:/bak/mytestbak.sql 
Enter password:****** 
```

#### Example 10.2
Use the `mysqldump` command to back up the `student` and `score` tables in the database.
```
mysqldump -u root -p teaching student score > d:/bak/teaching_ss.sql 
Enter password:******
```

#### Example 10.3
Use the `mysqldump` command to back up the `course` table in the database.
```
mysqldump -u root -p teaching course > d:/bak/course.sql 
Enter password:******
```

#### Example 10.4
Use the `mysqldump` command to back up the `teaching` and `mytest` databases.
```
mysqldump -u root -p --databases teaching mytest > d:/bak/teach_test.sql 
Enter password:****** 
```

#### Example 10.5
Use the MySQL command to restore the backup file `mytestbak.sql` to the database.
```
mysql -u root -p mytest <d:\bak\mytestbak.sql
Enter password:****** 
```

#### Example 10.6
Delete the data of the `course` table in the `teaching` database and restore it using the `source` command.
```sql
-- Try to delete the data of the course table.
mysql> use teaching;
Database changed
mysql> delete from course; 

-- Use the backup file course.sql of the course placed in the "d:/bak" path and use the source command to import the backed-up file for restoration.
mysql> source d:/bak/mysdut.sql; 
```
2. **Restore the database**
If you have logged in to the MySQL server, you can also use the `source` command to import the `.sql` file. The syntax of the `source` statement is as follows.
```sql
source filename.sql 
```

#### Example 10.7
Use the `source` command to restore the backup file `mytestbak.sql` to the database.
```sql
mysql> use mytest; 
Database changed 
mysql> source d:\bak\mytestbak.sql ;
mysql> set names utf8mb4;
mysql> source d:/backup/mytestbak.sql; 
```

#### Example 10.8
Back up a single table `student`.
```sql
mysql> select  * into outfile 
    -> 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/student.txt'
    -> from student;
```

#### Example 10.9
Back up the data of the `student` table into `.xls` and `.xml` formats respectively.
```sql
mysql> select * into outfile
    -> 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/student.xls' 
    -> from student;
mysql> select * into outfile
    -> 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ student.xml'
    -> from student;
```

#### Example 10.10
Use the `select…into outfile` command to export the records in the `score` table of the `teaching` database to a text file. Use the `fields` option and the `lines` option. Require that fields are separated by commas “,”, all field values are enclosed in double quotes, and the escape character is defined as a single quote “\'”. Execute the following command:
```sql
mysql> select * from score into outfile
    -> 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/score.txt'
    -> fields
    ->     terminated by ','
    ->     enclosed by '\"'
    ->     escaped by '\''
    -> lines
    ->     terminated by '\r\n';
```

#### Example 10.11
Use the MySQL command to export the records in the `teacher` table of the `teaching` database to a text file.
```
mysql –u root –p --execute="select * from teacher;" teaching >d:/bak/teach.txt 
Enter password:****** 
```
Or
```
mysql -u root -p -e "select * from teacher;" teaching >d:/bak/teatxt.txt 
Enter password:****** 
```

#### Example 10.12
Restore the data of the `student` table. Try to delete some or all data of the `student` table with `delete`.
```sql
mysql> delete  from student;
mysql> load data infile
    -> 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ student.xls'  
    -> into  table  student;
```

#### Example 10.13
Restore the data of the `student` table with the backed-up `student.txt` file. To avoid primary key conflicts, use `replace into table` to directly replace the data for restoration.
```sql
mysql> load data infile
    -> 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/student.txt'
    -> replace into  table student ;
```

#### Example 10.14
Use the `load data infile` command to import the data in the file `'C:/ProgramData/MySQL/MySQL Server 8.0/ Uploads/score.txt'` into the `score` table in the `teaching` database. Use the `fields` option and the `lines` option. Require that fields are separated by commas “,”, all field values are enclosed in double quotes, and the escape character is defined as a single quote “\'”.
```sql
mysql> delete from score;
mysql> load data infile 
    -> 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/score.txt' 
    -> into table score
    ->       fields
    ->           terminated by ','
    ->           enclosed by '\"'
    ->           escaped by '\''
    ->       lines
    ->           terminated by '\r\n';
```

#### Example 10.15
Use Notepad to view the MySQL error log.
```sql
-- Query the storage path and file name of the error log through the show variables statement:
mysql> show variables like 'log_error';
+---------------+-----------------------+
| Variable_name | Value                    |
+---------------+-----------------------+
| log_error      | .\R4TR8O7MK8BANSN.err |
+---------------+-----------------------+
1 row in set, 1 warning (0.00 sec)
```
-- You can see that the error file is `\R4TR8O7MK8BANSN.err`, which is located in the default data directory of MySQL. Open this file with Notepad, and you can see the MySQL error log:
```
2020-12-22T00:09:43.277341Z 779 [ERROR] [MY-010045] [Server] Event Scheduler: [root@localhost][teaching.e_test] Table 'teaching.test' doesn't exist
2020-12-23T01:32:52.972820Z 1239 [ERROR] [MY-010045] [Server] Event Scheduler: [root@localhost][teaching.e_test] Table 'teaching.test' doesn't exist
2020-12-24T01:05:05.324028Z 1658 [ERROR] [MY-010045] [Server] Event Scheduler: [root@localhost][teaching.e_test] Table 'teaching.test' doesn't exist
……
2020-12-26T13:01:08.131993Z 2540 [Warning] [MY-010312] [Server] The plugin 'newpasswd' used to authenticate user 'king1'@'localhost' is not loaded. Nobody can currently login using this account. 
```

#### Example 10.16
Use the `show variables` statement to query the log settings.
```sql
mysql> show variables like 'log_%';
```

#### Example 10.17
Use `show binary logs` to view the number and file names of binary log files.
```sql
mysql> show binary logs;
```

#### Example 10.18
Use `mysqlbinlog` to view the binary log `R4TR8O7MK8BANSN-bin.000003`.
```
-- Command to view the binary log R4TR8O7MK8BANSN-bin.000003
C:\Users\Administrator>mysqlbinlog  R4TR8O7MK8BANSN-bin.000003
-- Command running result, content of the binary log R4TR8O7MK8BANSN-bin.000003
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
mysqlbinlog: File 'R4TR8O7MK8BANSN-bin.000003' not found (OS errno 2 - No such file or directory)
ERROR: Could not open log file
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
C:\Users\Administrator>
```

#### Example 10.19
Use `purge master logs` to delete all log files created earlier than `R4TR8O7MK8BANSN-bin.000003`.
```sql
mysql> show binary logs;
mysql>  purge master logs TO 'R4TR8O7MK8BANSN-bin.000003';
mysql> show binary logs;
```

#### Example 10.20
Use `purge master logs` to delete all log files created before December 23, 2020.
```sql
mysql> purge master logs before '20201223';
```

#### Example 10.21
Use `mysqlbinlog` to restore the MySQL database to the state at 17:00:00 on December 23, 2020.
```
C:\>mysqlbinlog –stop-date="2020-12-23 17:00:00" C:\Documents and Settings\All Users\MySQL\MySQL Server 8.0\Data
\R4TR8O7MK8BANSN-bin.000005 –u root  -p
Enter password: ******
```

#### Example 10.22
View the slow query log. Open the `R4TR8O7MK8BANSN-slow.log` file in the data directory with a text editor. 