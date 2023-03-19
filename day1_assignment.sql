/* 
 * Q1-1 (1)논리 설계 (2)데이터 모델링
 * Q1-2 (1)E-R 모델 (2)E-R 모델 (3) Entity
 * Q1-3 (1)E-R Diagram (2)관계
 * Q1-4 (1)카디널리티 (2)옵셔널리티
 * Q1-5 (1)스키마 (2)테이블
 * Q1-6 (1)Table (2)Index (3)Sequence
 * 
 */

SELECT EMPNO AS EMPLOYEE_NO
	  ,ENAME AS EMPLOYEE_NAME
	  ,JOB
	  ,MGR AS MANAGER
	  ,HIREDATE 
	  ,SAL AS SALARY
	  ,COMM AS COMMISSION
	  ,DEPTNO AS DEPARTMENT_NO
FROM EMP;



SELECT * FROM EMP
		 WHERE COMM IS NULL
		 AND SAL > NULL;
		 
		
		
SELECT * FROM EMP
		 WHERE MGR IS NULL
		 AND COMM IS NULL;
		 
		
		
--1--
SELECT * FROM EMP
		 WHERE ENAME LIKE '%S';
		 
--2--
SELECT * FROM EMP
		 WHERE JOB = 'SALESMAN'
		 AND DEPTNO = 30;
		 
--3--
SELECT * FROM EMP
		 WHERE DEPTNO IN (20, 30)
		 AND SAL > 2000;
		 
--4--
SELECT * FROM EMP
		 WHERE DEPTNO = 20
		 AND SAL > 2000
		 
UNION

SELECT * FROM EMP
		 WHERE DEPTNO = 30
		 AND SAL > 2000;
		
--5--
SELECT * FROM EMP
		 WHERE COMM IS NULL
		 AND MGR IS NOT NULL 
		 AND JOB IN ('MANAGER','CLERK')
		 AND ENAME NOT LIKE '_L%';

		
		
--1--
SELECT EMPNO
 	  ,ENAME
	  ,RPAD(SUBSTR(EMPNO, 1, 2)
	  ,LENGTH(EMPNO), '*') AS EMPNO_마스킹_처리
	  ,RPAD(SUBSTR(ENAME, 1, 1)
	  ,LENGTH(ENAME), '*') AS ENAME_마스킹_처리
	   FROM EMP
	   WHERE LENGTH(ENAME) >= 6;
	   
--2	 -- 
SELECT EMPNO
	  ,ENAME
	  ,JOB
	  ,SAL
	  ,(SAL / 20) AS DAY_PER_SAL
	  ,(SAL / 20 / 8) AS HOUR_PER_SAL
	  FROM EMP
	  WHERE JOB IN ('SALESMAN', 'CLERK')
	  ORDER BY SAL;

--3--	 
SELECT EMPNO
	  ,ENAME
	  ,TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3)
	  , '월요일'), 'yyyy-mm-dd') AS HIREDATE3
	  ,NVL(TO_CHAR(COMM), 'N/A') AS COMM
	  FROM EMP;
	  
--4--	  
SELECT EMPNO
	  ,ENAME
	  ,MGR
	  ,CASE WHEN MGR IS NULL THEN '0000'
	  		WHEN SUBSTR(MGR, 1, 2) = '75' THEN '5555'
	  		WHEN SUBSTR(MGR, 1, 2) = '76' THEN '6666'
	  		WHEN SUBSTR(MGR, 1, 2) = '77' THEN '7777'
	  		WHEN SUBSTR(MGR, 1, 2) = '78' THEN '8888'
	  		ELSE '9999'
	  		END AS CHG_MGR
	  FROM EMP;