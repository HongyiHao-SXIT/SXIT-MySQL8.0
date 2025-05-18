-- 一、表的创建
-- 1. 创建Student表
CREATE TABLE Student (
    studentno VARCHAR(20) PRIMARY KEY,
    sname VARCHAR(50) NOT NULL,
    sex CHAR(1) CHECK (sex IN ('男', '女')),
    birthday DATE,
    entrance DATE,
    phone VARCHAR(20),
    Email VARCHAR(50) UNIQUE
);

-- 2. 创建Course表
CREATE TABLE Course (
    courseno VARCHAR(20) PRIMARY KEY,
    cname VARCHAR(50) NOT NULL,
    type VARCHAR(20),
    period INT CHECK (period > 0),
    term INT CHECK (term BETWEEN 1 AND 8)
);

-- 3. 创建Score表
CREATE TABLE Score (
    studentno VARCHAR(20),
    courseno VARCHAR(20),
    daily DECIMAL(5,2) CHECK (daily BETWEEN 0 AND 100),
    final DECIMAL(5,2) CHECK (final BETWEEN 0 AND 100),
    PRIMARY KEY (studentno, courseno),
    FOREIGN KEY (studentno) REFERENCES Student(studentno) ON DELETE CASCADE,
    FOREIGN KEY (courseno) REFERENCES Course(courseno) ON DELETE CASCADE
);

-- 4. 创建Teacher表
CREATE TABLE Teacher (
    teacherno VARCHAR(20) PRIMARY KEY,
    tname VARCHAR(50) NOT NULL,
    major VARCHAR(50),
    prof VARCHAR(20),
    dapartment VARCHAR(50)
);

-- 5. 创建Teach_course表
CREATE TABLE Teach_course (
    teacherno VARCHAR(20),
    courseno VARCHAR(20),
    PRIMARY KEY (teacherno, courseno),
    FOREIGN KEY (teacherno) REFERENCES Teacher(teacherno) ON DELETE CASCADE,
    FOREIGN KEY (courseno) REFERENCES Course(courseno) ON DELETE CASCADE
);

-- 二、单表查询
-- 1. 查询所有学生的信息，按入学时间降序排列
SELECT * FROM Student ORDER BY entrance DESC;

-- 2. 查询选修课程号为'C001'且成绩大于85分的学生学号和成绩
SELECT studentno, final FROM Score 
WHERE courseno = 'C001' AND final > 85;

-- 3. 计算每门课程的平均分，保留两位小数
SELECT courseno, ROUND(AVG(final), 2) AS avg_score FROM Score 
GROUP BY courseno;

-- 4. 查询选修课程超过3门的学生学号和选课数量
SELECT studentno, COUNT(courseno) AS course_count FROM Score 
GROUP BY studentno HAVING course_count > 3;

-- 三、多表查询
-- 1. 查询选修了'数据库原理'课程的学生姓名和成绩
SELECT s.sname, sc.final
FROM Student s
JOIN Score sc ON s.studentno = sc.studentno
JOIN Course c ON sc.courseno = c.courseno
WHERE c.cname = '数据库原理';

-- 2. 查询'计算机科学与技术'系教师教授的所有课程名称
SELECT c.cname
FROM Teacher t
JOIN Teach_course tc ON t.teacherno = tc.teacherno
JOIN Course c ON tc.courseno = c.courseno
WHERE t.dapartment = '计算机科学与技术';

-- 3. 查询没有选修任何课程的学生姓名（使用左连接）
SELECT s.sname
FROM Student s
LEFT JOIN Score sc ON s.studentno = sc.studentno
WHERE sc.studentno IS NULL;

-- 四、正则表达式模糊查询
-- 1. 查询姓名中包含'张'或'王'的学生信息
SELECT * FROM Student 
WHERE sname REGEXP '张|王';

-- 2. 查询课程名以'数据'开头的课程信息
SELECT * FROM Course 
WHERE cname REGEXP '^数据';

-- 五、常用函数的使用
-- 1. 查询学生的年龄（基于当前日期计算）
SELECT studentno, sname, 
       TIMESTAMPDIFF(YEAR, birthday, CURDATE()) AS age 
FROM Student;

-- 2. 查询每个学生的总成绩和平均成绩（保留两位小数）
SELECT studentno, 
       SUM(final) AS total_score, 
       ROUND(AVG(final), 2) AS avg_score 
FROM Score 
GROUP BY studentno;

-- 六、索引、视图、函数、存储过程、触发器、事件的创建
-- 1. 创建索引：为Student表的sname字段创建索引
CREATE INDEX idx_sname ON Student(sname);

-- 2. 创建视图：创建学生成绩视图，包含学生姓名、课程名和成绩
CREATE VIEW Student_Score_View AS
SELECT s.sname, c.cname, sc.final
FROM Student s
JOIN Score sc ON s.studentno = sc.studentno
JOIN Course c ON sc.courseno = c.courseno;

-- 3. 创建函数：计算加权总分（日常成绩占30%，期末成绩占70%）
DELIMITER $$
CREATE FUNCTION CalculateTotalScore(daily DECIMAL(5,2), final DECIMAL(5,2)) 
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    RETURN daily * 0.3 + final * 0.7;
END$$
DELIMITER ;

-- 4. 创建存储过程：查询指定课程的学生名单和成绩
DELIMITER $$
CREATE PROCEDURE GetCourseStudents(IN course_name VARCHAR(50))
BEGIN
    SELECT s.sname, sc.final
    FROM Student s
    JOIN Score sc ON s.studentno = sc.studentno
    JOIN Course c ON sc.courseno = c.courseno
    WHERE c.cname = course_name;
END$$
DELIMITER ;

-- 5. 创建触发器：在插入成绩前检查成绩范围
DELIMITER $$
CREATE TRIGGER BeforeScoreInsert
BEFORE INSERT ON Score
FOR EACH ROW
BEGIN
    IF NEW.daily < 0 OR NEW.daily > 100 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '日常成绩必须在0-100之间';
    END IF;
    IF NEW.final < 0 OR NEW.final > 100 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '期末成绩必须在0-100之间';
    END IF;
END$$
DELIMITER ;

-- 6. 创建事件：每月1日凌晨1点备份Score表
DELIMITER $$
CREATE EVENT MonthlyScoreBackup
ON SCHEDULE EVERY 1 MONTH
STARTS '2024-01-01 01:00:00'
DO
BEGIN
    INSERT INTO Score_Backup (studentno, courseno, daily, final, backup_date)
    VALUES (NEW.studentno, NEW.courseno, NEW.daily, NEW.final, NOW());
END$$
DELIMITER ;

-- 七、创建用户和发放授权
-- 1. 创建用户
CREATE USER 'teaching_user'@'localhost' IDENTIFIED BY 'password123';

-- 2. 授予SELECT权限
GRANT SELECT ON teaching.* TO 'teaching_user'@'localhost';

-- 3. 授予特定表的INSERT和UPDATE权限
GRANT INSERT, UPDATE ON teaching.Score TO 'teaching_user'@'localhost';

-- 4. 刷新权限
FLUSH PRIVILEGES;    