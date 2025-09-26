SELECT s.name
,s.deptno1
,d.dname
FROM student s
JOIN department d
ON s.deptno1 = d.deptno;

SELECT s.name
,s.deptno1
,d.dname
FROM student s, department d
WHERE s.deptno1 = d.deptno;

-- DDL 0926
SELECT *
FROM tab;

SELECT *
FROM new_table1;
ALTER TABLE new_table1 ADD info GENERATED ALWAYS AS (no || '-' || name);

ROLLBACK;

-- Be cautious
DELETE FROM new_table1  
WHERE no = 1;

SELECT *
FROM user_recyclebin;  -- recyclebin

FLASHBACK TABLE new_table1 TO BEFORE DROP;  　

CREATE TABLE new_emp
( no NUMBER(4)
  CONSTRAINT emp_no_pk PRIMARY KEY,
name VARCHAR2(20)
  CONSTRAINT emp_name_nn NOT NULL,
jumin VARCHAR2(13)
  CONSTRAINT emp_jumin_nn NOT NULL
  CONSTRAINT emp_jumin_uk UNIQUE,
loc_code NUMBER(1)
  CONSTRAINT emp_area_ck CHECK (loc_code <5),
deptno NUMBER(2) 
  CONSTRAINT emp_dept_fk REFERENCE dept(deptno)
);

CREATE TABLE new_table1(
    no NUMBER(3) PRIMARY KEY,   -- Membership No 1~999
    name VARCHAR2(100) NOT NULL,  -- Name 0000000000...00000
    birth DATE DEFAULT SYSDATE  -- TO_DATE('2025/09/26', 'RRRR/MM/DD)
);
ALTER TABLE new_table1
ADD phone VARCHAR2(20);
ALTER TABLE new_table1 RENAME COLUMN phone TO tel;
ALTER TABLE new_table1 MODIFY tel VARCHAR2(30);

ALTER TABLE new_table1 READ ONLY; -- 21c    NOT function in 11g
    
INSERT INTO new_table1 (no, name, birth)
VALUES(1, 'DDD', '2011/01/01');

-- Be cautious
UPDATE new_table1  -- UPDATE
SET phone = '010-9876-5432'
    ,birth = TO_DATE('2002/02/02', 'RRRR/MM/DD')  -- Standard Procedure　
--WHERE no = 2;   -- Conditional Statement

DESC new_table1;  -- Check Table Structure

ALTER TABLE new_table1 DROP COLUMN tel;

-- Be cautious
TRUNCATE TABLE new_table1;   -- Delete Data
DROP TABLE new_table1;    -- Delete Table

------------------------------------------------
--DML
SELECT *
FROM dept2
ORDER BY dcode;
DESC dept2;

INSERT INTO dept2 (dcode, dname, pdept, area) -- Insert new data 
VALUES('9000', 'temp_1', '1006', 'temp area');

CREATE TABLE professor3  -- CTAS = duplicate
AS
SELECT *
FROM professor
WHERE 1 = 2;         

INSERT INTO professor3 -- ITAS 
SELECT *
FROM professor;

SELECT *
FROM professor3;

CREATE TABLE prof_1 (
 profno NUMBER,
 name VARCHAR2(25));
 
CREATE TABLE prof_2 (
 profno NUMBER,
 name VARCHAR2(25));
 
INSERT ALL          
 WHEN profno BETWEEN 1000 AND 1999 THEN
  INTO prof_1 VALUES (profno, name)
 WHEN profno BETWEEN 2000 AND 2999 THEN
  INTO prof_2 VALUES (profno, name)
SELECT profno, name
FROM professor;

SELECT *
FROM prof_1;
SELECT *
FROM prof_2;

INSERT ALL          
  INTO prof_1 VALUES (profno, name) 
  INTO prof_2 VALUES (profno, name)
SELECT profno
,name
FROM professor;

SELECT *
FROM professor;

-- Be cautious
UPDATE professor
SET bonus = DECODE(bonus, null, 100, bonus)
,pay = pay + (pay * 0.1)
WHERE 1 = 1;

-- Be cautious
DELETE FROM professor
WHERE hpage IS not null;

-- DELETE dept　
SELECT *
FROM dept;

SELECT *
FROM emp;
 
SELECT * 
FROM emp
WHERE deptno = 30;

UPDATE emp
SET deptno = 50
WHERE deptno = 20; 

SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno;

-- EXISTS   true or false
UPDATE emp e
SET sal = sal + 100
WHERE EXISTS (SELECT 1
FROM dept d
WHERE e.deptno = d.deptno
AND d.loc = 'DALLAS');

-- d.loc is not 'DALLAS'
WHERE NOT EXISTS (SELECT 1
FROM dept d
WHERE e.deptno = d.deptno
AND d.loc = 'DALLAS');

CREATE TABLE new_emp1 (
no NUMBER(4) CONSTRAINT emp1_no_pk PRIMARY KEY,
name VARCHAR2(20) CONSTRAINT emp1_name_nn NOT NULL,
jumin VARCHAR2(13) CONSTRAINT emp1_jumin_nn NOT NULL
CONSTRAINT emp1_jumin_uk UNIQUE,
loc_code NUMBER(1) CONSTRAINT emp1_area_ck CHECK (loc_code < 5),
deptno VARCHAR2(6) CONSTRAINT emp1_deptno_fk REFERENCES dept2(dcode)
);

-- Bulletin board 게시판
-- Oracle Server -- Web Server(Node.js) -- Client(fetch)
SELECT *
FROM emp;

















































































































































































































