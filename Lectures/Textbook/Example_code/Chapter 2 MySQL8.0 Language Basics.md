### Chapter 2 MySQL8.0 Language Basics
【Example 2.1】Use arithmetic operators for operations such as addition, subtraction, multiplication, division, and modulo.
```sql
mysql> select 3+2,1.5*3,3/5,100-23.5,5%3;
```
【Example 2.2】Use comparison operators for judgment operations.
```sql
mysql> select 'A'>'B',1+1=2, 'X'<'x', 7<>7, 'a'<= 'a';
```
【Example 2.3】Demonstrate the usage of the is null and is not null operators.
```sql
mysql> select  null is not  null,17.3 is null, 11.7 is not null;
```
【Example 2.4】Use the "between and" operator to determine whether a number is within a certain range.
```sql
mysql> select 11.7  not between 0 and 10, 51  between 0 and 70;
```
【Example 2.5】Use the "in" operator to determine whether a value is within a specified range. 
```sql
mysql> select 7 in(1,2,5,6,7,8,9), 3 not in (1,10);
```
【Example 2.6】Use the like operator to determine whether a string matches a specified string.
```sql
mysql> select  'MySQL' like 'MY%', 'APPLE'  like  'A_';
```
【Example 2.7】Examples of logical operators and, or, and not.
```sql
mysql>select not('A'='B'),('c' ='C')and('c'<'D')or(1=2);
```
【Example 2.8】Examples of logical operators && and xor.
```sql
mysql> select ('c'='C') && (1=2),('A'='a')xor(1+1=3);
```
【Example 2.9】Examples of bitwise operators.
```sql
mysql> select 3&2,2|3,100>>5, ~1,6^4;
```
【Example 2.10】Examples of the floor(), ceiling(), and log(5) functions.
```sql
mysql>select floor(3.67),ceiling(4.71), log(5);
```
【Example 2.11】Use the rand() function to generate random numbers and the round() function for rounding to output random integers between 60 - 90 and 25 - 65.
```sql
mysql>select  60+ round(30*rand(),0) , 25+ round(40*rand(),0); 
```
【Example 2.12】Use the concat() function to concatenate strings.
```sql
mysql> select concat('MY',' SQL','8.0.22'),concat('ABC',null,'DEF');
```
【Example 2.13】Use the substring() function to return a specified string and the reverse() function to output it in reverse order.
```sql
mysql> select substring('ABCDEFGH',2,6),
-> reverse(substring('ABCDEFGH',2,6));
```
【Example 2.14】Use the curdate()\curtime() and now() functions to return the current date and time.
```sql
mysql>select curdate(),curdate()+7,curtime(),now()+10;
```
【Example 2.15】Return the ordinal numbers of a specified date in a year, a week, and a month.
```sql
mysql> select dayofyear(20210512),dayofmonth('2021-05-12'),
-> dayofweek(now());
```
【Example 2.16】Return the hour, minute, and second of a specified time.
```sql
mysql> select curtime(),hour(curtime()),
-> minute(curtime()),second(curtime());
```
【Example 2.17】Calculate what time it was 45 minutes before a specified time.
```sql
mysql>select date_sub('2020-10-1 10:10:10', interval 45 minute);
```
【Example 2.18】The holiday is on January 27, 2021. Calculate how many days are left until the holiday.
```sql
mysql>select datediff('2021-1-27',now());
```
【Example 2.19】Output the date according to a specified format code.
```sql
mysql> select date_format(now(),'%W,%d,%m, %Y , %r, %p');
```
【Example 2.20】Return the version of the MySQL server, the current database name, and the current username information, and view the number of times the current user has connected to the MySQL server.
```sql
mysql> select  version(),database(),user(),connection_id();
```
【Example 2.21】Use the md5() function to encrypt a string.
```sql
mysql> select md5('student157');
```
【Example 2.22】Use the sha() function to encrypt a string.
```sql
mysql> select sha('student157');
```
【Example 2.23】Use the sha2() function to encrypt a string.
```sql
mysql> select sha2('student157',0) A, sha2('student157',224) B\G
mysql> select sha2('student157',0) A, sha2('student157',224) B\G
```
【Example 2.24】Use the format() function to process data.
```sql
mysql> select format(2/3,2), format(123456.78,0);
``` 