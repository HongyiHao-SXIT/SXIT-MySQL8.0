-- 所有课程编号、名称、学分
SELECT courseno, cname, credit FROM course;

-- 查询160501班所有学生
SELECT * FROM student WHERE classno = '160501';

-- 查询年龄大于20岁的男生
SELECT sname, TIMESTAMPDIFF(YEAR, birthday, CURDATE()) AS age
FROM student WHERE sex = '男' AND TIMESTAMPDIFF(YEAR, birthday, CURDATE()) > 20;

-- 计算机学院教师的专业名称（假设为dept字段）
SELECT DISTINCT depart FROM teacher WHERE depart = '计算机学院';

-- 查询每个学生的课程数、总成绩
SELECT s.sno, COUNT(*) AS course_count, SUM(finalscore) AS total_score
FROM score s GROUP BY s.sno;

-- 排序：班级升序、成绩降序
SELECT * FROM student ORDER BY classno ASC, point DESC;

-- 查询各班人数
SELECT classno, COUNT(*) AS num_students FROM student GROUP BY classno;

-- 查询各班成绩最高和最低分
SELECT classno, MAX(finalscore) AS max_score, MIN(finalscore) AS min_score
FROM student s JOIN score sc ON s.sno = sc.sno GROUP BY classno;

-- 教授两门及以上的教师
SELECT tno tname,COUNT(DISTINCT courseno) AS course_count
FROM teach_class GROUP BY tno HAVING course_count >= 2;

-- 查询课程以c05开头、选课人数≥3且平均分>75
SELECT 
    s.courseno AS 课程号,
    COUNT(*) AS 选修人数,
    AVG(s.final) AS 期末成绩平均分
FROM 
    score s
WHERE 
    s.courseno LIKE 'c05%'  -- 课程编号以c05开头
GROUP BY 
    s.courseno
HAVING 
    COUNT(*) >= 3  -- 三名及以上学生选修
    AND AVG(s.final) > 75  -- 平均分高于75分
ORDER BY 
    AVG(s.final) DESC;  -- 按平均分降序排序


SELECT s.sno, COUNT(*) AS course_count, SUM(final) AS total_score
FROM score s
GROUP BY s.sno;
