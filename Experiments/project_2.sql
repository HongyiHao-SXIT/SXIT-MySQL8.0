-- 使用teaching数据库
USE teaching;

-- (1) 利用MySQL将teaching数据库中score表的courseno列设置为引用表course的外键
-- 为score表添加外键约束
ALTER TABLE score
ADD CONSTRAINT fk_score_courseno
FOREIGN KEY (courseno) REFERENCES course(courseno);

-- (2) 在teaching数据库中class表的classname创建UNIQUE约束
-- 为class表的classname列添加唯一约束
ALTER TABLE class
ADD CONSTRAINT unique_classname
UNIQUE (classname);

-- (3) 为teaching数据库中student表的birthday列创建check约束,规定学生的年龄在17~25之间,
-- 为course表的credit列创建check约束,规定学分的取值范围为1~6,删除check约束

-- 为student表的birthdate列（你之前是birthday，这里假设是birthdate，按常见日期字段名处理）添加check约束
-- 计算年龄的逻辑假设当前年份为2024年，你可以根据实际情况修改
ALTER TABLE student
ADD CONSTRAINT check_student_age
CHECK (YEAR(CURRENT_DATE) - YEAR(birthdate) BETWEEN 17 AND 25);

-- 假设course表存在credit列（你之前提到为course表的credit列创建约束，若实际没有该列需先添加）
-- 为course表的credit列添加check约束
ALTER TABLE course
ADD CONSTRAINT check_course_credit
CHECK (credit BETWEEN 1 AND 6);

-- 删除student表的check约束
ALTER TABLE student
DROP CONSTRAINT check_student_age;

-- 删除course表的check约束
ALTER TABLE course
DROP CONSTRAINT check_course_credit;

-- (4) 为teaching数据库创建规则prof_rule,规定教师职称取值只能为”助教”、“讲师”、“副教授”、“教授”，
-- 并将其绑定到teacher表的Prof列，删除创建的规则
-- MySQL 本身不直接支持规则（rule）的概念，我们可以通过 ENUM 数据类型来实现类似功能
-- 修改teacher表的prof列，使用ENUM数据类型来限制取值
ALTER TABLE teacher
MODIFY COLUMN prof ENUM('助教', '讲师', '副教授', '教授');

-- 如果后续想移除这种限制，可以再次修改列的数据类型
-- 例如，将其改为普通的 VARCHAR 类型
-- ALTER TABLE teacher
-- MODIFY COLUMN prof VARCHAR(10);