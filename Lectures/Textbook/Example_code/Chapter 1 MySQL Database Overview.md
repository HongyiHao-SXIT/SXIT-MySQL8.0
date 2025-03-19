### Chapter 1 MySQL Database Overview
1. **Logging in to the MySQL Database in the DOS Window**: When logging in to the MySQL database through the DOS window to execute statements, right - click the "Start" button, select the "Run" command from the menu, enter "cmd" in the pop - up dialog box, and then press the Enter key to enter the DOS window. First, practice stopping and starting the server, and then execute the MySQL statement to log in to the database. After a successful login, the welcome message "Welcome to the MySQL monitor" will appear.
Example:
```bash
Microsoft Windows [Version 10.0.16299.15]
(c) 2017 Microsoft Corporation. All rights reserved.

C:\Users\Administrator>net stop mysql80
C:\Users\Administrator>net start mysql80
C:\Users\Administrator>mysql -u root -p
Enter password: ******
mysql>
```
2. **Example: Error Occurred When Executing a Statement**: For example, when executing the statement "select  year(current_data);" in the command, an error 1054 occurs.
```sql
mysql> select  year(current_data);
ERROR 1054 (42S22): Unknown column 'current_data' in 'field list'
```
3. **Example: Viewing Help Information**: After successfully logging in to the MySQL database, you can directly enter "help;" or "\h" to view the help information. Just enter the "help;" statement in the console and press the Enter key.
```sql
mysql> help
mysql>
```
4. **Example: Viewing the Current System Time**: If you want to view the current system time, you can directly enter and execute "select now();" in the console.
```sql
mysql> select now();
mysql>
``` 