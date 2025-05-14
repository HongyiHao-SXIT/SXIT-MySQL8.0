DESCRIBE teacher;

use teaching
-- 尝试插入一条 credit 小于 1 的数据
INSERT INTO course (courser,cname, credit) VALUES ('c05110','大学体育', 0);

-- 尝试插入一条 credit 大于 6 的数据
INSERT INTO course (course_name, credit) VALUES ('高级编程', 7);

INSERT INTO student (sno, sname, sex, birthday, classno, point, age)
VALUES 
('S001', '张三', '男', '2000-01-01', '160501', 80, 25),
('S002', '李四', '女', '2001-02-02', '160501', 80, 26),
('S003', '王五', '男', '2000-03-03', '160501', 92, 25),
('S004', '赵六', '女', '2001-04-04', '160501', 93, 25),
('S005', '孙七', '男', '2000-05-05', '160501', 97, 25);

-- 为 teacher 表添加 major 列
ALTER TABLE teacher
ADD COLUMN major VARCHAR(30);

-- 插入 10 条包含 major 列的数据
INSERT INTO teacher (tno, tname, sex, prof, depart, major)
VALUES 
('T00001', '张老师', '男', '教授', '计算机系', '计算机科学与技术'),
('T00002', '王老师', '女', '副教授', '电子系', '电子信息工程'),
('T00003', '李老师', '男', '讲师', '机械系', '机械设计制造及其自动化'),
('T00004', '赵老师', '女', '助教', '化学系', '化学工程与工艺'),
('T00005', '刘老师', '男', '教授', '生物系', '生物科学'),
('T00006', '孙老师', '女', '副教授', '数学系', '数学与应用数学'),
('T00007', '陈老师', '男', '讲师', '物理系', '物理学'),
('T00008', '周老师', '女', '助教', '外语系', '英语'),
('T00009', '吴老师', '男', '教授', '历史系', '历史学'),
('T00010', '郑老师', '女', '副教授', '哲学系', '哲学');

ALTER TABLE student
ADD COLUMN entrance DECIMAL(5, 2);

-- 更新已有记录的 entrance 列，将其值设置为 2024
UPDATE student
SET entrance = 2024;

SHOW CREATE VIEW v_course_avg;

CREATE TRIGGER trigforeign 
AFTER INSERT ON score
FOR EACH ROW
BEGIN
    -- 检查student表中是否存在该学号
    DECLARE student_exists INT;
    
    -- 判断学号是否存在
    SELECT COUNT(*) INTO student_exists
    FROM student
    WHERE sno = NEW.sno;

    -- 如果学号不存在，删除score表中该条记录
    IF student_exists = 0 THEN
        DELETE FROM score WHERE sno = NEW.sno AND courseno = NEW.courseno;
    END IF;
END;


-- 插入不存在的学号数据，触发器会删除该记录
INSERT INTO score (sno, courseno, daily, final) 
VALUES ('S009', 'c05101', 80, 85);  -- 若学号 S009 不存在，则该记录将被删除

CREATE TRIGGER trigforeign
AFTER INSERT ON score
FOR EACH ROW
BEGIN
    -- 检查 student 表中是否存在该学号
    DECLARE student_exists INT;
    
    -- 判断学号是否存在
    SELECT COUNT(*) INTO student_exists
    FROM student
    WHERE sno = NEW.sno;

    -- 如果学号不存在，标记该记录删除（删除操作需要在应用层执行）
    IF student_exists = 0 THEN
        -- 删除该无效记录
        DELETE FROM score WHERE sno = NEW.sno AND courseno = NEW.courseno;
    END IF;
END;


-- 创建score表
CREATE TABLE score (
    sno CHAR(8) NOT NULL,
    courseno CHAR(6) NOT NULL,
    daily DECIMAL(5,2),
    final DECIMAL(5,2),
    PRIMARY KEY (sno, courseno)
);

-- 插入测试数据
SELECT 
    courseno AS 课程号,
    COUNT(*) AS 选修人数,
    AVG(final) AS 期末平均分
FROM 
    score
WHERE 
    courseno LIKE 'c05%'  -- 课程编号以c05开头
GROUP BY 
    courseno
HAVING 
    COUNT(*) >= 3  -- 三名及以上学生选修
    AND AVG(final) > 75  -- 平均分高于75分
ORDER BY 
    AVG(final) DESC;  -- 按平均分降序排序: 课程号不以c05开头，应被过滤

-- 禁用外键检查
SET FOREIGN_KEY_CHECKS = 0;

-- 插入数据（无约束检查）
INSERT INTO score ...

-- 启用外键检查
SET FOREIGN_KEY_CHECKS = 1;

-- 为课程c05103添加第三名学生，使其选修人数达到3人
INSERT INTO score (sno, courseno, daily, final) VALUES
('180103', 'c05103', 85.00, 92.00);

-- 添加新课程c05105，有3名学生选修且平均分>75
INSERT INTO score (sno, courseno, daily, final) VALUES
('180104', 'c05105', 80.00, 85.00),
('180105', 'c05105', 75.00, 80.00),
('180106', 'c05105', 90.00, 95.00);

-- 添加新课程c05107，有4名学生选修但平均分=75（不满足条件）
INSERT INTO score (sno, courseno, daily, final) VALUES
('180107', 'c05107', 70.00, 75.00),
('180108', 'c05107', 70.00, 75.00),
('180109', 'c05107', 70.00, 75.00),
('180110', 'c05107', 70.00, 75.00);

INSERT INTO score (sno, courseno, daily, final)
VALUES ('S9999', 'C001', 85, 90);

INSERT INTO course (courseno, cname, credit, tno)
VALUES
('c05103', '计算机基础', 4, 't05001'),
('c05108', '数据结构', 3, 't05002');