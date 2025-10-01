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

-- Bulletin board  掲示板
-- Oracle Server -- Web Server(Node.js) -- Client(fetch)
SELECT *
FROM emp;

-- 0926復習

CREATE TABLE new_table4 (
no NUMBER(3),
name VARCHAR2(10),
birth DATE);

SELECT *
FROM new_table4;

CREATE TABLE new_table5
AS
SELECT *
FROM new_table4;

SELECT *
FROM new_table4;
ALTER TABLE new_table5 ADD (location VARCHAR2(10));
ALTER TABLE new_table5 RENAME COLUMN gender TO region;

DESC new_table5;
ALTER TABLE new_table5
MODIFY(birth VARCHAR2(20));

TRUNCATE TABLE new_table5;

DROP TABLE new_table5;

--ALTER TABLE new_table4 READ ONLY;
INSERT INTO dept2 (dcode, dname, pdept, area)
VALUES(9000, 'あ', 101, ' 大阪');

SELECT *
FROM dept2;

SELECT MAX(sal + NVL(comm, 0)) 
,MIN(sal + NVL(comm, 0))
,ROUND(AVG(sal + NVL(comm, 0)))
FROM emp;

SELECT *
FROM emp;

SELECT TO_CHAR(birthday, 'MM') AS "MONTH"
,COUNT(birthday)||'EA' AS "NUMBER"
FROM student
GROUP BY TO_CHAR(birthday, 'MM')
ORDER BY 1;


DESC student;

SELECT COUNT(*)
FROM student;

INSERT INTO emp(empno, ename, job, hiredate, deptno)
VALUES (9999, 'KIM', 'SALESMAN', TO_DATE('1982/03/01','RRRR/MM/DD'), 30);


-- 個人プロジェクト
--UPDATE 
--set 
--WHERE

SELECT *
FROM emp;

-- sal -> 1000
UPDATE emp
SET sal = 1000
WHERE sal < 1000;

-- salesman -> comm 500 
UPDATE emp
SET comm = 500
WHERE job = 'SALESMAN'
AND comm < 500;

-- 1981/01~06/上半期に入社 =　賃金引上げ１０％
UPDATE emp
SET sal = sal + (sal * 0.1)
WHERE hiredate BETWEEN TO_DATE('1981/01/01','RRRR/MM/DD') AND TO_DATE('1981/06/30','RRRR/MM/DD');

SELECT *
FROM student;

-- 'Rene Russo'の担当教授の番号, 名前, positionを確認
SELECT p.profno, p.name, p.position
FROM professor p
JOIN student s
ON p.profno = s.profno
WHERE s.name = 'Rene Russo';

-- 'Computer Engineering' => 
SELECT *
FROM department;
SELECT *
FROM student;

-- 　専攻と副専攻が　'Computer Engineering'である人
SELECT s.studno, s.name, s.deptno1, s.deptno2
FROM student s
JOIN department d
ON s.deptno1 = d.deptno
OR s.deptno2 = d.deptno
WHERE s.deptno1 = 101
OR s.deptno2 = 101;

-- 'Computer Engineering'の学生の担当教授 , position　重複
SELECT DISTINCT p.profno, p.name, p.position
FROM professor p
JOIN student s
ON p.profno = s.profno
JOIN department d
ON s.deptno1 = d.deptno
WHERE d.dname = 'Computer Engineering';

SELECT *
FROM student;


--  担当教授のpositionが assistant professor
SELECT s.name "STUDENT", p.name "PROFESSOR", s.profno, p.position
FROM student s
JOIN professor p
    ON s.profno = p.profno
    WHERE p.position = 'assistant professor';

-- 'Computer Engineering'学科の AVG('WEIGHT')
SELECT *
FROM student s1
WHERE s1.weight > (SELECT AVG(s.weight)
                    FROM student s
                    JOIN department d
                    ON s.deptno1 = d.deptno
                    WHERE d.dname = 'Computer Engineering');
                    
-- 'Electronic Engineering'学科の担当教授 
-- SubQuery

SELECT *
FROM professor p1
WHERE p1.position IN (SELECT p.position
                    FROM professor p
                    JOIN student s
                    ON p.profno = s.profno
                    JOIN department d
                    ON s.deptno1 = d.deptno
                    WHERE d.dname = 'Electronic Engineering');
                    
                    
--  平均給料の以上をもらっている教授番号と名前
SELECT p1.profno, p1.name
FROM professor p1
WHERE p1.pay > (SELECT AVG(pay)
                FROM professor p);

-- bonus値が nullである人の中で hiredateが最も早い人/ よりも入社が早い人
SELECT *
FROM professor p1
WHERE p1.hiredate < (SELECT MIN(p.hiredate)
                    FROM professor p
                    WHERE p.bonus IS NULL);

