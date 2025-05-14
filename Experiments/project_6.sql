DELIMITER $$

DROP PROCEDURE IF EXISTS ProcNum $$
CREATE PROCEDURE ProcNum()
BEGIN
    SELECT classno, COUNT(*) AS student_count
    FROM student
    GROUP BY classno
    ORDER BY classno ASC;
END $$

DELIMITER ;

---

DELIMITER $$

DROP PROCEDURE IF EXISTS ProcInsert $$
CREATE PROCEDURE ProcInsert(
    IN p_sno CHAR(8),
    IN p_courseno CHAR(6),
    IN p_daily DECIMAL(5,2),
    IN p_final DECIMAL(5,2)
)
BEGIN
    INSERT INTO score (sno, courseno, daily, final)
    VALUES (p_sno, p_courseno, p_daily, p_final);

    SELECT s.sname, c.cname, sc.daily, sc.final
    FROM student s
    JOIN score sc ON s.sno = sc.sno
    JOIN course c ON sc.courseno = c.courseno
    WHERE s.sno = p_sno;
END $$

DELIMITER ;

---
DELIMITER $$

DROP PROCEDURE IF EXISTS ProcAvg $$
CREATE PROCEDURE ProcAvg(
    IN p_classno CHAR(6),
    IN p_cname VARCHAR(40),
    OUT p_avg DECIMAL(5,2)
)
BEGIN
    SELECT AVG(s.final)
    INTO p_avg
    FROM score s
    JOIN student st ON s.sno = st.sno
    JOIN course c ON s.courseno = c.courseno
    WHERE st.classno = p_classno AND c.cname = p_cname;
END $$

DELIMITER ;

---
DELIMITER $$

DROP TRIGGER IF EXISTS trigsex_insert $$
CREATE TRIGGER trigsex_insert
BEFORE INSERT ON student
FOR EACH ROW
BEGIN
    IF NEW.sex NOT IN ('男', '女') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '性别只能是 男 或 女';
    END IF;
END $$

DROP TRIGGER IF EXISTS trigsex_update $$
CREATE TRIGGER trigsex_update
BEFORE UPDATE ON student
FOR EACH ROW
BEGIN
    IF NEW.sex NOT IN ('男', '女') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '性别只能是 男 或 女';
    END IF;
END $$

DELIMITER ;

---

DELIMITER $$

DROP TRIGGER IF EXISTS trigforeign_insert $$
CREATE TRIGGER trigforeign_insert
AFTER INSERT ON score
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM student WHERE sno = NEW.sno) THEN
        DELETE FROM score WHERE sno = NEW.sno AND courseno = NEW.courseno;
    END IF;
END $$

DROP TRIGGER IF EXISTS trigforeign_update $$
CREATE TRIGGER trigforeign_update
AFTER UPDATE ON score
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM student WHERE sno = NEW.sno) THEN
        DELETE FROM score WHERE sno = NEW.sno AND courseno = NEW.courseno;
    END IF;
END $$

DELIMITER ;


---
DELIMITER $$

DROP TRIGGER IF EXISTS trigclassname_insert $$
CREATE TRIGGER trigclassname_insert
BEFORE INSERT ON class
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM class WHERE classname = NEW.classname) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '班级名称重复，插入被回滚';
    END IF;
END $$

-- 检查触发器是否存在，若存在则删除
DROP TRIGGER IF EXISTS trigclassname;

DELIMITER $$

-- 创建触发器trigclassname
CREATE TRIGGER trigclassname
AFTER INSERT OR UPDATE ON class
FOR EACH ROW
BEGIN
    DECLARE classNameCount INT;
    
    SELECT COUNT(*)
    INTO classNameCount
    FROM class
    WHERE classname = NEW.classname
    AND classid != NEW.classid;
    
    IF classNameCount > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = '班级名称不能重复';
    END IF;
END$$

DELIMITER ;