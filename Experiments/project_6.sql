-- 创建一个存储过程ProcNum，查询每个班级中学生的人数，按班级号升序排序
CREATE PROCEDURE ProcNum
AS
BEGIN
    SELECT classno, COUNT(*) AS student_count
    FROM student
    GROUP BY classno
    ORDER BY classno ASC;
END;
GO

-- 利用SQL语句创建一个带有参数的存储过程ProcInsert，向score表插入一条选课记录，并查询该学生的姓名、选修的所有课程名称、平时成绩和期末成绩
CREATE PROCEDURE ProcInsert
    @studentno VARCHAR(20),
    @courseno VARCHAR(20),
    @usual DECIMAL(5, 2),
    @final DECIMAL(5, 2)
AS
BEGIN
    INSERT INTO score (studentno, courseno, usual, final)
    VALUES (@studentno, @courseno, @usual, @