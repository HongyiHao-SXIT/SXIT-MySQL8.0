### Chapter 4 Data Retrieval
【Example 4.1】Query all the data in the `course` table of the `teaching` database.
```sql
mysql> use teaching;
Database changed
mysql> select * from course;
```
【Example 4.2】Query the `studentno`, `sname`, and `phone` data in the `student` table.
```sql
mysql> select studentno,sname,phone from student; 
```
【Example 4.3】Query the student ID, name, phone number, and age of students in the `student` table whose birth date is after 2002.
```sql
mysql> select studentno as 'Student ID', sname as 'Name', phone as 'Phone Number', year(now()) - year(birthdate) as 'Age'
-> from student
-> where year(birthdate) > 2002;
```
【Example 4.4】Query the student ID and course number of students in the `score` table whose final grades are higher than 95, and sort the results by student ID.
```sql
mysql> select distinct studentno,courseno
-> from score
-> where final > 95
-> order by studentno;
```
【Example 4.5】Query the student ID, name, and phone number information of students in the `student` table whose entrance scores are above 800.
```sql
mysql> select studentno,sname,phone
-> from student
-> where entrance > 800;
```
【Example 4.6】Query the student ID, course number, daily grade, and final grade of students with student IDs 20123567897, 21135222201, and 20120203567.
```sql
mysql> select studentno,courseno,daily,final
-> from score
-> where studentno in ('20123567897','21135222201','20120203567');
```
【Example 4.7】Query the student ID and final grade of students who have selected course number `c05109`, and require that the daily grade is between 80 and 95.
```sql
mysql> select studentno, final
-> from score
-> where courseno = 'c05109' and daily between 80 and 95;
```
【Example 4.8】Display the names, birth dates, and email addresses of all students in the `student` table whose surnames are "He" or "Han".
```sql
mysql> select sname, birthdate, Email
-> from student
-> where sname like 'He%' or sname like 'Han%';
```
【Example 4.9】Add a `score` field to the `se_score` table and query the student ID, course number, and score of students in the `se_score` table.
```sql
mysql> alter table se_course
-> add score float(3,1) null after teacherno;
mysql> select studentno, courseno,teacherno, score
-> from se_course
-> where score is null;
```
【Example 4.10】Display the student ID, course number, and grades of students in the `score` table whose mid - term grades are higher than 90 and final grades are higher than 85.
```sql
mysql> select studentno,courseno,daily,final
-> from score
-> where daily >= 90 and final >= 85;
```
【Example 4.11】Query the teacher ID, name, and major of teachers with senior titles in the Computer Science College.
```sql
mysql> select teacherno,tname, major
-> from teacher
-> where department = 'Computer Science College' and (prof = 'Associate Professor' or prof = 'Professor');
```
【Example 4.13】Query the student ID, name, and entrance score of students in the `student` table whose entrance scores are higher than 850, and sort the results in descending order of entrance scores.
```sql
mysql> select studentno as 'Student ID', sname as 'Name', entrance as 'Entrance Score'
-> from student
-> where entrance > 850
-> order by entrance desc;
```
【Example 4.14】Query the student ID, course number, and overall grade of students in the `score` table whose overall grades are greater than 90. Sort the results in ascending order of course numbers first, and then in descending order of overall grades. The formula for calculating the overall grade is as follows: Overall grade = daily * 0.2 + final * 0.8
```sql
mysql> select courseno as 'Course Number', daily * 0.2 + final * 0.8 as 'Overall Grade', studentno as 'Student ID'
-> from score
-> where daily * 0.2 + final * 0.8 > 90
-> order by courseno, daily * 0.2 + final * 0.8 desc;
```
【Example 4.15】Use the `group by` clause to group the data in the `score` table and display the student ID and average overall grade of each student. The formula for calculating the overall grade is as follows: Overall grade = daily * 0.3 + final * 0.7
```sql
mysql> select studentno as 'Student ID', round(avg(daily * 0.3 + final * 0.7), 2) as 'Average Grade'
-> from score
-> group by studentno;
```
【Example 4.16】Use the `group by` keyword and the `group_concat()` function to perform a grouped query on the `studentno` field in the `score` table. You can view the student IDs of students who have selected this course.
```sql
mysql> select courseno as 'Course Number', group_concat(studentno) as 'Student IDs of Enrolled Students'
-> from score
-> group by courseno;
```
【Example 4.17】Query the student ID and total score of students who have selected more than 3 courses and whose final grades in each course are higher than 75. List the query results in descending order of total scores.
```sql
mysql> select studentno as 'Student ID', sum(daily * 0.3 + final * 0.7) as 'Total Score'
-> from score
-> where final >= 75
-> group by studentno
-> having count(*) >= 3
-> order by sum(daily * 0.3 + final * 0.7) desc;
```
【Example 4.18】Query the average final grade of each course and the average of all grades in the `score` table.
```sql
mysql> select courseno as 'Course Number', avg(final) as 'Average Final Grade of the Course'
-> from score
-> group by courseno with rollup;
```
【Example 4.19】Query the student ID, name, birth date, and phone number of the `student` table. Sort the results in descending order of `entrance` and display the first 3 records.
```sql
mysql> select studentno,sname,birthdate,phone
-> from student
-> order by entrance desc
-> limit 3;
```
【Example 4.20】Query the records in the `score` table where the final grade `final` is higher than 85. Sort the results in ascending order of the daily grade `daily` and start from record number 2, query 5 records.
```sql
mysql> select * from score
-> where final > 85
-> order by daily asc
-> limit 2, 5;
```
【Example 4.21】Find the total number of students in the 20th grade through query.
```sql
mysql> select count(studentno) as 'Number of Students in Grade 20'
-> from student
-> where substring(studentno, 1, 2) = '20';
```
【Example 4.22】Query the student ID, total final score, and average final score of students in the `score` table whose total final scores are greater than 270.
```sql
mysql> select studentno as 'Student ID', sum(final) as 'Total Score', avg(final) as 'Average Score'
-> from score
-> group by studentno
-> having sum(final) > 270
-> order by studentno;
```
【Example 4.23】Query the highest final score, lowest final score, and the difference between them for students who have selected course number `c05109`.
```sql
mysql> select max(final) as 'Highest Score', min(final) as 'Lowest Score', max(final) - min(final) as 'Score Difference'
-> from score
-> where (courseno = 'c05109');
```
【Example 4.24】In the `score` table, use the `rank()` function to output the row sequence numbers of records sorted by `final`.
```sql
mysql> select *, rank() over w as ’rank’ from score
-> window w as (order by final);
```
【Example 4.25】In the `score` table, use the window function to output the total final score of each student.
```sql
mysql> select studentno, courseno, final, sum(final) 
-> over (partition by studentno) as total_score
-> from score;
```
【Example 4.26】In the `score` table, use the window function to output the proportion of each student's final grade `final` in their total final score.
```sql
mysql> select *, (final)/(sum(final) over()) as rate from score;
```
【Example 4.27】In the `score` table, use the window function `lag()` to output the student IDs of the previous 3 rows of each row of data.
```sql
mysql> select *, lag(studentno, 3) over ww2 as lag3 from score
-> window ww2 as (order by studentno);
```
【Example 4.28】Query the student ID, name, and final grade of students who have selected course number `c05109`.
```sql
mysql> select student.studentno,sname,final
-> from student inner join score
-> on student.studentno = score.studentno
-> where score.courseno = 'c05109';
```
There is another method, and the code is as follows:
```sql
mysql> select student.studentno,sname,final 
-> from student,score 
-> where student.studentno = score.studentno 
-> and score.courseno = 'c05109';
```
【Example 4.29】Delete the `imgs` column in the `student01` table, insert appropriate data, and use the left outer join method to query the student ID, name, daily grade, and final grade of students.
```sql
mysql> select * from student01;
mysql> select student01.studentno,sname,daily,final
-> from student01 left join score
-> on student01.studentno = score.studentno;
```
【Example 4.30】Use the right outer join method to query the course scheduling situation of teachers.
```sql
mysql> select teacher.teacherno,tname, major, courseno
-> from teacher right join teach_course
-> on teacher.teacherno = teach_course.teacherno;
```
【Example 4.31】Display the Cartesian product of the `student` table and the `score` table.
```sql
mysql> select student.studentno,sname,score.*
-> from student cross join score;
```
【Example 4.32】Query the student ID, name, course name, final grade, and credits of students in the 20th grade.
```sql
mysql> select student.studentno,sname,cname,final,round(period/16, 1)
-> from score join student on student.studentno = score.studentno
-> join course on score.courseno = course.courseno
-> where substring(student.studentno, 1, 2) = '20';
```
【Example 4.33】Create `student01` using the `student` table, and combine the partial query result sets of the `student01` table and the `student` table.
```sql
mysql> create table student01 as 
-> select studentno,sname,phone from teaching.student;
mysql> select studentno,sname,phone from student01 
-> where phone like '%131%'
-> union
-> select studentno,sname,phone from teaching.student 
-> where phone like '%132%';
```
【Example 4.34】Query the entrance score of the student with student ID 20125121109, the average entrance score of all students, and the difference between the score of this student and the average entrance score of all students.
```sql
mysql> select studentno,sname,entrance,
-> (select avg(entrance) from student ) as 'Average Score',
-> entrance - (select avg(entrance) from student ) as 'Score Difference'
-> from student
-> where studentno = '20125121109'; 
```
【Example 4.35】Query the student ID, course number, and overall grade of students whose final grades are higher than 85 and overall grades are higher than 90.
```sql
mysql> select TT.studentno as 'Student ID', TT.courseno as 'Course Number',
-> TT.final*0.8 + TT.daily*0.2 as 'Overall Grade'
-> from (select * from score where final > 85) as TT
-> where TT.final*0.8 + TT.daily*0.2 > 90;
```
【Example 4.36】Query the student ID, course number, and final grade of students whose final grades are lower than the average final grade of the courses they have selected.
```sql
mysql> select studentno,courseno,final
-> from score as a
-> where final < (select avg(final)
-> from score as b
-> where a.courseno = b.courseno
-> group by courseno );
```
【Example 4.37】Obtain the student ID, name, phone number, and email of students whose final grades contain scores higher than 93.
```sql
mysql> select studentno,sname,phone,Email
-> from student
-> where studentno in ( select studentno
-> from score
-> where final > 93);
```
【Example 4.38】Query whether there are students in the `student` table who were born after December 12, 2003. If so, output the student ID, name, birth date, and phone number of the students.
```sql
mysql> select studentno,sname,birthdate,phone
-> from student
-> where exists (
-> select *
-> from student
-> where birthdate > '2003-12-12');
```
【Example 4.39】Find the student ID, name, phone number, and final grade in the `score` table that are all higher than the final grade of course `c05109`.
```sql
mysql> select student.studentno,sname, phone,final
-> from score inner join student
-> on score.studentno = student.studentno
-> where final > all
-> (select final from score where courseno = 'c05109');
```
【Example 4.40】Add the records of students born after 2003 in the `student` table to the `student01` table.
```sql
mysql> insert into student01
-> (select * from student
-> where birthdate > '2003-12-31');
```
【Example 4.41】Increase the final grades of all students in the `student` table whose entrance scores are lower than 700 by 3%.
```sql
mysql> update score
-> set final = final*1.03
-> where studentno in
-> (select studentno
-> from student
-> where entrance < 700);
Query OK, 6 rows affected (0.71 sec)
Rows matched: 6  Changed: 6  Warnings: 0
```
【Example 4.42】Define a common table expression `cte95` to obtain the student ID, name, phone number, email, and daily grade of students whose entrance scores are higher than 800 and whose final grades contain scores higher than 95.
```sql
mysql> with cte95
-> as (select * from score where final > 95)
-> select student.studentno,sname,phone,Email,cte95.daily
-> from student join cte95 
-> on student.studentno = cte95.studentno
-> where student.entrance > 800;
```
【Example 4.43】The Fibonacci series starts with the numbers 0 and 1, and each subsequent number is the sum of the two preceding numbers. If each row in the recursive `select` sums based on the values of the two preceding series numbers, a Fibonacci series can be generated.
```sql
mysql> with recursive fibnaci(n, fib_n, next_fib_n) as
-> ( select 1, 0, 1
-> union
-> select n + 1, next_fib_n, fib_n + next_fib_n
-> from fibnaci
-> where n < 12 )
-> select * from fibnaci;
```
【Example 4.44】Query partial information of students whose surname is "Zhao" in the `student` table.
```sql
mysql> select studentno,sname,birthdate, phone 
->  from student
->  where sname  regexp '^Zhao';
```
【Example 4.45】Query partial information of students in the `student` table whose phone numbers end with 5.
```sql
mysql> select  studentno, sname, phone, Email
-> from student
-> where phone regexp '5$';
```
【Example 4.46】To query the information of students whose name in the `sname` field starts with "Zhao", ends with "Jiang", and contains 1 character in the middle, it can be achieved through a regular expression query. In the regular expression, '^' represents the start position of the string, '$' represents the end position of the string, and '.' represents any single character except '\n' (in this example, Chinese characters are counted as 1 character).
```sql
mysql> select studentno, sname, phone 
-> from student 
-> where  sname regexp '^Zhao.Jiang$';
```
【Example 4.47】Query the information of students whose phone numbers contain the numbers 131 or 132.
```sql
mysql> select  studentno, sname, phone, Email
->  from student
->  where phone regexp '131|132';
``` 