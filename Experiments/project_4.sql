-- 查询所有班级的期末成绩平均分，并按照平均分降序排序
SELECT class.classno, AVG(score.final) AS avg_score
FROM class
         JOIN teach_class ON class.classno = teach_class.classno
         JOIN score ON teach_class.courseno = score.courseno
GROUP BY class.classno
ORDER BY avg_score DESC;
GO

-- 查询教师基本信息和教授课程信息，其中包括未分配课程的教师信息
SELECT teacher.*, course.courseno, course.cname
FROM teacher
         LEFT JOIN teach_class ON teacher.teacherno = teach_class.teacherno
         LEFT JOIN course ON teach_class.courseno = course.courseno;
GO

-- 查询两门及以上课程的期末成绩超过80分的学生姓名及其平均成绩
SELECT student.sname, AVG(score.final) AS avg_score
FROM student
         JOIN score ON student.studentno = score.studentno
WHERE score.final > 80
GROUP BY student.sname
HAVING COUNT(score.courseno) >= 2;
GO

-- 查询没有被任何学生选修的课程编号、课程名称和学分(子查询)
SELECT courseno, cname, credit
FROM course
WHERE courseno NOT IN (SELECT DISTINCT courseno FROM score);
GO

-- 查询入学成绩最高的学生学号、姓名和入学成绩(子查询)
SELECT studentno, sname, point
FROM student
WHERE point = (SELECT MAX(point) FROM student);
GO

-- 查询同时教授c05127号和c05109号课程的教师信息(子查询)
SELECT *
FROM teacher
WHERE teacherno IN (
    SELECT teacherno
    FROM teach_class
    WHERE courseno IN ('c05127', 'c05109')
    GROUP BY teacherno
    HAVING COUNT(DISTINCT courseno) = 2
);
GO

-- 查询每门课程的课程号、课程名和选修该课程的学生人数，并按所选人数升序排序
SELECT course.courseno, course.cname, COUNT(score.studentno) AS student_count
FROM course
         LEFT JOIN score ON course.courseno = score.courseno
GROUP BY course.courseno, course.cname
ORDER BY student_count ASC;
GO

-- 使用游标输出学生姓名、选修课程名称和期末考试成绩
DECLARE @sname VARCHAR(50), @cname VARCHAR(50), @final DECIMAL(5, 2);
DECLARE student_cursor CURSOR FOR
SELECT student.sname, course.cname, score.final
FROM student
         JOIN score ON student.studentno = score.studentno
         JOIN course ON score.courseno = course.courseno;

OPEN student_cursor;
FETCH NEXT FROM student_cursor INTO @sname, @cname, @final;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT CONCAT('学生姓名: ', @sname, ', 选修课程名称: ', @cname, ', 期末考试成绩: ', @final);
    FETCH NEXT FROM student_cursor INTO @sname, @cname, @final;
END;

CLOSE student_cursor;
DEALLOCATE student_cursor;
GO