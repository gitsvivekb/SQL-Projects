--Create new schema as alumni
CREATE DATABASE IF NOT EXISTS alumni;

--Import all.csv files into MySQL
   ALL FILES ARE IMPORTED 

--Run SQL command to see the structure of six tables --
USE alumni;
DESC College_A_HS;
DESC College_A_SE;
DESC College_A_SJ;
DESC College_B_HS;
DESC College_B_SE;
DESC College_B_SJ;

--Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values. 
CREATE VIEW College_A_HS_V AS 
SELECT * FROM College_A_HS 
WHERE RollNo IS NOT NULL AND 
LastUpdate IS NOT NULL AND 
NAME IS NOT NULL AND 
FatherName IS NOT NULL AND 
MotherName IS NOT NULL AND 
Batch IS NOT NULL AND 
Degree IS NOT NULL AND  
PresentStatus IS NOT NULL AND 
HSDegree IS NOT NULL AND  
EntranceExam IS NOT NULL AND 
Institute IS NOT NULL AND 
Location IS NOT NULL;


--Perform data cleaning on table College_A_SE and store cleaned data in view College_A_SE_V, Remove null values.
CREATE VIEW College_A_SE_V AS
SELECT * FROM College_A_SE 
WHERE RollNo IS NOT NULL AND 
LastUpdate IS NOT NULL AND 
Name IS NOT NULL AND 
FatherName IS NOT NULL AND  
MotherName IS NOT NULL AND 
Batch IS NOT NULL AND 
Degree IS NOT NULL AND  
PresentStatus IS NOT NULL AND 
Organization IS NOT NULL AND 
Location IS NOT NULL;

--Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null values.
CREATE VIEW College_A_SJ_V AS
SELECT * FROM College_A_SJ 
WHERE RollNo IS NOT NULL AND 
LastUpdate IS NOT NULL AND 
Name IS NOT NULL AND  
FatherName IS NOT NULL AND 
MotherName IS NOT NULL AND 
Batch IS NOT NULL AND 
Degree IS NOT NULL AND 
PresentStatus IS NOT NULL AND 
Organization IS NOT NULL AND 
Designation IS NOT NULL AND 
Location IS NOT NULL;

--Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_V, Remove null values.
CREATE VIEW College_B_HS_V AS
SELECT * FROM College_B_HS 
WHERE RollNo IS NOT NULL AND
LastUpdate IS NOT NULL AND 
Name IS NOT NULL AND 
FatherName IS NOT NULL AND
MotherName IS NOT NULL AND 
Branch IS NOT NULL AND
Batch IS NOT NULL AND 
Degree IS NOT NULL AND
PresentStatus IS NOT NULL AND
HSDegree IS NOT NULL AND
EntranceExam IS NOT NULL AND 
Institute IS NOT NULL AND 
Location IS NOT NULL;

-- .Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null values.
CREATE VIEW College_B_SE_V AS 
SELECT * FROM College_B_SE 
WHERE  RollNo IS NOT NULL AND 
LastUpdate IS NOT NULL AND  
Name IS NOT NULL AND 
FatherName IS NOT NULL AND 
MotherName IS NOT NULL AND 
Branch IS NOT NULL AND 
Batch IS NOT NULL AND 
Degree IS NOT NULL AND 
PresentStatus IS NOT NULL AND 
Organization IS NOT NULL AND 
Location IS NOT NULL;


--Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V, Remove null values.
CREATE VIEW College_B_SJ_V AS 
SELECT * FROM College_B_SJ 
WHERE RollNo IS NOT NULL AND
LastUpdate IS NOT NULL AND
Name IS NOT NULL AND
FatherName IS NOT NULL AND 
MotherName IS NOT NULL AND
Branch IS NOT NULL AND 
Batch IS NOT NULL AND
Degree IS NOT NULL AND
PresentStatus IS NOT NULL AND
Organization IS NOT NULL AND
Designation IS NOT NULL AND
Location IS NOT NULL;


--Make procedure to use string function/s for converting record of Name, FatherName, MotherName into lower case for views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) 
DELIMITER $
CREATE PROCEDURE V1()
BEGIN
SELECT lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
FROM College_A_HS_V;
END $
DELIMITER ;

CALL V1();

DELIMITER $
CREATE PROCEDURE V2()
BEGIN
SELECT lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
FROM College_A_SE_V;
END $
DELIMITER ;

