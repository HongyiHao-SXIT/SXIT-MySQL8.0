-- (1) 查询所有课程的课程编号、课程名和学分（假设course表中有credit列表示学分），查询160501班所有学生的基本信息（假设class表和student表有相关关联字段，这里假设student表有classno字段表示班级号）
-- 查询所有课程的信息
SELECT courseno, cname, credit FROM course;

-- 查询160501班所有学生的基本信息
SELECT *FROM student WHERE classno = '160501';

-- (2) 查询student表中所有年龄大于20岁的男生的姓名和年龄（假设当前年份为2024年，通过birthdate字段计算年龄）
SELECT sname, YEAR(CURRENT_DATE) - YEAR(birthdate) AS age
FROM student
WHERE sex = '男' AND YEAR(CURRENT_DATE) - YEAR(birthdate) > 20;

-- (3) 查询计算机学院教师的专业名称
SELECT major
FROM teacher
WHERE department = '计算机学院';

-- (4) 查询每名学生的学号、选修课程数目、总成绩，并将查询结果存放到生成的“学生选课统计表”（假设score表中有daily和final字段表示平时成绩和期末成绩，总成绩假设为二者之和）
-- 创建“学生选课统计表”
CREATE TABLE 学生选课统计表 (
    studentno CHAR(11),
    course_count INT,
    total_score DECIMAL(10, 2)
);

-- 插入数据到“学生选课统计表”
INSERT INTO 学生选课统计表 (studentno, course_count, total_score)
SELECT 
    s.studentno,
    COUNT(sc.courseno) AS course_count,
    SUM(sc.daily + sc.final) AS total_score
FROM 
    student s
LEFT JOIN 
    score sc ON s.studentno = sc.studentno
GROUP BY 
    s.studentno;

-- (5) 查询student表中所有学生的基本信息,查询结果按班级号classno升序排序,同一班级中的学生按入学成绩entrance降序排列
SELECT *
FROM student
ORDER BY classno ASC, entrance DESC;

-- (6) 查询各班学生的人数(按班级分组),查询各班期末成绩的最高分和最低分（假设score表中有final字段表示期末成绩）
-- 查询各班学生的人数
SELECT classno, COUNT(studentno) AS student_count
FROM student
GROUP BY classno;

-- 查询各班期末成绩的最高分和最低分
SELECT 
    sc.classno,
    MAX(sc.final) AS max_final_score,
    MIN(sc.final) AS min_final_score
FROM 
    score sc
JOIN 
    student s ON sc.studentno = s.studentno
GROUP BY 
    sc.classno;

-- (7) 查询教授两门及以上课程的教师编号、课程编号和任课班级（假设teach_class表关联教师和班级，score表关联学生和课程，这里通过关联查询来实现）
SELECT 
    t.teacherno,
    c.courseno,
    tc.classno
FROM 
    teacher t
JOIN 
    teach_class tc ON t.teacherno = tc.teacherno
JOIN 
    score sc ON tc.classno = sc.studentno -- 这里假设关联逻辑正确，实际可能需要调整
JOIN 
    course c ON sc.courseno = c.courseno
GROUP BY 
    t.teacherno, c.courseno, tc.classno
HAVING 
    COUNT(c.courseno) >= 2;

-- (8) 查询课程编号以c05开头,被三名及以上学生选修,且期末成绩的平均分高于75分的课程号、选修人数和期末成绩平均分，并按平均分降序排序（假设score表中有final字段表示期末成绩）
SELECT 
    sc.courseno,
    COUNT(DISTINCT sc.studentno) AS student_count,
    AVG(sc.final) AS average_final_score
FROM 
    score sc
WHERE 
    sc.courseno LIKE 'c05%'
GROUP BY 
    sc.courseno
HAVING 
    COUNT(DISTINCT sc.studentno) >= 3 AND AVG(sc.final) > 75
ORDER BY 
    average_final_score DESC;