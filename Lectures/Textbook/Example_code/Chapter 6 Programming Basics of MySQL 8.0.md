### Chapter 6 Programming Basics of MySQL 8.0

【Example 6.1】Assign a value to a variable using the query result.
```sql
mysql> use teaching;
Database changed
mysql> set @sname=(select sname from student
-> where studentno='20126113307');
mysql> select studentno, sname, birthdate
-> from student where sname=@sname;
```
【Example 6.2】Use the `select` statement to assign data from a table to a variable.
```sql
mysql> select @sname:=sname from student limit 0,1;
```
【Example 6.3】Examples of changing the end marker of MySQL commands.
```sql
mysql> delimiter  //
mysql> select studentno,sname,phone
-> from student where sname like 'Zhao%'//
mysql> delimiter  $$
mysql> select studentno,sname,birthdate
-> from student where sname like 'Han%'$$
mysql>  delimiter ;
```
【Example 6.4】Calculate the length of the hypotenuse of a right triangle when the lengths of the two right-angled sides are given.
```sql
mysql> prepare hypo_c from 'select sqrt(pow(?,2) + pow(?,2)) AS hypotenuse';
mysql> set @a = 6;
mysql> set @b = 8;
mysql> execute hypo_c using @a, @b;
mysql> deallocate  prepare  hypo_c;
```
【Example 6.5】Use a prepared SQL statement to output partial data of the first 2 rows in the `student` table.
```sql
mysql> set @a=2;
mysql> prepare  STMT  
-> from "select studentno,sname,entrance from  student  limit ?";
mysql> execute STMT using @a;
mysql> set @a=3;
mysql> execute STMT using @a;
```
【Example 6.6】Create a function to calculate the area of a rectangle.
```sql
mysql> delimiter //
mysql> create function rectangle_area(long1 int,wide1 int) returns int
-> no sql
-> begin
->   return long1 * wide1;
-> end //
mysql> delimiter ;
```
【Example 6.7】Create a function named `func_course` to return the course name of the specified course number in the `course` table.
```sql
mysql> delimiter &&
mysql> create  function func_course(c_no varchar(6))
-> returns  char(6)
-> reads sql data 
-> begin
->    return  (select  cname  from  course
->               where  courseno =c_no);
-> end &&
mysql> delimiter ;
```
【Example 6.8】Call the functions `rectangle_area()` and `func_course` respectively.
```sql
mysql> select rectangle_area(5,4);
mysql> select func_course('c08123');
```
【Example 6.9】Modify the definition of the stored function `func_course`. Change the read and write permission to `no sql` and add the comment information "find function name".
```sql
mysql> alter  function  func_course
-> no sql 
-> comment  'find function name';
mysql> select  SPECIFIC_NAME,SQL_DATA_ACCESS,
-> routine_comment  from  information_schema.Routines
-> where  routine_name='func_course';
```
【Example 6.10】Create the function `exam_if`. Through the `if…then…else` structure, first determine whether the value of the passed parameter is 10. If it is, output 1. If not, then determine whether the value of the passed parameter is 20. If it is, output 2. When neither of the above conditions is met, output 3. Then call the function `exam_if`.
```sql
mysql> delimiter //
mysql> create function exam_if(x int)
-> returns int
-> no sql
-> begin
-> if x=10 then set x=1;
-> elseif x=20 then set x=2;
-> else  set x=3;
-> end if;
-> return x;
-> end //
mysql> delimiter ;
mysql> select exam_if(79);
```
【Example 6.11】Create the function `exam_case`. Through the `case` statement, first determine whether the value of the passed parameter is 10. If the condition is met, output 1. If the condition is not met, then determine whether the value of the passed parameter is 20. If it is, output 2. When neither of the above conditions is met, output 3.
```sql
mysql> delimiter //
mysql> create function exam_case( x int)
-> returns  int
-> no sql
-> begin
-> case  x
-> when 10  then set  x=1;
-> when 20  then set  x=2;
-> else  set  x=3;
-> end case;
-> return  x;
-> end //
mysql> delimiter ;
mysql> select exam_case(17);
```
【Example 6.12】Query the student ID `studentno` and entrance score `entrance` from the `student` table. If the score is greater than or equal to 800, display "pass!". Otherwise, display "bye.". Output the first 5 records.
```sql
mysql> select  studentno, entrance,if(entrance >=800,'pass','bye! ')
-> from  student  limit  5;
```
【Example 6.13】Define the function `exam_while`. Use the `while` statement to find the sum of the first 100 terms from 1 to 100.
```sql
mysql> delimiter //
mysql> create  function  exam_while(n int) returns int
-> no sql
->  begin
->  declare sum int default 0; 
-> declare m int default 1;
->  while  m <= n  do
->  set  sum=sum+m;
->  set  m=m+1;
->  end while;
->  return  sum;
-> end //
mysql> delimiter ;
mysql> select exam_while(100);
```
【Example 6.14】Define the function `exam_loop`. Use the `loop` statement to find the sum from 1 to 100. Exit the loop through the `leave` statement and output the result.
```sql
mysql> delimiter //
mysql> create  function  exam_loop(n int) returns int
-> no sql
-> begin
-> declare  sum int default 0;
-> set n=1;
-> loop_label:loop
-> set sum=sum+n;
-> set n=n+1;
-> if  n>100  then
-> leave  loop_label;
-> end if;
-> end loop;
-> return  sum;
-> end //
mysql> delimiter ;
mysql> select exam_loop(100);
```
【Example 6.15】Define the function `exam_iterate`. Use the `while` statement and the `iterate` statement to find the sum of even numbers between 1 and 100. Exit the loop through the `leave` statement and output the result.
```sql
mysql> delimiter //
mysql> create  function  exam_iterate(n int) returns int
-> no sql
->  begin
->  declare sum char(20) default 0;
-> declare s int default 0;
-> add_num: while  true  do
-> set s=s+1;
-> if (s%2=0) then
-> set sum=sum+s;
->  else
-> iterate  add_num;
-> end if;
-> if (s=n) then
-> leave  add_num;
->  end if;
->  end while add_num;
-> return  sum;
-> end;
->  //
mysql> delimiter ;
mysql> select exam_iterate(100);
```
【Example 6.16】Define the function `exam_repeat`. Use the `repeat` statement to find the sum of numbers from 1 to 50.
```sql
mysql> delimiter //
mysql> create  function  exam_repeat (n int) returns int
-> no sql
-> begin
-> declare sum int default 0;
-> set  n=1;
-> repeat
-> set sum=sum+n;
-> set n=n+1;
-> until n>50
-> end repeat;
-> return sum;
-> end //
mysql> delimiter ;
mysql> select exam_repeat(50);
``` 