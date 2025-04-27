### Chapter 7 Stored Procedures and Triggers

#### Example 7.1
Create a stored procedure named `proc_stu` to retrieve information such as student numbers, names, birth dates, and phone numbers of all students whose phone numbers start with '131' from the `student` table in the `teaching` database.
```sql
mysql> use teaching;
Database changed
mysql> delimiter //
mysql> create procedure proc_stu()
    -> reads sql data
    -> begin
    -> select studentno, sname, birthdate, phone
    -> from student
    -> where phone like '%131%' order by studentno;
    -> end//
mysql> delimiter ;
mysql> call proc_stu();
```

#### Example 7.2
Create a stored procedure named `avg_score` to calculate the average score of a specified course after inputting the course number.
```sql
mysql> delimiter //
mysql> create procedure avg_score(in c_no char(6))
    -> begin
    -> select courseno, avg(final)
    -> from score
    -> where courseno = c_no;
    -> end //
mysql> delimiter ;
mysql> call avg_score('c05109');
```

#### Example 7.3
Create a stored procedure named `select_score` to query student scores using specified student numbers and course numbers as parameters.
```sql
mysql> delimiter $$
mysql> create procedure select_score(in s_no char(11), c_no char(6))
    -> begin
    -> select * from score
    -> where studentno = s_no and courseno = c_no;
    -> end $$
mysql> delimiter ;
mysql> call select_score('20125121109', 'c05109');
```

#### Example 7.4
Create a stored procedure named `stu_scores` to count the number of exams taken by a specified student.
```sql
mysql> delimiter //
mysql> create procedure stu_scores(in s_no char(11), out count_num int)
    -> reads SQL data
    -> begin
    -> select count(*) into count_num from score
    -> where studentno = s_no;
    -> end //
mysql> delimiter ;
mysql> call stu_scores('20125121109', @c_num);
mysql> select @c_num;
```

#### Example 7.5
Create a stored procedure named `do_query`. After inputting a specified student number, check the number of subjects in which the student's score is higher than 85. If it exceeds 2 subjects, output 'very good!' and display the student's transcript; otherwise, output 'come on!'.
```sql
mysql> delimiter //
mysql> create procedure do_query(in s_no char(11), out str char(12))
    -> begin
    -> declare AA tinyint default 0;
    -> select count(*) into AA from score
    -> where studentno = s_no and final > 85;
    -> if AA >= 2 then
    -> begin
    -> set str = 'very good! ';
    -> select * from score where studentno = s_no;
    -> end;
    -> elseif AA < 2 then
    -> set str = 'come on! ';
    -> end if;
    -> end //
mysql> delimiter ;
mysql> call do_query('20120210009', @str);
mysql> select @str;
mysql> call do_query('20125121109', @str);
mysql> select @str;
```

#### Example 7.6
Create a stored procedure to insert a row of records into the `score` table. Then create another stored procedure named `do_outer()` to call the stored procedure `do_insert()` and query and output the inserted records in the `score` table.
```sql
-- First, create the first stored procedure do_insert()
mysql> create procedure do_insert()
    -> insert into score values('21125221327', 'c05103', 89, 92);
Query OK, 0 rows affected (0.03 sec)
-- Create the second stored procedure do_outer() to call do_insert()
mysql> delimiter $$
mysql> create procedure do_outer()
    -> begin
    -> call do_insert();
    -> select * from score
    -> where studentno = '21125221327';
    -> end $$
mysql> delimiter ;
mysql> call do_outer();
```

#### Example 7.7
Define the error 'ERROR 1147 (42S07)' with the name `cannot_found`. There are two different ways to define it, as shown in the following code:
```sql
-- Define using the sqlstate_value method
declare cannot_found condition for sqlstate '42S07';
-- Define using the mysql_error_code method
declare cannot_found condition for 1147;
```

#### Example 7.8
Examples of defining conditions and handlers.
```sql
-- First, create the test table mtatest
mysql> create table mtatest(tf1 int, primary key(tf1));
mysql> delimiter //
mysql> create procedure handlermytest()
    -> begin
    -> declare continue handler for sqlstate '23000' set @x2 = 1;
    -> set @x = 1;
    -> insert into mtatest values(1);
    -> set @x = 2;
    -> insert into mtatest values(1);
    -> set @x = 3;
    -> Select @x, @x2;
    -> end;
    -> //
mysql> delimiter ;
mysql> call handlermytest();
```

#### Example 7.9
Modify the definition of the stored procedure `do_insert()`. Change the read - write permission to `modifies sql data` and specify that the caller can execute it.
```sql
mysql> alter procedure do_insert
    -> modifies sql data
    -> sql security invoker;
```

#### Example 7.10
Create a stored procedure to use a loop statement to control the `fetch` statement to retrieve available data from the cursor `tecursor`.
```sql
mysql> use teaching;
Database changed
mysql> delimiter //
mysql> create procedure proc_cursor()
    -> reads sql data
    -> begin
    -> declare v_tno varchar(6) default ' ';
    -> declare v_tname varchar(8) default ' ';
    -> declare teach_cursor cursor
    -> for select teacherno, tname from teacher;
    -> declare continue handler for not found set @dovar = 1; # Define the handler
    -> set @dovar = 0;
    -> open teach_cursor;
    -> fetch_loop: loop
    -> fetch teach_cursor into v_tno, v_tname;
    -> if @dovar = 1 then
    -> leave fetch_loop;
    -> else
    -> select v_tno, v_tname;
    -> end if;
    -> end loop fetch_loop;
    -> close teach_cursor;
    -> select @dovar;
    -> end ; //
mysql> delimiter ;
mysql> call proc_cursor();
```

