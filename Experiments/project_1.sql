-- (1) 利用MySQL创建一个名为teaching数据库,初始大小为10MB,增长速度为10%,其他均采用默认设置。
CREATE DATABASE teaching
    -- 初始大小为10MB
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_general_ci
    -- 数据文件设置
    DATAFILE 'teaching_data.MYDATA'
        SIZE 10MB
        AUTO_INCREMENT 10%
    -- 日志文件设置
    LOGFILE 'teaching_log.MYLOG'
        SIZE 5MB;

-- 使用teaching数据库
USE teaching;

-- (2) 在查询编辑器中输入创建表的代码，分别创建student、course、score、teacher、 class、teach_class这6张表
-- student表结构
CREATE TABLE student (
    studentno  CHAR(11) NOT NULL COMMENT '学号',
    sname CHAR(8) NOT NULL COMMENT '姓名',
    sex ENUM('男', '女') DEFAULT '男' COMMENT '性别',
    birthdate DATE NOT NULL COMMENT '出生日期',
    entrance INT(3) NULL COMMENT '入学成绩',
    phone VARCHAR(12) NOT NULL COMMENT '电话',
    Email VARCHAR(20) NOT NULL COMMENT '电子信箱',
    PRIMARY KEY (studentno)
);

-- course表结构
CREATE TABLE course (
    courseno CHAR(6) NOT NULL,
    cname CHAR(6) NOT NULL,
    type CHAR(8) NOT NULL,
    period INT(2) NOT NULL,
    exp INT(2) NOT NULL,
    term INT(2) NOT NULL,
    PRIMARY KEY (courseno)
);

-- score表结构
CREATE TABLE score (
    studentno CHAR(11) NOT NULL,
    courseno CHAR(6) NOT NULL,
    daily FLOAT(4, 1) DEFAULT 0,
    final FLOAT(4, 1) DEFAULT 0,
    PRIMARY KEY (studentno, courseno),
    FOREIGN KEY (studentno) REFERENCES student(studentno),
    FOREIGN KEY (courseno) REFERENCES course(courseno)
);

-- teacher表结构
CREATE TABLE teacher (
    teacherno CHAR(6) NOT NULL COMMENT '教师编号',
    tname CHAR(8) NOT NULL COMMENT '教师姓名',
    major CHAR(10) NOT NULL COMMENT '专业',
    prof CHAR(10) NOT NULL COMMENT '职称',
    department CHAR(16) NOT NULL COMMENT '部门',
    PRIMARY KEY (teacherno)
);

-- class表结构
CREATE TABLE class (
    classno CHAR(6) NOT NULL COMMENT '班级编号',
    classname CHAR(10) NOT NULL COMMENT '班级名称',
    monitor CHAR(8) NULL COMMENT '班长姓名',
    PRIMARY KEY (classno)
);

-- teach_class表结构
CREATE TABLE teach_class (
    teacherno CHAR(6) NOT NULL,
    classno CHAR(6) NOT NULL,
    PRIMARY KEY (teacherno, classno),
    FOREIGN KEY (teacherno) REFERENCES teacher(teacherno),
    FOREIGN KEY (classno) REFERENCES class(classno)
);

-- (3) 分别对这6张表输入记录（每张表不少于5条记录）
-- 插入student表记录
INSERT INTO student (studentno, sname, sex, birthdate, entrance, phone, Email)
VALUES
    ('2023010001', '张三', '男', '2005-03-10', 500, '13812345678', 'zhangsan@example.com'),
    ('2023010002', '李四', '女', '2005-05-20', 520, '13987654321', 'lisi@example.com'),
    ('2023010003', '王五', '男', '2005-08-15', 550, '13666666666', 'wangwu@example.com'),
    ('2023010004', '赵六', '女', '2005-11-08', 580, '13777777777', 'zhaoliu@example.com'),
    ('2023010005', '孙七', '男', '2006-02-28', 600, '13555555555', 'sunqi@example.com');

-- 插入course表记录
INSERT INTO course (courseno, cname, type, period, exp, term)
VALUES
    ('c00001', '数学', '必修', 64, 16, 1),
    ('c00002', '语文', '必修', 64, 16, 1),
    ('c00003', '英语', '必修', 64, 16, 1),
    ('c00004', '物理', '必修', 48, 16, 2),
    ('c00005', '化学', '必修', 48, 16, 2);

-- 插入score表记录
INSERT INTO score (studentno, courseno, daily, final)
VALUES
    ('2023010001', 'c00001', 85.5, 90.0),
    ('2023010002', 'c00001', 90.0, 88.0),
    ('2023010001', 'c00002', 80.0, 85.0),
    ('2023010003', 'c00002', 75.5, 82.0),
    ('2023010004', 'c00003', 95.0, 92.0);

-- 插入teacher表记录
INSERT INTO teacher (teacherno, tname, major, prof, department)
VALUES
    ('t00001', '陈老师', '数学', '教授', '数学学院'),
    ('t00002', '林老师', '语文', '副教授', '文学院'),
    ('t00003', '黄老师', '英语', '讲师', '外语学院'),
    ('t00004', '周老师', '物理', '副教授', '理学院'),
    ('t00005', '吴老师', '化学', '讲师', '理学院');

-- 插入class表记录
INSERT INTO class (classno, classname, monitor)
VALUES
    ('c10001', '一班', '张三'),
    ('c10002', '二班', '李四'),
    ('c10003', '三班', '王五'),
    ('c10004', '四班', '赵六'),
    ('c10005', '五班', '孙七');

-- 插入teach_class表记录
INSERT INTO teach_class (teacherno, classno)
VALUES
    ('t00001', 'c10001'),
    ('t00002', 'c10002'),
    ('t00003', 'c10003'),
    ('t00004', 'c10004'),
    ('t00005', 'c10005');

-- (4) 向student表插入、删除、修改一条记录
-- 插入一条记录
INSERT INTO student (studentno, sname, sex, birthdate, entrance, phone, Email)
VALUES ('2023010006', '钱八', '男', '2006-06-06', 560, '13444444444', 'qianba@example.com');

-- 删除一条记录（假设删除学号为2023010006的记录）
DELETE FROM student WHERE studentno = '2023010006';

-- 修改一条记录（假设将学号为2023010001的学生入学成绩修改为530）
UPDATE student
SET entrance = 530
WHERE studentno = '2023010001';