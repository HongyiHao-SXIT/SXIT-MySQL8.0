SELECT courseno, cname, credit FROM course;

SELECT *FROM student WHERE classno = '160501';

SELECT sname, YEAR(CURRENT_DATE) - YEAR(birthdate) AS age
FROM student
WHERE sex = '男' AND YEAR(CURRENT_DATE) - YEAR(birthdate) > 20;

SELECT major
FROM teacher
WHERE department = '计算机学院';

CREATE TABLE 学生选课统计表 (
    studentno CHAR(11),
    course_count INT,
    total_score DECIMAL(10, 2)
);

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

SELECT *
FROM student
ORDER BY classno ASC, entrance DESC;

SELECT classno, COUNT(studentno) AS student_count
FROM student
GROUP BY classno;

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

SELECT 
    t.teacherno,
    c.courseno,
    tc.classno
FROM 
    teacher t
JOIN 
    teach_class tc ON t.teacherno = tc.teacherno
JOIN 
    score sc ON tc.classno = sc.studentno 
    course c ON sc.courseno = c.courseno
GROUP BY 
    t.teacherno, c.courseno, tc.classno
HAVING 
    COUNT(c.courseno) >= 2;


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