CALL V2();

DELIMITER $
CREATE PROCEDURE V3()
BEGIN
SELECT lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
FROM College_A_SJ_V;
END $
DELIMITER ;

CALL V3();

DELIMITER $
CREATE PROCEDURE V4()
BEGIN
SELECT lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
FROM College_B_HS_V;
END $
DELIMITER ;

CALL V4();

DELIMITER $
CREATE PROCEDURE V5()
BEGIN
SELECT lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
FROM College_A_SE_V;
END $
DELIMITER ;

CALL V5();

DELIMITER $
CREATE PROCEDURE V6()
BEGIN
SELECT lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
FROM College_A_SJ_V;
END $
DELIMITER ;

CALL V6();



-- Write a query to create procedure get_name_collegeA using the cursor to fetch names of all students from college A.
DELIMITER $$
CREATE  PROCEDURE get_name_collegeA(INOUT n text(20000))
BEGIN
	DECLARE finished INT DEFAULT 0;
    DECLARE namelist VARCHAR(400) DEFAULT '';
    
    DECLARE namedetails CURSOR FOR
		SELECT Name FROM College_A_HS
		UNION
		SELECT Name FROM College_A_SE
		UNION
		SELECT Name FROM College_A_SJ;
        
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished =1;
    
    OPEN namedetails;
    getname:
    LOOP
		FETCH namedetails INTO namelist;
        IF finished = 1 THEN 
			LEAVE getname;
		END IF;
        
        SET n = CONCAT(namelist,';',n);
	END LOOP getname;
    CLOSE namedetails;
END$$
DELIMITER ;

SET @student_college_a ='';
CALL get_name_collegeA(@student_college_a);

SELECT @student_college_a;




--Write a query to create procedure get_name_collegeB using the cursor to fetch names of all students from college B.
DELIMITER $$
CREATE  PROCEDURE get_name_collegeB(INOUT n text(20000))
BEGIN
	DECLARE finished INT DEFAULT 0;
    DECLARE namelist VARCHAR(400) DEFAULT '';
    
    DECLARE namedetails CURSOR FOR
		SELECT Name FROM College_B_HS
		UNION
		SELECT Name FROM College_B_SE
		UNION
		SELECT Name FROM College_B_SJ;
        
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished =1;
    
    OPEN namedetails;
    getname:
    LOOP
		FETCH namedetails INTO namelist;
        IF finished = 1 THEN 
			LEAVE getname;
		END IF;
        
        SET n = CONCAT(namelist,';',n);
	END LOOP getname;
    CLOSE namedetails;
END $$
DELIMITER ; 

SET @student_college_b ='';
CALL get_name_collegeB(@student_college_b);

SELECT @student_college_b;

-- Calculate the percentage of career choice of College A and College B Alumni
-- (w.r.t Higher Studies, Self Employed and Service/Job)
-- Note: Approximate percentages are considered for career choices.
SELECT COUNT(*) FROM college_a_hs;
SELECT COUNT(*) FROM college_a_se;
SELECT COUNT(*) FROM college_a_sj;

SELECT((SELECT COUNT(*) FROM college_a_hs)+(SELECT COUNT(*) FROM college_a_se)+(SELECT COUNT(*) FROM college_a_sj)) TOTAL;
-- 5887

SELECT COUNT(*) FROM college_b_hs;
SELECT COUNT(*) FROM college_b_se;
SELECT COUNT(*) FROM college_b_sj;

SELECT((SELECT COUNT(*) FROM college_b_hs)+(SELECT COUNT(*) FROM college_b_se)+(SELECT COUNT(*) FROM college_b_sj)) TOTALB;
-- 2259

SELECT 'Higher Studies',(SELECT COUNT(*) / 5887 * 100 FROM college_a_hs)'College A Percentage',
(SELECT COUNT(*) / 2259 * 100 FROM college_b_hs) 'College B Percentage'
UNION
SELECT 'Self Employed',(SELECT COUNT(*) / 5887 * 100 FROM college_a_se)'College A Percentage',
(SELECT COUNT(*) / 2259 * 100 FROM college_b_se) 'College B Percentage'
UNION
SELECT 'Service Job',(SELECT COUNT(*) / 5887 * 100 FROM college_a_sj)'College A Percentage',
(SELECT COUNT(*) / 2259 * 100 FROM college_b_sj) 'College B Percentage';
