### Chapter 11 Performance Optimization of MySQL 8.0

#### Example 11.1
Use the `explain` statement to analyze a query statement.
```sql
mysql> use teaching;
Database changed
mysql> explain  select *  from  course ;
```

#### Example 11.2
Use the `describe` command to analyze the query statement.
```sql
mysql> describe select * from student; 
```

#### Example 11.3
Analyze the impact of indexes on the query speed, and check the query situation when no index is used.
```sql
mysql> explain select * from student  where  sname= 'Cui Yige'; 
```

#### Example 11.4
Use the `explain` statement to execute the query command, apply the `like` keyword, and the matching string contains the percent sign “%”.
```sql
mysql> explain select * from student  where  sname  like 'Zhao%'\G
mysql> explain select * from student where sname like '%Jiang'\G
```

#### Example 11.5
Use `explain` to analyze the query index command using the `or` keyword.
```sql
mysql> explain  select * from student where sname='Zhao%' or phone='132%'\G
mysql> explain  select * from student where sname='Zhao%' or sex='Male'\G
```

#### Example 11.6
Use `explain` to analyze the command applying the multi-column index. There is an index `studentno + courseno` in the `score` table, and use these two fields for query analysis respectively.
```sql
mysql> explain  select * from score where studentno='21%'\G
```

#### Example 11.7
An index `idx_birth` has been created on the `birthdate` field of the `student` table. Compare the results of the following two queries.
```sql
mysql> create index idx_birth on student(birthdate);
mysql> explain select sname from student where year(birthdate)> '2003'\G
mysql> explain select sname from student where birthdate>'2003-12-31'\G
```

#### Example 11.8
Use an example to illustrate how to optimize multi-table queries, and view the query analysis parameters of the subquery method and the table join method. First, execute the following two query statements, and then perform query analysis.
```sql
mysql> select sname ,phone  from student where studentno  
mysql> select sname,phone from student,score
    -> where student.studentno =score.studentno and final>98 \G

-- Subquery method analysis
mysql> explain select sname ,phone  from student where studentno
    -> in (select studentno from score  where final>98)\G

-- Table join method analysis
mysql> explain select sname,phone from student,score
    -> where student.studentno =score.studentno and final>98 \G
```

#### Example 11.9
Analyze the running situation of the `teacher` table. First, use the `show index` statement to view the degree of index dispersion, and then use `analyze table` for repair.
```sql
mysql> show index from teacher\G;
mysql>  analyze table teacher ;
```

#### Example 11.10
Execute the following statements and view the standard results of the system setting for slow queries. `long_query_time` is used to define how many seconds a query is considered a "slow query", and the system default is 10 seconds.
```sql
mysql> show variables like 'long%';
mysql> show variables like 'slow%';
```

#### Example 11.11
Treat queries with a query time exceeding 1 second as slow queries.
```sql
mysql> set long_query_time=1;
mysql> show variables like 'long%';
```

#### Example 11.12
Use the structures of the `student`, `course`, and `score` tables to create an intermediate table `stu_score`, which contains the student number, name, course name, and score information that are often queried in practice.
```sql
-- View the structures of the student, course, and score tables
mysql> describe  student;
mysql> desc course;
mysql> desc  score;

-- Create the intermediate table stu_score
mysql> create table stu_score as
    -> select student.studentno,sname,cname,daily, final
    -> from student, course ,score
    -> where student.studentno =score.studentno
    ->    and score.courseno= course.courseno;
Query OK, 33 rows affected, 2 warnings (1.45 sec)
Records: 33  Duplicates: 0  Warnings: 2
```

#### Example 11.13
Count the average score of the comprehensive evaluation of each course, and directly query using `stu_score`.
```sql
mysql> select cname, avg(daily*0.2+ final*0.8) avg  
    -> from stu_score group by cname;
```

#### Example 11.14
In the `mytest` database, create a `range` partitioned table `part_entrance_student` to store data with different entrance scores in different partitioned tables.
```sql
mysql> create table part_entrance_student
    -> (studentno  char(11)  not null,
    ->  sname        char(8)  not null,
    ->  sex          char(2)  not null,
    ->  birthdate   date      not null,
    ->  entrance    int       not null,
    ->  phone    varchar(12) not null,
    ->  Email   varchar(20)  not null)
    -> partition by range(entrance)
    -> (
    -> partition pr0 values less than (600),
    -> partition pr1 values less than (700),
    -> partition pr2 values less than (800),
    -> partition pr3 values less than maxvalue
    -> );
```

#### Example 11.15
In the `mytest` database, create a `list columns` partitioned table `part_courseno_score` to store the scores of different courses in different partition files.
```sql
mysql> create table part_courseno_score
    -> (
    ->  studentno  char(11)    not null,
    ->  courseno   char(6)     not null,
    ->  daily      float(3,1)  not null,
    ->  final      float(3,1)  not null
    ->  )
    -> partition by list columns(courseno)
    -> (
    -> partition pl0 values in ('c05103'),
    -> partition pl1 values in ('c05109'),
    -> partition pl2 values in ('c08171'),
    -> partition pl3 values in ('c06108'),
    -> partition pl4 values in ('c06127'),
    -> partition pl5 values in ('c08106')
    -> );
```

