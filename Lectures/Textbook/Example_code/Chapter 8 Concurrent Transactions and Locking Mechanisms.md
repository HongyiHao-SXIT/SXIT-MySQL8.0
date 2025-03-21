### Chapter 8 Concurrent Transactions and Locking Mechanisms

#### Example 8.1
An example of modifying the automatic commit mode of the variable `@@autocommit`. Delete the record with the course number `c05103` from the table and then roll back the transaction.
```sql
mysql> use teaching;
Database changed
mysql> delimiter //
mysql> set @@autocommit = 0;
mysql> create procedure auto_cno()
    -> begin
    -> start transaction;
    -> delete from course where courseno = 'c05103';
    -> select * from course where courseno = 'c05103';
    -> rollback;
    -> select * from course where courseno = 'c05103';
    -> end//
mysql> delimiter ;
mysql> call auto_cno();
```

#### Example 8.2
Change the course name of the course with the course number `c05103` in the `course` table to "Advanced Mathematics" and commit the transaction.
```sql
mysql> use teaching;
Database changed
mysql> delimiter //
mysql> create procedure update_cno()
    -> begin
    -> start transaction;
    -> update course set cname = 'Advanced Mathematics'
    -> where courseno = 'c05103';
    -> commit;
    -> select * from course where courseno = 'c05103';
    -> end//
mysql> delimiter ;
mysql> call update_cno();
```

#### Example 8.3
Use an explicit transaction to insert two records into the `course` table.
```sql
mysql> delimiter //
mysql> create procedure insert_cno()
    -> begin
    -> start transaction;
    -> insert into course
    -> values('c05141', 'WIN Design', 'Elective', 48, 8, 8);
    -> insert into course
    -> values('c05142', 'WEB Language', 'Elective', 32, 8, 8);
    -> select * from course where term = 8;
    -> commit;
    -> end//
mysql> delimiter ;
mysql> call insert_cno();
```

#### Example 8.4
Define a transaction to add a record to the `course` table and set a savepoint. Then delete the record and roll back to the savepoint of the transaction, and finally commit the transaction.
```sql
mysql> delimiter //
mysql> create procedure sp_cno()
    -> begin
    -> start transaction;
    -> insert into course
    -> values('c05139', 'UML Modeling', 'Elective', 48, 12, 7);
    -> savepoint spcno1;
    -> delete from course
    -> where courseno = 'c05139';
    -> rollback work to savepoint spcno1;
    -> select * from course where courseno = 'c05139';
    -> commit;
    -> end//
mysql> delimiter ;
mysql> call sp_cno();
```

#### Example 8.5
Write a stored procedure for the transfer business, requiring that the current amount `cur_money` of an account in the `bank` table cannot be less than 1.
```sql
mysql> use mytest;
Database changed
-- Create the bank table, insert records, and display them
mysql> create table bank(
    -> cus_no varchar(8),
    -> cus_name varchar(10),
    -> cur_money decimal(13, 2));
mysql> insert into bank values('bj101211', 'Zhang Sirui', 1000);
mysql> insert into bank values('sd101677', 'Li Fo', 1);
mysql> select * from bank;

-- Create the stored procedure trans_bank()
mysql> delimiter //
mysql> create procedure trans_bank()
    -> begin
    -> declare money decimal(13, 2);
    -> start transaction;
    -> update bank set cur_money = cur_money - 1000 where cus_no = 'bj101211';
    -> update bank set cur_money = cur_money + 1000 where cus_no = 'sd101677';
    -> select cur_money into money from bank where cus_no = 'bj101211';
    -> if money < 1 then
    -> begin
    -> select 'The transaction fails, the rollback transaction';
    -> rollback;
    -> end;
    -> else
    -> begin
    -> select 'A successful transaction, commits the transaction';
    -> commit;
    -> end;
    -> end if;
    -> end//
mysql> delimiter ;
mysql> call trans_bank();
```

For example, set a read-only lock on the `score` table.
```sql
mysql> lock tables score read;
```
Set a write lock on the `course` table.
```sql
mysql> lock tables course write;
```