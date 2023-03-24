SELECT *
FROM v$option WHERE value = 'TRUE'
;

SELECT *
FROM v$version
;

SELECT *
FROM v$session
;

SELECT *
FROM v$parameter
;

CREATE TABLE DEPT_TCL
	AS (SELECT * FROM DEPT)
	;
	
SELECT *
FROM DEPT_TCL;

INSERT INTO DEPT_TCL
VALUES (50, 'DATABASE', 'SEOUL')
;


DELETE FROM DEPT_TCL
WHERE DNAME = 'RESEARCH'
;



UPDATE DEPT_TCL 
SET LOC = 'BUSAN'
WHERE DEPTNO =40
;

ROLLBACK;

--CO,,IT실행하는 경우

INSERT INTO DEPT_TCL 
VALUES (50,'NETWORK','SEOUL')
;

UPDATE DEPT_TCL SET LOC = 'BUSAN'
WHERE DEPTNO = 20
;

DELETE FROM DEPT_TCL
WHERE DEPTNO =40
;

SELECT * FROM 
DEPT_TCL;

COMMIT;

SELECT * FROM 
DEPT_TCL;

DELETE FROM DEPT_TCL WHERE DEPTNO =50;

SELECT *
FROM  DEPT_TCL;

COMMIT;

/*
LOCK 테스트
동일한 계정으로 디비버 세션과 SQL플러스 세션을 열어
데이터를 수정하는 동시작업
*/


UPDATE DEPT_TCL 
SET loc = 'DAEGU'
WHERE  DEPTNO = 30
;

/*
SQL*PLUS 에서 실행중인 
직원의 업데이트시도를 막고 있는 상황을 모르고잇을수도 있음
*/

SELECT *
FROM dept_tcl
;

COMMIT;


/*
 * 
 * Tuning 기초 : 자동차  튜닝과 같이 db 처리 속도와 안정성 제고 목적의 경우가 대부분
 */

SELECT *
FROM emp 
WHERE SUBSTR(empno,1,2) = '75' --암묵적 형변환
	AND LENGTH (empno) =4 --불필요한 비교
	;
	

SELECT *
FROM EMP 
WHERE empno>7499 and empno <7600
;

SELECT *
FROM EMP 
WHERE ename || '' ||job = 'WARD SALESMAN'
;

SELECT *
FROM EMP
WHERE ENAME = 'WARD'
	AND job = 'SALESMAN'
	;
	

--튜닝 전 후 비교
SELECT  e.EMPNO
		,e.ENAME 
		,d.DEPTNO 
FROM emp E, DEPT d 
WHERE E.DEPTNO = d.DEPTNO 
;

--

SELECT * FROM emp 
WHERE deptno='10'

UNION 

SELECT * from EMP
WHERE DEPTNO ='20'
;


SELECT ename,empno,sal frmo emp
GROUP BY ename, empno
;

SELECT empno, ename FROM EMP
WHERE TO_CHAR(HIREDATE,'YYYYMMDD') LIKE '1981%'
AND EMPNO > 7700
;


--

SELECT ENAME,EMPNO,SUM(SAL)
FROM EMP
GROUP BY ENAME ,EMPNO ;

--LIKE연산자

SELECT empno,ename
FROM EMP 
WHERE to_char(HIREDATE, 'YYYYMMDD') LIKE '1981%'
AND EMPNO>7000
;

SELECT EMPNO,ENAME
FROM EMP 
WHERE  EXTRACT (YEAR FROM HIREDATE) =1981
AND EMPNO > 7700
;

SELECT JOB, count(SAL)
FROM EMP 
GROUP BY JOB
;

SELECT *
FROM USER_INDEXES 
WHERE table_name LIKE 'EMP'
;

DROP INDEX idx_emp_job;

CREATE INDEX idx_emp_job
	ON emp(job)
	;
	
--집계 함수를 사용할때 최대한 인덱스를 우선 사용1002784112894

SELECT job, sum(sal) AS sum_OF_sal
FROM EMP 
GROUP BY JOB 
ORDER BY sum_of_sal
DESC ;



SELECT *
FROM EMPLOYEES
;


--------------------


/* self-join :하나의 테이블에 성질이 동일한 두개 이상의 
 * 컬럼의 관계를이용하여 원하는 레코드의 관계를산출하고 싶은 경우 사용
 * 
 * emp테이블: empno 사번과 mgr 상사 사번
 */

SELECT FROM emp e1 JOIN emp e2
	ON e1.mgr = e2.EMPNO  --emp테이블에 사번의 이름은 있으나 mgr 이름 은 없다.

SELECT  e1.empno
	,e1.ename
	,e1.mgr
	,e2.empno AS mgr_empno
	,e2.ename AS mgr.ename
FROM emp e1 JOIN emp e2
ON e1.mgr = e2.empno
;

/*
 * 모든 mgr저보를기준으로 empno사원정보를 가져왔으나
 * king등의 매니저 null값 직원의 불만으로 인해
 */


SELECT  e1.empno
        ,e1.ename
        ,e1.mgr
        ,e2.empno AS mgr_empno
        ,e2.ename AS mgr_ename
FROM emp e1 LEFT JOIN emp e2
    ON e1.mgr = e2.empno;
   
   
 
   
   /* 
    * CREATE TABLE: 테ㅣ블 구조/ 형태를 신규로 생성
    * 
    * 기존 동일한 테이블 이름이 있는 경우, 에러발생
    */
   
CREATE TABLE EMP_NE(
	 EMPNO		NUMBER(4)
	,ENAME		VARCHAR2(10)
	,JOB		VARCHAR2(9)
	,MGR		NUMBER(4)
	,HIREDATE	DATE
	,SAL		NUMBER(7,2)
	,COMM		NUMBER(7,2)
	,DEPTNO		NUMBER(2)
)
;

CREATE SEQUENCE SEQ_DEPTSEQ
	INCREMENT BY 1
	START WITH 1
	MAXVALUE 99
	MINVALUE 1
	NOCYCLE NOCACHE;
	
CREATE TABLE DEPTSEQ AS SELECT*FROM DEPT ;

INSERT INTO DEPTSEQ(DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPTSEQ.NEXTVAL, 'DATABASE','SEOUL');

INSERT INTO DEPTSEQ(DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPTSEQ.NEXTVAL, 'WEB','BUSAN');

INSERT INTO DEPTSEQ(DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPTSEQ.NEXTVAL, 'MOBILE','ILSAN');

SELECT * FROM DEPTSEQ;