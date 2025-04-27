USE teaching;

ALTER TABLE score
ADD CONSTRAINT fk_score_courseno
FOREIGN KEY (courseno) REFERENCES course(courseno);

ALTER TABLE class
ADD CONSTRAINT unique_classname
UNIQUE (classname);

ALTER TABLE student
ADD CONSTRAINT check_student_age
CHECK (YEAR(CURRENT_DATE) - YEAR(birthdate) BETWEEN 17 AND 25);

ALTER TABLE course
ADD CONSTRAINT check_course_credit
CHECK (credit BETWEEN 1 AND 6);

ALTER TABLE student
DROP CONSTRAINT check_student_age;

ALTER TABLE course
DROP CONSTRAINT check_course_credit;

ALTER TABLE teacher
MODIFY COLUMN prof ENUM('助教', '讲师', '副教授', '教授');

