-- 1. 
CREATE DATABASE teaching 
ON PRIMARY 
(
    NAME = 'teaching_data',
    FILENAME = 'C:\teaching_data.mdf',
    SIZE = 10MB,
    FILEGROWTH = 10%
)
LOG ON 
(
    NAME = 'teaching_log',
    FILENAME = 'C:\teaching_log.ldf',
    SIZE = 5MB,
    FILEGROWTH = 5MB
);

-- 2.
USE teaching;

CREATE TABLE student (
    sno CHAR(8) PRIMARY KEY,
    sname VARCHAR(20) NOT NULL,
    sex CHAR(2) CHECK (sex IN ('男', '女')),
    birthday DATE,
    classno CHAR(6),
    point DECIMAL(5,2)
);

CREATE TABLE course (
    courseno CHAR(6) PRIMARY KEY,
    cname VARCHAR(30) NOT NULL,
    credit SMALLINT,
    period SMALLINT,
    priorcourse CHAR(6)
);

CREATE TABLE score (
    sno CHAR(8),
    courseno CHAR(6),
    daily DECIMAL(5,2),
    final DECIMAL(5,2),
    PRIMARY KEY (sno, courseno)
);

CREATE TABLE teacher (
    tno CHAR(6) PRIMARY KEY,
    tname VARCHAR(20) NOT NULL,
    sex CHAR(2) CHECK (sex IN ('男', '女')),
    prof CHAR(10),
    depart VARCHAR(30)
);

CREATE TABLE class (
    classno CHAR(6) PRIMARY KEY,
    classname VARCHAR(30) NOT NULL,
    monitor CHAR(8),
    tno CHAR(6)
);

CREATE TABLE teach_class (
    tno CHAR(6),
    classno CHAR(6),
    courseno CHAR(6),
    PRIMARY KEY (tno, classno, courseno)
);

-- 3.
INSERT INTO student VALUES 
('180101', '张三', '男', '2000-05-15', '180501', 85.5),
('180102', '李四', '女', '2000-08-20', '180501', 78.0),
('180103', '王五', '男', '1999-11-10', '180502', 92.5),
('180104', '赵六', '女', '2000-03-25', '180502', 88.0),
('180105', '钱七', '男', '2000-07-12', '180503', 76.5);

INSERT INTO course VALUES 
('c05103', '数据库原理', 4, 64, NULL),
('c05108', '数据结构', 4, 64, NULL),
('c05109', '离散数学', 3, 48, NULL),
('c05127', '操作系统', 4, 64, 'c05108'),
('c05138', '计算机网络', 3, 48, 'c05108'),
('c05222', '软件工程', 3, 48, 'c05103');

INSERT INTO score VALUES 
('180101', 'c05103', 85.0, 90.0),
('180101', 'c05108', 78.0, 82.0),
('180102', 'c05103', 90.0, 88.0),
('180102', 'c05109', 82.0, 85.0),
('180103', 'c05127', 76.0, 80.0);

INSERT INTO teacher VALUES 
('t05001', '刘老师', '男', '教授', '计算机学院'),
('t05002', '张老师', '女', '副教授', '计算机学院'),
('t05003', '李老师', '男', '讲师', '计算机学院'),
('t05004', '王老师', '女', '助教', '数学学院'),
('t05017', '陈老师', '男', '讲师', '计算机学院');

INSERT INTO class VALUES 
('180501', '计算机1801班', '180101', 't05001'),
('180502', '计算机1802班', '180103', 't05002'),
('180503', '计算机1803班', '180105', 't05003'),
('180504', '数学1801班', NULL, 't05004'),
('180505', '数学1802班', NULL, NULL);

INSERT INTO teach_class VALUES 
('t05001', '180501', 'c05103'),
('t05001', '180501', 'c05108'),
('t05002', '180502', 'c05109'),
('t05003', '180503', 'c05127'),
('t05004', '180504', 'c05138');

-- 4.
INSERT INTO student VALUES ('180106', '孙八', '男', '2000-09-18', '180503', 81.0);

DELETE FROM student WHERE sno = '180106';

UPDATE student SET point = 90.0 WHERE sno = '180101';