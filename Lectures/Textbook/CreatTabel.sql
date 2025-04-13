-- Active: 1736786939860@@127.0.0.1@3306@teaching
CREATE TABLE IF NOT EXISTS student (
    studentno CHAR(11) NOT NULL COMMENT '学生学号',
    sname CHAR(8) NOT NULL COMMENT '学生姓名',
    sex ENUM('男', '女') DEFAULT '男' COMMENT '学生性别',
    birthdate DATE NOT NULL COMMENT '出生日期',
    entrance INT(3) NULL COMMENT '入学成绩',
    phone VARCHAR(12) NOT NULL COMMENT '电话',
    email VARCHAR(20) NOT NULL COMMENT '电子邮件',
    PRIMARY KEY (studentno)
);

CREATE TABLE IF NOT EXISTS course (
    courseno CHAR(6) NOT NULL,
    cname CHAR(6) NOT NULL,
    type CHAR(8) NOT NULL,
    period INT(2) NOT NULL,
    exp INT(2) NOT NULL,
    term INT(2) NOT NULL,
    PRIMARY KEY (courseno)
);

CREATE TABLE IF NOT EXISTS score(
    studentno CHAR(11) NOT NULL,
    courseno CHAR(6) NOT NULL,
    daily FLOAT(4,1) DEFAULT 0,
    final FLOAT(4,1) DEFAULT 0,
    PRIMARY KEY (studentno, courseno)
);

CREATE TABLE IF NOT EXISTS teacher (
    teacherno CHAR(6) NOT NULL COMMENT '教师号',
    tname CHAR(8) NOT NULL COMMENT'教师名字',
    major CHAR(10) NOT NULL COMMENT'专业',
    prof CHAR(10) NOT NULL COMMENT'职称',
    department CHAR(16) NOT NULL COMMENT'院系部门',
    PRIMARY KEY (teacherno)
);

CREATE TABLE IF NOT EXISTS teach_course(
    teacherno CHAR(6) NOT NULL,
    courseno CHAR(6) NOT NULL,
    PRIMARY KEY (teacherno, courseno)
);

CREATE TABLE IF NOT EXISTS sc(
    sc_no INT(6) NOT NULL AUTO_INCREMENT,
    studentno CHAR(11) NOT NULL,
    courseno CHAR(6) NOT NULL,
    teacherno CHAR(6) NOT NULL,
    score FLOAT(4,1) NULL,
    sc_time TIMESTAMP NOT NULL DEFAULT now(),
    PRIMARY KEY(sc_no)
);