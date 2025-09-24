--SELECT  empno  as  "사원번호"   --  별명 별칭 (alias)
--                 ,ename  as   "사원명"
--                 ,'Good Morning !!'  | |  ename  as  "welcome 메세지"-- 연결하고 싶을 때는 | |    
--                 ,ename  | |  ' ''의 급여 '  | |  sal  as "급여"  -- 영문일 경우  KIM's salary
--FROM  emp; 
-- SELECT 는 FROM과 같이 씀

--SELECT  empno
--,hiredate  as  "hd"
--FROM  emp;

--  DISTINCT 중복된 값을 제거  ORDER BY 정렬 DESC 역순
--SELECT  DISTINCT    job,    deptno
--FROM    emp
--ORDER BY    job DESC;


--SELECT name|| ' ''s ID : ' || id|| 'WEIGHT is' || weight || 'kg' 
--AS "ID AND WEIGHT"
--FROM student;
--
--SELECT ename || ' ( ' ||  job || '), ' || ename || '''' || job || ''''
--AS "NAME AND JOB"
--FROM emp;
--
--SELECT ename || ' ''s  salary is $' || sal
--AS "Name And Sal"
--FROM emp;
--
---- 조건절 conditional expression
--SELECT empno
--, ename
--, job
--, mgr
--, hiredate
--, sal + comm AS "Salary"
----, comm
--, deptno
--FROM emp
--WHERE empno >= 7900 AND empno < 8000 AND hiredate > '82/01/01';
---- LIKE '% ABC %' ABC 가 포함된 
---- 날짜를 조회할 때는 '' 작은 따옴표 안에 

--SELECT *
--FROM professor
--WHERE email LIKE '%naver.com%';
--WHERE pay + bonus >= 300 OR pay >= 300;
--WHERE 1=1 AND pay + NVL (bonus, 0) >= 300; 
--
--SELECT profno
--, LOWER (name) AS "low_name"
--, UPPER (id) AS "upp_id"
--, INITCAP (position) AS "pos"
--, pay
--, CONCAT(CONCAT (name, ' - '), id ) AS "name_id"
--FROM professor
--WHERE LENGTH (name) != 10;

--SELECT name
--, LENGTH (name) AS "length"
--, LENGTHB ('가나다') AS "lengthB"
--, SUBSTR (name, 1, 5) AS "substr"
--, INSTR (name, 'a') AS "instr"
--, pay
--, bonus
--, LTRIM(LPAD (id, 10, '*'), '*') AS "rpad"
--, TRIM('                                       Hello, World                             ')  AS  "str"
--, REPLACE ('Hello', 'H', 'h') AS "rep"
--FROM professor
--WHERE INSTR (UPPER (name) , 'A') > 0;

SELECT name
, tel
, SUBSTR(tel, 1, INSTR(tel, ')') -1) AS "AREA CODE"
FROM student
WHERE deptno1 = 201;

SELECT ename
, REPLACE(ename, SUBSTR(ename, 2, 2), ' - - ') AS "replace"
FROM emp;

SELECT name
, jumin
, RPAD(SUBSTR(jumin, 1, 6), 20, ' - /') AS "replace"
FROM student
WHERE deptno1 = 101;

SELECT name
, jumin
, REPLACE(jumin, SUBSTR(jumin, 7, 7), ' -/-/-/- ') AS "replace"
FROM student
WHERE deptno1 = 101;

SELECT name
, tel
, REPLACE(tel, SUBSTR(tel, 5,3), '***') AS "replace"
FROM student
WHERE deptno1 = 102;

SELECT name
, tel
, REPLACE(tel, SUBSTR(tel, 9, 4), '****') AS "replace"
FROM student
WHERE deptno1 = 101;

SELECT empno
, ename
, job
, ROUND(sal / 12, 1) AS "month"
, TRUNC(sal / 12) AS "trunc"
, MOD(sal , 12) AS "mod"
, CEIL(sal / 12) AS "ceil"
,  FLOOR(sal / 12) AS "floor"
, POWER(sal , 2) AS "power"
FROM emp;

--SELECT MONTHS_BETWEEN('16/01/01','15/01/01')
--FROM dual;
-- dual 더미 데이터 RRRR/MM/DD HH:24 MI SS

CHAR(2000)                   ->   '       3' '1st'
VARCHAR2(4000)       -> ' 3 '
NUMBER(10, 2) 12345678.90

SELECT ADD_MONTHS(sysdate, 2), NEXT_DAY(sysdate+1, '목') AS "next_day"
, LAST_DAY(ADD_MONTHS(sysdate, 1)) AS "last"
FROM dual;

SELECT sysdate, TO_CHAR (sysdate, 'RRRR/MM/DD') AS "today"
FROM dual;

SELECT TO_DATE('2025-05-05', 'RRRR-MM-DD')
FROM dual;






































