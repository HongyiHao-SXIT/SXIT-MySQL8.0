### Chapter 9 Permission Management and Security Control

#### Example 9.1
Add two new users. The password for Hans is 'hans131', and the password for Rose is 'rose123'.
```sql
mysql> create user
    -> 'Hans'@'localhost' identified by 'hans131',
    -> 'Rose'@'localhost' identified by 'rose123';
```

#### Example 9.2
Create users 'test11' and 'test22', and then rename users 'test11' and 'test22' to 'king1' and 'king2' respectively.
```sql
mysql> create user
    -> 'test11'@'localhost' identified by 'test131',
    -> 'test22'@'localhost' identified by 'test232';
mysql> select Host, User from mysql.user where user like 'test%';
mysql> rename user
    -> 'test11'@'localhost' to 'king1'@'localhost',
    -> 'test22'@'localhost' to 'king2'@'localhost';
```

#### Example 9.3
Log in to the 'mysql' database of the local MySQL server using the root user.
```
C:\>mysql -h localhost -u root -p mytest
Enter password: ******
```

#### Example 9.4
Log in to the 'mytest' database of the local MySQL server using the root user and execute a query statement at the same time.
```
C:\> mysql -h localhost -u root -p teaching –e "select studentno, sex, entrance, phone from student where entrance > 850;"
Enter password: ******
C:\>
```

The following is the statement to modify the password of user 'king1' using the 'update' statement:
```sql
mysql> update mysql.user set authentication_string = 'newpasswd'
    -> where user = 'king1' and host = 'localhost';
mysql> select host, user, authentication_string from user
    -> where user like 'k%';
```

#### Example 9.5
Create a new user 'grantuser' with the password 'grantpass'. Use the 'grant' statement to give user 'grantuser' the permissions to query and insert data on all databases and also grant the 'grant' permission.
```sql
mysql> create user 'grantuser'@'localhost' identified by 'grantpass';
mysql> grant select, insert on *.* to 'grantuser'@'localhost'
    -> with grant option;
```

#### Example 9.6
Use the 'grant' statement to grant user 'grantuser' the 'delete' permission on the 'student' table in the 'teaching' database.
```sql
mysql> grant delete on teaching.student to 'grantuser'@'localhost';
```

#### Example 9.7
Grant user 'grantuser' the 'update' permission on the 'studentno' and 'sname' columns of the 'student' table.
```sql
mysql> grant update(studentno, sname)
    -> on student to grantuser@localhost;
```

#### Example 9.8
Grant user 'grantuser' the permissions to create stored procedures and stored functions in the 'teaching' database.
```sql
mysql> grant create routine on teaching.*
    -> to grantuser@localhost;
```

#### Example 9.9
Revoke user 'grantuser's 'update' permission on the 'student' table in the 'teaching' database.
```sql
mysql> revoke update on teaching.student
    -> from grantuser@localhost;
```

#### Example 9.10
Use the 'revoke' statement to revoke all permissions of user 'grantuser', including the 'grant' permission.
```sql
mysql> revoke all privileges, grant option
    -> from grantuser@localhost;
```

For example, use the 'show grants' statement to view the permission information of user 'grantuser'. Here, 'USAGE' means no permission.
```sql
mysql> show grants for grantuser@localhost;
```

#### Example 9.11
Create user 'fans'. Grant user 'fans' the permission to issue 20 queries, connect to the database 5 times, issue 10 data updates per hour, and connect to 2 MySQL instances simultaneously.
```sql
mysql> create user 'fans'@'localhost' identified by 'frank'
    -> with max_queries_per_hour 20
    -> max_updates_per_hour 10
    -> max_connections_per_hour 5
    -> max_user_connections 2;
```

#### Example 9.12
Create three roles 'teach_developer', 'teach_read', and 'teach_write' in the 'teaching' database.
```sql
mysql> use teaching;
Database changed
mysql> create role 'teach_developer', 'teach_read', 'teach_write';
```

#### Example 9.13
Grant permissions to the three roles 'teach_developer', 'teach_read', and 'teach_write' in the 'teaching' database respectively.
```sql
mysql> grant all on teaching.* to 'teach_developer';
mysql> grant select on teaching.* to 'teach_read';
mysql> grant insert, update, delete on teaching.* to 'teach_write';
```

#### Example 9.14
First, view the custom users in the 'teaching' database, and then grant permissions through roles.
```sql
mysql> select Host, User from mysql.user;
mysql> grant 'teach_developer' to 'Hans'@'localhost';
mysql> grant 'teach_read' to 'king1'@'localhost', 'king2'@'localhost';
-- Combine the read and write permissions required by the roles and grant the read and write roles to user 'Rose' in the 'grant' statement
mysql> grant 'teach_read', 'teach_write' to 'Rose'@'localhost';
```

For example, view the value of 'password_history'.
```sql
mysql> show variables like '%password_history%';
```

For example:
```sql
-- Set the password expiration days to the specified number of days
mysql> alter user 'Rose'@'localhost' password expire interval 90 day;

-- Set the password to never expire
mysql> alter user 'Rose'@'localhost' password expire never;

-- Set the default password expiration policy, following the global password expiration policy
mysql> alter user 'Rose'@'localhost' password expire default;

-- Manually force the user's password to expire
-- Set the password of account 'Rose' to expire
mysql> alter user 'Rose'@'localhost' password expire;

-- Log in to MySQL using the 'Rose' account, and an error message will appear
mysql> select 1;
ERROR 1820 (HY000): You must SET password before executing this statement

-- Set the user's password to be valid again
mysql> alter user user() identified by 'new_pswd';
```