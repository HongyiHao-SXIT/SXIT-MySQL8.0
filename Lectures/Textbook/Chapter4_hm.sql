
select studentno,sname,phone,Email from student where studentno in ( select studentno from score where final > 93);

SELECT * FROM course;

SELECT COUNT(*) AS female_count FROM student WHERE sex = '女';

SELECT teacherno, tname, major FROM teacher;

SELECT AVG(year(now()) - year(birthdate)) FROM student as 平均年龄 GROUP BY sex;

SELECT * FROM student WHERE sex = '男' AND YEAR(NOW()) - YEAR(birthdate) = (SELECT MAX(YEAR(NOW()) - YEAR(birthdate))FROM student WHERE sex = '男');

SELECT teacherno, tname, major, department FROM teacher WHERE prof = NULL;