-- bonus が nullであれば給料10%賃上げ bonusがある人は bonusを 10%上昇
UPDATE professor
SET pay = pay + (pay * 0.1)
WHERE bonus IS NOT NULL
AND pay < (SELECT MAX(pay)
FROM professor
WHERE bonus IS NULL;

SELECT *
FROM professor
ORDER BY hiredate;

SELECT e.ename, e.job, e.deptno, d.dname
FROM emp e
JOIN dept d
ON e.deptno = d.deptno;

SELECT *
FROM dept;

-- view
CREATE OR REPLACE VIEW emp_dept_v
AS
SELECT empno, ename, job, sal, e.deptno, dname, comm
FROM emp e
JOIN dept d
ON e.deptno = d.deptno;

SELECT *
FROM emp_dept_v;

SELECT e.*, d.*
FROM emp e
JOIN dept d
ON e.deptno = d.deptno
WHERE e.ename = DECODE('ALL', 'ALL', ename, 'ALL')
AND e.job = DECODE('ALL', 'ALL', job, 'ALL')
AND e.deptno = DECODE(-1, -1, e.deptno, -1);

CREATE OR REPLACE VIEW emp_v
AS
SELECT empno, ename, job, deptno
FROM emp;

SELECT *
FROM emp_v;

UPDATE emp_v
SET ename = '', deptno = ''
WHERE empno = '9999';


-- student, profno, view / view = TABLE
CREATE OR REPLACE VIEW stud_prof_v
AS
SELECT s.studno
  , s.name "STUDENT"
  , s.birthday
  , s.tel
  , s.deptno1 "DEPTNO"
  , p.profno
  , p.name "PROFESSOR"
  , position, email
FROM student s
LEFT OUTER JOIN professor p
ON s.profno = p.profno;

SELECT *
FROM stud_prof_v;

SELECT position, COUNT(*)
FROM stud_prof_v v
JOIN department d
ON v.deptno = d.deptno
--WHERE position = 'a full professor'
GROUP BY position;

CREATE TABLE board_t (
board_no NUMBER(5) PRIMARY KEY,
title VARCHAR2(100) NOT NULL,
content VARCHAR2(1000) NOT NULL,
writer VARCHAR2(50) NOT NULL,
write_date DATE DEFAULT SYSDATE,
likes NUMBER(3) DEFAULT 0);

SELECT *
FROM board_t;

INSERT INTO board_t VALUES 
(board_t_seq.NEXTVAL, '게시판글연습', '게시판이 잘 되는지 연습합니다', '김동우','','');
INSERT INTO board_t VALUES
(board_t_seq.NEXTVAL, 'SQL수업', 'JOIN구문 게시판', '핫케이크', TO_DATE('2025/09/29','RRRR/MM/DD'),'');
INSERT INTO board_t VALUES
(board_t_seq.NEXTVAL, '컴퓨터title', '컴퓨터content', '컴퓨터writer', TO_DATE('2025/09/28','RRRR/MM/DD'), 10);
INSERT INTO board_t VALUES
(board_t_seq.NEXTVAL, 'HELLO', 'GOOD EVENING', '치킨', TO_DATE('2025/09/27','RRRR/MM/DD'), 30);

DELETE FROM board_t;

-- sequence 시퀀스 사용
CREATE SEQUENCE board_t_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 9999999999
MINVALUE 1
CYCLE;

DROP SEQUENCE board_t_seq;
SELECT board_t_seq.NEXTVAL FROM dual;

INSERT INTO board_t (board_no, title, content, writer)
SELECT board_t_seq.NEXTVAL, title, content, writer
FROM board_t;

ALTER TABLE board_t
MODIFY board_no NUMBER(10);

SELECT deptno, job, AVG(NVL(sal,0)) "AVG"
FROM emp
GROUP BY deptno, job
ORDER BY 1,2;

SELECT deptno, AVG(NVL(sal,0))
FROM emp
WHERE deptno > 10
GROUP BY deptno
HAVING AVG(NVL(sal,0)) > 2000;

SELECT deptno, NULL job, ROUND(AVG(sal),1)avg_sal, COUNT(*) cnt_emp
FROM emp
GROUP BY deptno
UNION ALL
SELECT deptno, job, ROUND(AVG(sal),1) avg_sal, COUNT(*) cnt_emp
FROM emp
GROUP BY deptno, job
UNION ALL
SELECT NULL deptno, NULL job, ROUND(AVG(sal),1) avg_sal, COUNT(*) cnt_emp
FROM emp
ORDER BY deptno, job;

SELECT deptno, position, COUNT(*), SUM(pay)
FROM professor
GROUP BY position, ROLLUP(deptno);

SELECT deptno, job, ROUND(AVG(sal),1), COUNT(*)
FROM emp
GROUP BY CUBE(deptno, job)
ORDER BY deptno, job;

SELECT e.empno, e.ename, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

SELECT s.name "学生", p.name　"教授"
FROM student s
JOIN professor p
ON s.profno = p.profno;

SELECT s.name, p.name
FROM student s
JOIN professor p
ON s.profno = p.profno
WHERE s.deptno1 = 101;

SELECT COUNT(comm), SUM(comm), TRUNC(AVG(comm))
FROM emp;

