#### Example 7.11
Create a trigger. When the course number of a certain course in the `course` table is changed, update all the course numbers in the `score` table at the same time.
```sql
mysql> use teaching;
Database changed
mysql> delimiter $$
mysql> create trigger cno_update after update
    -> on course for each row
    -> begin
    -> update score set courseno = new.courseno
    -> where courseno = old.courseno;
    -> end $$
mysql> delimiter ;
mysql> update course set courseno = 'c08123' where courseno = 'c07123';
mysql> select * from score where courseno = 'c08123';
```

#### Example 7.12
In the `teacher` table, define a trigger. When a teacher's information is deleted, add the teacher's number and name to the `de_teacher` table.
```sql
-- Create an empty table de_teacher, which consists of two columns: tno and tname.
mysql> create table de_teacher select teacherno, tname
    -> from teacher where 1 = 0;
-- Create a trigger for the teacher table
mysql> create trigger trig_teacher
    -> after delete on teacher for each row
    -> insert into de_teacher(teacherno, tname)
    -> values(old.teacherno, old.tname);
mysql> delete from teacher where tname = 'Shi Guan';
Query OK, 1 row affected (0.08 sec)
mysql> select * from de_teacher;
mysql> show triggers;
mysql> select * from information_schema.triggers;
mysql> select * from information_schema.triggers
    -> where trigger_name = 'de_teacher';
```

#### Example 7.13
Create a trigger. When a person's record in the `student` table is deleted, delete the corresponding score record in the `score` table.
```sql
mysql> delimiter $$
mysql> create trigger stu_delete after delete
    -> on student for each row
    -> begin
    -> delete from score where studentno = old.studentno;
    -> end $$
mysql> delimiter ;
mysql> delete from student where studentno = '21135222201';
mysql> select * from score where studentno = '21135222201';
Empty set (0.00 sec)
```

#### Example 7.14
Create two triggers, `before insert` and `after insert`, on the `de_teacher` table. Observe the triggering order of these two triggers when inserting data into the `department` table.
```sql
mysql> create table bef_after select teacherno, tname
    -> from teacher where 1 = 0;
mysql> alter table bef_after
    -> add tig_time timestamp not NULL default now();
mysql> create trigger before_insert before insert
    -> on de_teacher for each row
    -> insert into bef_after
    -> set teacherno = 't11111', tname = 'Fu Xiaolin';
mysql> create trigger after_insert after insert
    -> on de_teacher for each row
    -> insert into bef_after
    -> set teacherno = 't22222', tname = 'Qin Xiaolin';
mysql> insert into de_teacher values('t12345', 'Wang Fuchen');
mysql> select * from bef_after;
```

#### Example 7.15
Create an event named `direct1` to execute immediately and create a table named `test1`.
```sql
mysql> use mytest;
Database changed
mysql> create event direct1
    -> on schedule at now()
    -> do
    -> create table test1(timeline timestamp);
Query OK, 0 rows affected (0.00 sec)
mysql> show tables;
mysql> select * from test1;
```

#### Example 7.16
Create an event named `direct2` to execute immediately and create a table named `test2` after 5 seconds.
```sql
mysql> create event direct2
    -> on schedule at current_timestamp + interval 5 second
    -> do
    -> create table test2(timeline timestamp);
```

#### Example 7.17
Create an event named `test1_insert` to insert a record into the `test1` data table every second.
```sql
mysql> create event test1_insert
    -> on schedule every 1 second
    -> do
    -> insert into test1 values (current_timestamp);
mysql> select * from test1;       # Execute this statement after 5 seconds
```

#### Example 7.18
Create an event named `startweeks` to empty the `test1` table every week starting from next week and end at 12:00 on August 31, 2021.
```sql
mysql> delimiter $$
mysql> create event startweeks
    -> on schedule every 1 week
    -> starts curdate() + interval 1 week
    -> ends '2021-08-31 12:00:00'
    -> do
    -> begin
    -> truncate table test1;
    -> end $$
mysql> delimiter ;
```

#### Example 7.19
The stored procedure `proc_stu()` is used to query student information. Create an event named `stu_week` to check the student situation once a week.
```sql
mysql> delimiter $$
mysql> create event stu_week
    -> on schedule every 1 week
    -> do
    -> begin
    -> call teaching.proc_stu();
    -> end $$
mysql> delimiter ;
```

#### Example 7.20
Format and display all events.
```sql
mysql> show events\G
```

#### Example 7.21
Perform the following operations on the event `test1_insert`: temporarily disable the `test1_insert` event; enable the `test1_insert` event and change the frequency from inserting a record into the `test1` table every second to every minute; rename the event `test1_insert` and add a comment.
```sql
mysql> alter event test1_insert disable;
mysql> alter event test1_insert enable;
mysql> alter event test1_insert on schedule every 1 minute;
mysql> alter event test1_insert
    -> rename to insert_test1 comment 'Data operations on table test1';
```

Note: There was a typo in the original Chinese code where a semicolon was used instead of a Chinese semicolon in the last `alter event` statement. It has been corrected in the translated code. 