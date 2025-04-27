### Chapter 5 Indexes and Views

#### [Example 5.1]
To facilitate queries by phone number, create an ascending normal index named `phone_index` on the `phone` column of the `student` table.
```sql
mysql> use teaching;
Database changed
mysql> create index phone_index on student(phone asc);
```

#### [Example 5.2]
Create a unique index named `cname_index` on the `cname` column of the `course` table.
```sql
mysql> create unique index cname_index on course (cname);
```

#### [Example 5.3]
Create a composite index named `sc_index` on the `studentno` and `courseno` columns of the `score` table.
```sql
mysql> create index sc_index on score(studentno,courseno);
```

#### [Example 5.4]
Create a unique index named `tname_index` and a prefix index named `dep_index` on the `tname` field of the `teacher1` table.
```sql
mysql> use mytest;
Database changed
mysql> create table if not exists teacher1 (
    -> teacherno char(6) not null comment 'Teacher ID',
    -> tname char(8) not null comment 'Teacher Name',
    -> major char(10) not null comment 'Major',
    -> prof char(10) not null comment 'Title',
    -> department char(16) not null comment 'Department',
    -> primary key (teacherno),
    -> unique index tname_index(tname),
    -> index dep_index(department(5))
    -> );
```

#### [Example 5.5]
Create a primary key index on the `teacherno` column of the `teacher1` table (assuming the primary key index has not been created), and create a composite index on `tname` and `prof`.
```sql
mysql> alter table teacher1
    -> add primary key(teacherno),
    -> add index mark(tname, prof);
```

#### [Example 5.6]
Create a simple view named `teach_view1` on the `teacher` table.
```sql
mysql> create view teach_view1
    -> as select * from teacher;
mysql> select * from teach_view1;
```

#### [Example 5.7]
Create a view named `stu_score1` on the `student`, `course`, and `score` tables. The view retains the student ID, name, phone number, course name, and final grade of female students in the class of 2020.
```sql
mysql> create view stu_score1
    -> as select student.studentno, sname, phone, cname,final
    -> from score join student on student.studentno=score.studentno
    -> join course on course.courseno=score.courseno
    -> where sex='Female' and left(student.studentno,2)= '20';
mysql> select * from stu_score1;
```

#### [Example 5.8]
Create a view named `teach_view2` to count the teacher ID, teacher name, and major of professors and associate professors in the School of Computer Science.
```sql
mysql> create view teach_view2
    -> as select teacherno, tname, major
    -> from teach_view1
    -> where prof like '%Professor' and department='School of Computer Science';
mysql> select * from teach_view2;
```

#### [Example 5.9]
Modify the view `teach_view2` to count the teacher ID, teacher name, and major of professors and associate professors in the School of Computer Science and the School of Materials Science. Also, specify the view column names after the view name.
```sql
mysql> alter view teach_view2(Teacher ID, Teacher Name, Major)
    -> as select teacherno, tname, major
    -> from teach_view1
    -> where prof like '%Professor'
    -> and (department='School of Computer Science' or department='School of Materials Science');
mysql> select * from teach_view2;
```

#### [Example 5.10]
Through the view `stu_view2`, query the student ID, course ID, and grade of male students in the class of 2020 who have selected course `c05103` and have a grade of over 80.
```sql
mysql> select Student ID, Name, Course ID, Grade
    -> from stu_view2
    -> where Course ID='c05103' and Grade > 80;
```

#### [Example 5.11]
Create a view named `course_avg` to calculate the average grade of each course and sort the results in ascending order of the course name.
```sql
mysql> create view course_avg
    -> as select cname as Course Name, avg(final) as Average Grade
    -> from score join course on score.courseno=course.courseno
    -> group by cname;
mysql> select * from course_avg;
```

#### [Example 5.12]
Perform insert, update, and delete operations on the base table `teacher` through the view `teach_view1`.
```sql
mysql> insert into teach_view1(teacherno,tname,major,prof,department)
    -> values ('t06027', 'Tao Qinian', 'Nanotechnology', 'Professor', 'School of Materials Science');
mysql> update teach_view1 set prof = 'Associate Professor' where teacherno = 't07019';
Query OK, 1 row affected (0.07 sec)
mysql> delete from teach_view1 where teacherno = 't08017';
mysql> select * from teacher;
```

#### [Example 5.13]
The view `stu_score1` depends on three source tables: `student`, `course`, and `score`, and includes five fields: `studentno`, `sname`, `phone`, `cname`, and `final`. Modify the phone number of the student with the student ID `20120203567` in the base table `student` through `stu_score1`.
```sql
mysql> update stu_score1 set phone='132123456777'
    -> where studentno ='20120203567';
mysql> select studentno,sname, phone from student
    -> where studentno ='20120203567';
```

#### [Example 5.14]
Programmatically create a view named `V_dept` in the `teaching` database, which contains data information of all teachers from the "School of Computer Science". Insertion of data must be restricted to the "School of Computer Science".
```sql
-- Enter the following program in the "Query Editor" to create the V_dept view.
mysql> create view V_dept
    -> as
    -> select teacherno,tname,major,prof, department
    -> from teacher
    -> where department ='School of Computer Science'
    -> with check option;
-- Insert data into the base table teacher through the view V_dept.
mysql> insert into V_dept
    -> values('t08017','Shi Guan','Financial Management','Associate Professor','School of Computer Science');
mysql> select * from teacher where tname='Shi Guan';
-- Insert a data row ('t08037','Shi Ke','Software Technology','Lecturer','School of Software') into the base table teacher through the view V_sex.
mysql> insert into V_dept
    -> values('t08037','Shi Ke','Software Technology','Lecturer','School of Software');
ERROR 1369 (HY000): check option failed 'teaching.v_dept'
```