#### Example 11.16
In the `mytest` database, create a `hash` partitioned table `hash_entrance_student` to store the information of students with different entrance scores in different partition files.
```sql
mysql> create table hash_entrance_student
    -> (studentno  char(11)  not null,
    -> sname        char(8)  not null,
    -> sex          char(2)  not null,
    -> birthdate   date      not null,
    -> entrance    int       not null,
    -> phone    varchar(12) not null,
    -> Email   varchar(20)  not null)
    -> partition by hash(entrance)
    -> partitions 3 ;
```

#### Example 11.17
Insert data into the partitioned table `part_courseno_score` in the `mytest` database, and then view and analyze the data distribution of the partitioned table.
```sql
-- Insert data into the partitioned table part_courseno_score
mysql> insert into part_courseno_score values
    -> ('20112100072', 'c05103',     99.0 ,  92.0),
    -> ('20112100072', 'c05109',     95.0 ,  82.0),
    -> ('20112100072', 'c08171',     82.0 ,  69.0),
    -> ('20112111208', 'c06108',     77.0 ,  82.0),
    -> ('20112111208', 'c06127',     85.0 ,  91.0),
    -> ('20112111208', 'c08171',     89.0 ,  95.0),
    -> ('20120203567', 'c05103',     78.0 ,  67.0),
    -> ('20120203567', 'c05109',     87.0 ,  86.0),
    -> ('20120203567', 'c06127',     97.0 ,  97.0),
    -> ('20120210009', 'c05103',     65.0 ,  98.0),
    -> ('20120210009', 'c05109',     88.0 ,  89.0),
    -> ('20120210009', 'c06108',     79.0 ,  88.0),
    -> ('20123567897', 'c06108',     99.0 ,  99.0),
    -> ('20125121109', 'c05103',     88.0 ,  79.0),
    -> ('20125121109', 'c05109',     77.0 ,  82.0),
    -> ('20125121109', 'c08171',     85.0 ,  91.0),
    -> ('20126113307', 'c05109',     89.0 ,  95.0),
    -> ('20126113307', 'c06108',     78.0 ,  67.0),
    -> ('21125111109', 'c05103',     96.0 ,  97.0),
    -> ('21125111109', 'c05109',     87.0 ,  82.0),
    -> ('21125111109', 'c06127',     77.0 ,  91.0),
    -> ('21125221327', 'c05109',     89.0 ,  95.0),
    -> ('21125221327', 'c06108',     88.0 ,  62.0),
    -> ('21131133071', 'c06108',     78.0 ,  95.0),
    -> ('21131133071', 'c08171',     88.0 ,  98.0),
    -> ('21135222201', 'c06127',     91.0 ,  77.0),
    -> ('21135222201', 'c08171',     85.0 ,  92.0),
    -> ('21137221508', 'c05103',     77.0 ,  92.0),
    -> ('21137221508', 'c06127',     89.0 ,  62.0);

-- View the partition situation of the data table
mysql> select  partition_name ,partition_description,table_rows
    -> from  information_schema.partitions
    -> where table_name= 'part_courseno_score' ;

-- Analyze the data situation of the partitioned table using explain
mysql> explain select  * from part_courseno_score partition(pl1)\G
mysql> explain select  * from part_courseno_score partition(pl4)\G
```

#### Example 11.18
Add partitions to and delete partitions from the partitioned table `hash_entrance_student` in the `mytest` database, and then view the data distribution.
```sql
-- Add a partition to the partitioned table hash_entrance_student
mysql> alter table hash_entrance_student add partition partitions 1;

-- Add 2 partitions to the partitioned table part_courseno_score
mysql> alter table part_courseno_score  add  partition (
    -> partition new1 values in ('c05123'),
    -> partition new2 values in ('c08123')
    -> );

-- Delete a partition of part_courseno_score
mysql> alter table part_courseno_score drop  partition  new2;
```

#### Example 11.19
Create the table `student1` in the `mytest` database, create the table structure using the `student` table in the `teaching` database, add data in batches multiple times, then delete most of the data, and view the file size.
```sql
mysql> use mytest;
Database changed
mysql> create table  student1 as
    -> select  *  from  teaching.student;

-- Add test data through data replication
mysql> insert  into  student1 
    -> (select * from student1);

-- Add test data through data replication multiple times
mysql> insert  into  student1
    -> ( select  *  from  student1);
mysql> insert  into  student1
    ->  (select * from  student1);
mysql> insert  into  student1
    -> (select * from student1);
Query OK, 12288 rows affected (1.17 sec)
Records: 12288  Duplicates: 0  Warnings: 0

-- Before deleting the data, open the database data directory and check the size of student1 after adding the data. It is found that student1.ibd is approximately 10.0 MB (10,485,760 bytes). Execute the following command to delete the data of students in the class of 20 respectively.
mysql> delete from student1 
    -> where left(studentno,2)= '20';

-- After deleting the data using the delete command, check the size of the data storage file student1.ibd. It can be found that after deleting the data, checking the size of the data file of the student1 table again has not changed.
-- Use the optimize command to sort out the data and check the size of the data storage file
mysql> optimize table student1 \G
``` 