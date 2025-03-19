-- ??1??????????student
-- student????
create table if not exists student (
    studentno  char(11) not null comment '???', 
    sname char(8) not null comment '????', 
    sex enum('??', '?') default '??' comment '???', 
    birthdate date not null comment '????????', 
    entrance int(3)  null comment '??????',		 
    phone varchar(12) not null comment '?朝', 
    Email varchar(20) not null comment '????????',
    primary key (studentno)
);

-- ???? student ??????
INSERT INTO student (studentno, sname, sex, birthdate, entrance, phone, Email)
VALUES 
('20112100072', '??????', '??', '2002-02-04', 658, '12545678998', 'su12@163.com'),
('20112111208', '??????', '?', '2002-02-14', 666, '15878945612', 'han@163.com'),
('20120203567', '????', '?', '2003-09-09', 898, '13245674564', 'feng@126.com'),
('20120210009', '?????', '??', '2002-11-05', 789, '13623456778', 'cui@163.com'),
('20123567897', '?????', '?', '2003-08-04', 879, '13175689345', 'pinan@163.com'),
('20125121109', '????', '?', '2002-09-03', 777, '13145678921', 'bing@126.com'),
('20126113307', '?????', '?', '2003-09-07', 787, '13245678543', 'zhu@163.com'),
('21125111109', '??????', '??', '2004-03-01', 789, '15678945623', 'jing@sina.com'),
('21125221327', '????', '?', '2004-12-04', 879, '13178978999', 'he@sina.com'),
('21131133071', '??????', '??', '2002-06-06', 787, '15556845645', 'cui@126.com'),
('21135222201', '?????', '?', '2005-10-06', 867, '15978945645', 'xia@163.com'),
('21137221508', '?????', '??', '2005-02-13', 789, '12367823453', 'ping@163.com');

-- ??2???污??????course
-- course????
create table if not exists course (
    courseno  char(6) not null, 
    cname  char(6) not null, 
    type char(8) not null,  
    period int(2) not null, 
    exp int(2) not null,
    term int(2) not null,
    primary key (courseno)
); 

-- ???? course ??????
INSERT INTO course (courseno, cname, type, period, exp, term)
VALUES 
('c05103', '??????', '????', 64, 16, 2),
('c05109', 'C????', '????', 48, 16, 2),
('c05127', '?????', '????', 64, 16, 2),
('c05138', '????????', '???', 48, 8, 5),
('c06108', '??快???', '????', 60, 8, 2),
('c06127', '??快???', '????', 64, 8, 3),
('c06172', '??????', '???', 42, 16, 6),
('c08106', '???‾?', '????', 48, 0, 7),
('c08123', '?????', '????', 40, 0, 5),
('c08171', '???????', '???', 32, 8, 8);

-- ??3??????????score
-- score????
create table if not exists score(
    studentno  char(11) not null, 
    courseno  char(6) not null, 
    daily float(4,1) default 0, 
    final float(4,1) default 0,
    primary key (studentno , courseno) 
); 

-- ???? score ??????
INSERT INTO score (studentno, courseno, daily, final)
VALUES 
('20112100072', 'c05103', 99, 92),
('20120203567', 'c05103', 78, 67),
('20120210009', 'c05103', 65, 98),
('20125121109', 'c05103', 88, 79),
('21125111109', 'c05103', 96, 97),
('21137221508', 'c05103', 77, 92),
('20112100072', 'c05109', 95, 82),
('20120203567', 'c05109', 87, 86),
('20125121109', 'c05109', 77, 82),
('20126113307', 'c05109', 89, 95),
('21125111109', 'c05109', 87, 82),
('21125221327', 'c05109', 89, 95),
('20120210009', 'c05138', 88, 89),
('21137221508', 'c05138', 74, 91),
('20112111208', 'c06108', 77, 82),
('20120210009', 'c06108', 79, 88),
('20123567897', 'c06108', 99, 99),
('20126113307', 'c06108', 78, 67),
('20112111208', 'c06127', 85, 91),
('20120203567', 'c06127', 97, 97),
('20112111208', 'c06172', 89, 95),
('21125221327', 'c06172', 88, 62),
('21131133071', 'c06172', 78, 95),
('21125111109', 'c08106', 77, 91),
('21135222201', 'c08106', 91, 77),
('21137221508', 'c08106', 89, 62),
('21131133071', 'c08123', 78, 89),
('21135222201', 'c08123', 79, 99),
('20112100072', 'c08171', 82, 69),
('20125121109', 'c08171', 85, 91),
('21131133071', 'c08171', 88, 98),
('21135222201', 'c08171', 85, 92);

-- ??4??????????teacher
-- teacher????
create table if not exists teacher (
    teacherno  char(6) not null comment '??????', 
    tname  char(8) not null comment '???????', 
    major  char(10) not null comment '??', 
    prof char(10) not null comment '???',
    department char(16) not null comment '????',
    primary key (teacherno)
); 

-- ???? teacher ??????
INSERT INTO teacher (teacherno, tname, major, prof, department)
VALUES 
('t05001', '????', '????????', '????', '???????'),
('t05002', '?????', '????', '????', '??????'),
('t05003', '?????', '???��?', '????', '???????'),
('t05011', '?????', '????????', '??????', '???????'),
('t05017', '谷???', '????????', '???', '???????'),
('t06011', '??????', '??快????', '????', '??快??'),
('t06023', '?????', '??????', '??????', '??快??'),
('t07019', '?????', '???迄???', '???', '??????'),
('t08017', '????', '???????', '??????', '??????'),
('t08058', '???忱?', '??????', '??????', '???????');

-- ??5???????teach_course
-- teach_course????
create table if not exists teach_course (
    teacherno char(6) not null, 
    courseno  char(6) not null, 
    primary key (teacherno,courseno) 
);

-- ???? teach_course ??????
INSERT INTO teach_course (teacherno, courseno)
VALUES 
('t05001', 'c05103'),
('t05002', 'c05109'),
('t05003', 'c05127'),
('t05011', 'c05138'),
('t05017', 'c06108'),
('t05017', 'c06172'),
('t06011', 'c06127'),
('t06023', 'c05127'),
('t06023', 'c06172'),
('t07019', 'c08106'),
('t08017', 'c08123'),
('t08058', 'c08171');

-- ??6??????????se_course
-- se_course????
create table se_course (
    sc_no int(6) not null auto_increment, 
    studentno  char(11) not null, 
    courseno  char(6) not null, 
    teacherno char(6) not null,  
    score   int(3)    null,
    sc_time timestamp not null default now(), 
    primary key (sc_no)
);

-- ???? se_course ??????
INSERT INTO se_course (studentno, courseno, teacherno, score, sc_time)
VALUES 
('21125111109', 'c06172', 't05017', NULL, '2020-12-09 18:33:45'),
('20120210009', 'c06108', 't06023', NULL, '2020-12-24 18:30:15'),
-- ???????? '20123567897','t01239','t05003' ????????courseno ???????????? t01239 ?? courseno ???????????∼???????????????????????????
('20123567897', 't05003', 't05003', NULL, '2020-12-26 18:09:09');