USE teaching;

ALTER TABLE score
ADD CONSTRAINT fk_score_courseno
FOREIGN KEY (courseno) REFERENCES course(courseno);

ALTER TABLE class
ADD CONSTRAINT unique_classname
UNIQUE (classname);

ALTER TABLE student ADD COLUMN age INT;
UPDATE student
SET age = YEAR(CURRENT_DATE) - YEAR(birthday);
ALTER TABLE student
ADD CONSTRAINT check_student_age
CHECK (YEAR(CURRENT_DATE) - YEAR(birthday) BETWEEN 17 AND 25);

ALTER TABLE course
ADD CONSTRAINT check_course_credit
CHECK (credit BETWEEN 1 AND 6);

ALTER TABLE student
DROP CONSTRAINT check_student_age;

ALTER TABLE course
DROP CONSTRAINT check_course_credit;

ALTER TABLE teacher
MODIFY COLUMN prof ENUM('助教', '讲师', '副教授', '教授');

DELIMITER //

CREATE TRIGGER trg_check_birthday
BEFORE INSERT ON student
FOR EACH ROW
BEGIN
  IF TIMESTAMPDIFF(YEAR, NEW.birthday, CURDATE()) < 17 OR 
     TIMESTAMPDIFF(YEAR, NEW.birthday, CURDATE()) > 25 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = '年龄必须在17到25岁之间';
  END IF;
END;
//

DELIMITER ;
