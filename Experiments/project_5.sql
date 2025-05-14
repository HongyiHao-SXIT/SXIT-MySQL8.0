-- 在student表的classno字段创建非聚集非唯一索引UC_classno
CREATE INDEX UC_classno ON student (classno);
GO

-- 在teacher表的tname列上创建非聚集唯一索引UQ_name ，若该索引已存在，则删除后重建
IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'UQ_name' AND object_id = OBJECT_ID('teacher'))
    DROP INDEX UQ_name ON teacher;
GO

CREATE UNIQUE INDEX UQ_name ON teacher (tname);
GO

-- 在course表上创建视图v_course_avg，查询每门课程的课程号、课程名及选修该课程的学生的期末成绩平均分，并且按平均分降序排序
CREATE VIEW v_course_avg
AS
SELECT course.courseno, course.cname, AVG(score.final) AS avg_score
FROM course
         JOIN score ON course.courseno = score.courseno
GROUP BY course.courseno, course.cname
ORDER BY avg_score DESC;
GO

-- 修改v_course_avg视图的定义，添加WITH CHECK OPTION选项
ALTER VIEW v_course_avg
AS
SELECT course.courseno, course.cname, AVG(score.final) AS avg_score
FROM course
         JOIN score ON course.courseno = score.courseno
GROUP BY course.courseno, course.cname
ORDER BY avg_score DESC
WITH CHECK OPTION;
GO

-- 在teaching数据库中创建视图v_teacher_course，包含教师编号、教师姓名、职称、课程号、课程名和任课班级，通过视图v_teacher_course将教师编号为t05017的教师职称更改为”副教授”
CREATE OR REPLACE VIEW v_teacher_course AS
SELECT
    teacher.tno,
    teacher.tname,
    teacher.prof,
    course.courseno,
    course.cname,
    teach_class.classno
FROM
    teacher
    JOIN teach_class ON teacher.tno = teach_class.tno
    JOIN course ON teach_class.courseno = course.courseno;


UPDATE v_teacher_course
SET prof = '副教授'
WHERE tno = 't05001';
GO

-- 用SQL语句删除创建的索引和视图
DROP INDEX UC_classno ON student;
DROP INDEX UQ_name ON teacher;
DROP VIEW v_course_avg;
DROP VIEW v_teacher_course;
GO