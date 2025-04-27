### Chapter 3 Basic Operations of MySQL 8.0 Databases and Tables
【Example 3.1】Use the `show databases` statement to view all databases in the MySQL server.
```sql
mysql> show databases;
```
【Example 3.2】Create a database named `mysqltest` through the `create database` statement.
```sql
mysql> create database if not exists mysqltest;
```
【Example 3.3】Create the teaching management database `teaching`, and specify the character set as `utf8mb4` and the collation principle as `utf8mb4_0900_ai_ci`.
```sql
mysql> create database teaching
-> default character set utf8mb4
-> default collate utf8mb4_0900_ai_ci;
```
【Example 3.4】Modify the character set of the `mysqltest` database to `gb2312` and the collation principle to `gb2312_chinese_ci`.
```sql
mysql> alter database mysqltest
-> default character set gb2312
-> collate gb2312_chinese_ci;
```
【Example 3.5】Display the structural information of the `teaching` database.
```sql
mysql> show create database teaching;
```
【Example 3.6】Create the `student` table according to the structure of the student information table shown in Table 3 - 3.
```sql
mysql> create table if not exists student 
(
studentno  char(11) not null comment 'Student ID', 
sname char(8) not null comment 'Name', 
sex enum('male', 'female') default'male' comment 'Gender', 
birthdate date not null comment 'Date of Birth', 
entrance int(3)  null comment 'Entrance Score',		 
phone varchar(12) not null comment 'Phone Number', 
Email varchar(20) not null comment 'Email Address',
primary key (studentno)
);
```
【Example 3.7】Use the `create table` command to establish the course information table `course`.
```sql
mysql> create table if not exists course 
(
courseno  char(6) not null, 
cname  char(6) not null, 
type char(8) not null,  
period int(2) not null, 
exp int(2) not null,
term int(2) not null,
primary key (courseno)
); 		
```
【Example 3.8】Use the `create table` command to establish the student score table `score`. The primary key of this table consists of two columns. The program code for creating the student score table `score` in the `teaching` database using the `create table` statement is as follows:
```sql
mysql> create table if not exists score
(studentno  char(11) not null, 
courseno  char(6) not null, 
daily float(4,1) default 0, 
final float(4,1) default 0,
primary key (studentno , courseno) 
); 
```
【Example 3.9】Use the `create table` command to establish the teacher information table `teacher`.
```sql
mysql> create table if not exists teacher 
(teacherno  char(6) not null comment 'Teacher ID', 
tname  char(8) not null comment 'Teacher Name', 
major  char(10) not null comment 'Major', 
prof char(10) not null comment 'Professional Title',
department char(16) not null comment 'Department',
primary key (teacherno)
); 
```
【Example 3.10】To improve the relationships between tables in the `teaching` database, create the linking table `teach_course` with the table structure shown in Table 3 - 7.
```sql
mysql> create table if not exists teach_course 
(teacherno char(6) not null, 
courseno  char(6) not null, 
primary key (teacherno,courseno) 
);
```
【Example 3.11】In the `teaching` database, create the course selection table `sc`. The course selection number `sc_no` is auto - incremented, the course selection time is defaulted to the current time, and the other fields are student ID, course number, and teacher ID respectively.
```sql
mysql>create table sc
(sc_no int(6) not null auto_increment, 
studentno  char(11) not null, 
courseno  char(6) not null, 
teacherno char(6) not null,  
score float(4,1) null,
sc_time timestamp not null default now(), 
primary key (sc_no)
);
```
(1) Command to view the created tables:
```sql
mysql>show tables;
```
(2) Statement `describe` to view the basic structure of a table.
```sql
mysql> describe student;
```
(3) Statement `show create table` to view the detailed structure of a table.
```sql
mysql> show create table course;
```
【Example 3.12】Add a column `address` after the `Email` column in the `student` table.
```sql
mysql>alter table student 
->add address varchar(30) not null after Email;
```
【Example 3.13】Rename the table `sc` to `se_course`.
```sql
mysql> alter table sc rename to se_course;
```
【Example 3.14】Modify the `type` field of the `course` table. Since this field generally takes fixed values, its definition can also be written as: `type enum ('Required', 'Elective') default 'Required'`.
```sql
mysql> alter  table course  
-> modify type enum('Required','Elective') default 'Required';
```
【Example 3.15】Delete the `address` field from the `student` table.
```sql
mysql> alter table student  drop address; 
```
【Example 3.16】Create the table `example` in the `mytest` database, and then delete the `example` table.
```sql
mysql> use mytest;
mysql> Create  table  example(
-> today datetime,
-> name char(20)
-> );
mysql> desc example;
mysql> drop  table  example ;
```
【Example 3.17】Use `insert` to insert 1 row of data into the `student` table.
```sql
mysql> insert into student
-> (studentno,sname,sex,birthdate,entrance,phone,Email)
->  values ('20112100072','Xu Dongfang','male','2002/2/4',658,
-> '12545678998','su12@163.com' );
```
【Example 3.18】Use the `insert into` command to insert multiple rows of data into the `student` table.
```sql
mysql> insert into student values
-> ('20112111208','Han Yinqiu','female','2002/2/14',666,
-> '15878945612','han@163.com'),
-> ('20120203567','Feng Baimei','female','2003/9/9', 898,
-> '13245674564','feng@126.com'),
-> ('20120210009','Cui Zhoufan','male','2002/11/5',789,
-> '13623456778','cui@163.com'),
-> ('20123567897','Zhao Yusi','female','2003/8/4', 879,
-> '13175689345','pingan@163.com'),
-> ('20125121109','Liang Yiwei','female','2002/9/3', 777,
-> '13145678921','bing@126.com'),
-> ('20126113307','Yao Fumei','female','2003/9/7', 787,
-> '13245678543','zhu@163.com'),
-> ('21125111109','Jing Bingchen','male','2004/3/1', 789,
-> '15678945623','jing@sina.com'),
-> ('21125221327','He Tongying','female','2004/12/4',879,
-> '13178978999','he@sina.com'),
-> ('21131133071','Cui Yige','male','2002/6/6', 787,
-> '15556845645','cui@126.com'),
-> ('21135222201','Xia Wenfei','female','2005/10/6',867,
-> '15978945645','xia@163.com'),
-> ('21137221508','Zhao Linjiang','male','2005/2/13',789,
-> '12367823453','ping@163.com');
```
【Example 3.19】Use the `insert into` command to insert multiple rows of data into the `teacher` table.
```sql
mysql> insert into teacher values
-> ('t05001', 'Su Chaoran', 'Software Engineering', 'Professor', 'Computer Science College'),
-> ('t05002', 'Chang Keguan', 'Accounting',   'Assistant',  'Management College'),
-> ('t05003', 'Sun Shian', 'Network Security', 'Professor',  'Computer Science College'),
-> ('t05011', 'Lu Aozhi', 'Software Engineering', 'Associate Professor','Computer Science College'),
-> ('t05017', 'Mao Jiafeng', 'Software Testing', 'Lecturer',  'Computer Science College'),
-> ('t06011', 'Xia Qinian', 'Mechanical Manufacturing', 'Professor',  'Mechanical College'),
-> ('t06023', 'Lu Shizhou', 'Casting Technology', 'Associate Professor','Mechanical College'),
-> ('t07019', 'Han Tingyu', 'Economic Management', 'Lecturer',  'Management College'),
-> ('t08017', 'Bai Chengyuan', 'Financial Management', 'Associate Professor','Management College'),
-> ('t08058', 'Sun Youcun', 'Data Science', 'Associate Professor','Computer Science College');
mysql> select *  from teacher;    
```
【Example 3.20】Use the `replace into` command to insert multiple rows of data into the `course` table.
```sql
mysql> replace into course values
('c05103','Electronic Technology','Required','64','16','2'),
('c05109','C Language','Required','48','16','2'),
('c05127','Data Structure','Required','64','16','2'),
('c05138','Software Engineering','Elective','48','8','5'),
('c06108','Mechanical Drawing','Required','60','8','2'),
('c06127','Mechanical Design','Required','64','8','3'),
('c06172','Casting Process','Elective','42', '16','6'),
('c08106','Economic Law','Required','48','0','7'),
('c08123','Finance','Required','40','0','5'),
('c08171','Accounting Software','Elective','32','8','8');
```
For example, when inserting a record with the existing student ID `20123567897`, the result is as follows.
```sql
mysql> insert into student values('20123567897','Han Xiaoyu',
-> 'female','2001/2/14','666','15878945612','han@163.com ');
ERROR 1062 (23000): Duplicate entry '20123567897' for key'student.PRIMARY'
```
【Example 3.21】Use the `load data` statement to input data into the `score` table.
```sql
mysql>load data local infile "d:\\score.txt" into table score;　　　
mysql> select *  from score;
```
【Example 3.22】Use the `load data` statement to input data into the `teach_course` table.
```sql
mysql> load data local infile "d:\\teach_course.txt" into table teach_course;
mysql> select *  from  teach_course;
```
【Example 3.23】Use the `set` clause to insert data into the `se_course` table.
```sql
mysql> insert into se_course 
set studentno='21125111109',courseno='c06172',teacherno='t05017';　　　　
mysql> select *   from  se_course;
```
【Example 3.24】Create the `student01` table referring to the structure of the `student` table, add a field that can store pictures, and then insert a row of data. The photo path is "d: \image\ picture.jpg".
```sql
mysql> create  table  student01 as select *  from student where 0;
mysql> select *  from student01;
mysql> alter table  student01 add imgs mediumblob comment'Photo';
mysql> insert into student01  values
-> ('22122221329','He Yingying','female','2003/12/9','877',
-> '13178978997', 'heyy1@sina.com ', 'd:\\image\\picture.jpg');
```
【Example 3.25】Modify the daily score of the student with the student ID `20112111208` in the course `c06108` to 87 points.
```sql
mysql> select *  from   score   
-> where studentno='20112111208' && courseno='c06108';
mysql> update score set daily=87
-> where studentno='20112111208' && courseno='c06108';
mysql> select *  from   score
-> where studentno='20112111208' && courseno='c06108';
```
【Example 3.26】Increase the entrance scores higher than 700 in the `student01` table by 5%.
```sql
mysql> update student01 set entrance=entrance*1.05 where entrance>700;
```
【Example 3.27】Delete the records in the `student01` table where the entrance score is lower than 750.
```sql
mysql> delete  from student01 where entrance <750;
```
【Example 3.28】Delete the 2 rows of records with the lowest entrance scores in the `student01` table.
```sql
mysql> delete  from student01 order by entrance limit 2; 
```
【Example 3.29】In the `mytest` database, create the table `course01` referring to the structure of the `course` table, and set the primary key using column integrity constraints.
```sql
mysql> create table if not exists course01 
(
courseno  char(6) not null primary key, 
cname  char(6) not null, 
type char(8) not null,  
period int(2) not null, 
exp int(2) not null,
term int(2) not null
); 		
```
【Example 3.30】In the `mytest` database, create the table `student02` referring to the `student` table, delete the original primary key `sname`, and add `studentno` as the primary key.
```sql
mysql> create table student02  as select * from teaching.student where 0;
mysql> alter table student02  add primary key (sname);
mysql> alter table  student02 drop primary key;
mysql>  alter table  student02  add primary key (studentno);
```
【Example 3.31】In the `teaching` database, use the `alter table` statement to add foreign key constraints to the `score` table.
```sql
mysql> use teaching;
Database changed
mysql> alter table score
-> add constraint fk_st_score
-> foreign key(studentno) references student(studentno);
mysql> alter table score
-> add constraint fk_cou_score
-> foreign key(courseno) references course(courseno);
```
【Example 3.32】In the