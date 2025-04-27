CREATE TABLE student01 as select * from student where 0;

SELECT * FROM student01;

alter table student01 add imgs mediumblob COMMENT '照片';

INSERT into student01 VALUES('22122221329', '何影彩', '女','2023/12/9', '877', '13178978997', 'heyyl@sina.com','C:\Users\Lanyi\Desktop\Furry\蓝伊_adict.jpg')

SELECT * from course;

SELECT studentno,sname,phone FROM student;

SELECT studentno as '学号', sname as '姓名', phone as '电话', year(now())-year(birthdate) as '年龄' from student where year(birthdate)>2002;

SELECT DISTINCT studentno,courseno from score where final > 30 ORDER BY studentno;
SELECT *from score;

SELECT sex, AVG(TIMESTAMPDIFF(YEAR, birthdate, CURDATE())) AS average_age
FROM student
GROUP BY sex;

SELECT *FROM score