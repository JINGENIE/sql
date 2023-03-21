

		
		---
SELECT * a.ENAME
		, a.SAL
		, a.EMPO
FROM EMP a
WHERE mgr IS NULL AND comm IS NULL 
;
		
--SELECT *
--	FROM EMP a;


--오라클타입
--DATA TYPE: 문자열, 숫자, 날짜 , 시퀀스(숫자)


SELECT *
FROM  v$sqlfn_metadata v
WHERE v.name = 'NVL'
;

/*
 * 문자열 함수
 * upper() :대문자 변환
 * lower() : 소문자 변환
 * length() : 문자열 길이
 * 
 * sample: --- 
 */

SELECT ename
	, UPPER(ename) AS to_upper_name
	, LOWER(ename) AS to_lower_name
FROM EMP 
;

SELECT *
	FROM EMP
	WHERE  UPPER(ename) = UPPER('ScoTT')
	;
/*
 * TRIM :공란 제거
 */

--SELECT '[' || ']'
---- || MEANS 더하기
--FROM 

SELECT trim(ename)
FROM EMP 
;


SELECT empno
	,ename
	,CONCAT(empno,ename)
	,CONCAT(empno,'') 
FROM EMP 
WHERE ename = UPPER('smith')
;


SELECT '010-1234-5678' AS mobile_phone
	, REPLACE('010-1234-5678','-','') AS replacednumber
FROM dual;
/*
*lpad, rpad 문자열을 채우기하는 함수
*
*
*/

/*
 * replace 문자열 교체
 * 주요예시 : 전화번호, 이메일 , 집주소 등등
 */

SELECT LPAD('ora_1234_xe',20) AS lpad_20
	,rpad('ora_1234_xe',20) AS rpad_20
FROM dual
;


--RPAD 문자열, 개수, 채울문자
SELECT RPAD('971225-',14,'*') AS RPAD_JMNO
	,RPAD('010-1234-',13,'*') AS RPAD_PHONE
FROM DUAL
;

-- 숫자 variable
SELECT *
	FROM EMP E
	WHERE E.EMPNO  >= input_no
;




/*
 * NUMBER 숫자를 다루는 함수들
 * 
 * 정수(INTEGER) 부동소수(FLOAT) - 소수점이 있는 숫자
 * 부동소수의 경우, 소수점 이하 정말도 (PRECISION) 차이가 발생
 * Pi ~ 3.142457.........39339 (15자리 이하 소수 버
 * 
 */

SELECT remainder(15,4)AS c1
	,REMAINDER(15,-4)AS c2
FROM dual;




SELECT ROUND(3.1428,3) AS round0
	,ROUND(123.456789,3) AS round1
	,trunc(123.4567,2) AS trunc0
	,trunc(-1234567,2)AS trunc1
  FROM DUAL
;


SELECT CEIL (3.14) AS CEIL0
	,FLOOR(3.14) AS FLOOR0
	,MOD(15,6) AS MOD0
	,MOD(11,1) AS MOD1
	FROM DUAL
;	

SELECT remainder(15,2) AS r1
	,remainder(-11,2) AS r2
FROM dual
;

/*
 * 날짜를 다루는 함수들 
 * 2023-04-01 minus  1 day -->???
 * 날짜를 표현하는 일련번호 숫자가 존재
 */

SELECT SYSDATE  AS now
	,sysdate -1 AS yesterd
	,SYSDATE +10 AS ten_days_from_dd
	FROM dual
;

SELECT ADD_MONTHS(SYSDATE, :MONTH)
FROM dual
;

SELECT empno, ename, hiredate,
	ADD_MONTHS(hiredate, 12*20)AS work10year
	FROM emp;

SELECT EMPNO, ENAME
	,RPAD(SUBSTR(EMPNO,1,2),4,'*') AS "EMPNO 마스킹처리"
	,RPAD(SUBSTR(EMPNO,1,1), LENGTH (ENAME),'*') AS "ENAME 마스킹 처리"
	FROM EMP 
	WHERE LENGTH(ENAME) >=6 ; 


/*
 * 형변환(Cast, up-cast, down-cast)
 * 
 * down-cast: 큰수를 담는 데이터형에서 작은 수를 담는 데이터 형으로 명시적 변환
 * 
 */


SELECT ename
	,hiredate
	,MONTHs_between(hiredate,SYSDATE)
FROM EMP 
;

SELECT ename
	,hiredate
	,MONTHs_between(SYSDATE, HIREDATE) /12 AS year1
FROM EMP 
;

SELECT SYSDATE 
	,NEXT_DAY(SYSDATE, '월요일') AS b_date
	,LAST_DAY(sysdate) AS a_date 
FROM dual;


SELECT ENAME
		,EXTRACT(YEAR FROM HIREDATE) AS y
		,EXTRACT(MONTH FROM HIREDATE) AS m
		,EXTRACT(DAY FROM HIREDATE) AS d
	FROM emp
;

SELECT SYSDATE, ROUND(SYSDATE, 'CC') AS FORMAT_CC
	,ROUND(SYSDATE, 'YYYY') AS FORMAT_YYYY
	,ROUND(SYSDATE, 'Q') AS FORMAT_Q
	,ROUND(SYSDATE, 'DDD') AS FORMAT_DDDD
	,ROUND(SYSDATE,'HH') AS FORMAT_HH
FROM dual;


SELECT EMPNO 
FROM EMP
WHERE DEPTNO = '20'
;



	   


	 

	 
--
SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh24')
	FROM dual
;	 --24시간 표시까지
	 
SELECT TO_CHAR(sysdate, 'DD HH24:MI:SS')
FROM dual
;	 --시분초까지
	 


SELECT SYSDATE 
	,TO_CHAR(sysdate, 'MM')AS mm1
	,TO_CHAR(sysdate,'mon', 'NLS_DATE_LANGUAGE=KOREAN') AS MONTH_KOR
	FROM DUAL
;

SELECT SYSDATE 
	,TO_CHAR(SYSDATE, 'HH24:MI:SS') AS tm
FROM dual
;


SELECT TO_NUMBER('1,000,000', '999,999,999') AS cur_num
FROM dual
; -- (a,b) b는 최대 자리수

SELECT TO_DATE('2023/03/20','yyyy/mm/dd') AS yyy
FROM dual;

SELECT TO_DATE('20230320','yyyy/mm/dd') AS yyy
FROM dual;


--p165
/*
 * TO_DATE(입력날짜, 'RR-MM-DD')
 * TO_DATE(입력날짜, 'YY-MM-DD')
 * 날짜포맷 RR과 YY값 비교
 * 
 */

--RR 19/ YY20
SELECT TO_DATE('49/12/10', 'YY/MM/DD') AS YY_YEAR_49
	,TO_DATE('49/12/10', 'RR/MM/DD') AS RR_YEAR_49
	,TO_DATE('50/12/10', 'YY/MM/DD') AS YY_YEAR_50
	,TO_DATE('50/12/10', 'RR/MM/DD') AS RR_YEAR_50
	,TO_DATE('51/12/10','YY/MM/DD') AS YY_YEAR_51
FROM DUAL;



/*
 * NULL: 알 수 없는 값, 계산 불가
 * 널값비교는 IS NULL <> IS NOT NULL
 * 
 * NVL(입력값, NULL인 경우 대체할 값)
 * NVL2(입력값,NULLㅇ닌경우, NULL인 경우(
 * 
 */


SELECT empno
	,sal * 12 + nvl(comm,0) AS sal12
	,job
	,TO_CHAR(HIREDATE,'YYYY-MM-DD') AS WORKYEAR  
FROM emp
ORDER BY sal12 desc 
;

/*
 * DECODE(입력컬럼값,'값1',처리1,'비교값2', 처리2, '...', 처리...) AS 별칭
 * 
 * CASE 컬럼값
 * 		WHEN '값1' THEN 처리1
 * 		WHEN '값2' THEN 처리2
 * 	ELSE AS 별칭
 */		


-- 171쪽

SELECT sum(sal)
FROM emp;

SELECT ename,sum(sal)
FROM emp;

SELECT sum(comm)
FROM emp;

SELECT sum(DISTINCT sal)
	,sum(ALL sal)
	,sum(sal)
FROM emp;



SELECT DISTINCT e.deptno
	,e.SAL ,e.EMPNO 
FROM emp e
;

SELECT sum(DISTINCT e.sal)AS sum_of_distinct
	,sum(ALL e.sal) AS sum_of_all
	,sum(e.sal) AS normal_sum
FROM emp e
;

SELECT max(sal)
	FROM EMP 
	WHERE DEPTNO  =30
	;

SELECT max(sal) AS max_sal
	,min(sal) AS min_sal
	,round(max(sal) /min(sal),1 )AS max_min_times
FROM EMP 
WHERE DEPTNO = 10
;

--count 집계함수
SELECT  count(empno)
	,count(comm)
FROM EMP
;
	

SELECT COUNT(*)
FROM EMP
WHERE deptno =20;


SELECT count(DISTINCT sal)
	,COUNT(ALL sal)
	,COUNT(sal)
	
FROM emp;

SELECT COUNT(ename)
FROM EMP 
WHERE nvl(comm,0) >0
;

-- 부서명 유니언올을 이용해 집계
SELECT avg(sal),'10' AS dno
FROM EMP
WHERE DEPTNO = 10 

UNION ALL 

SELECT avg(sal),'20' AS dno
FROM EMP
WHERE DEPTNO = 20 

UNION ALL 

SELECT avg(sal),'30' AS dno
FROM EMP
WHERE DEPTNO = 30 
;

/*
 * 
 *group by키워드 사용하여 스마트하게 집계
 */
SELECT deptno
	,count(sal)
	,avg(sal)
	,max(sal)
	,min(sal)
	,sum(sal)
FROM EMP 
GROUP BY DEPTNO 
ORDER by DEPTNO 
;

SELECT deptno, job
	,count(sal)
	,avg(sal + nvl(comm,0)) AS avg_pay
	,max(sal + nvl(comm,0)) AS max_pay
	,min(sal + nvl(comm,0)) AS min_pay
	,sum(sal + nvl(comm,0)) AS sum_pay
FROM emp
GROUP BY DEPTNO, JOB 
ORDER by DEPTNO, job 
;


 /*테이블 정규화로 분할된 
  * 
  *테이블 컬럽을 다시 합치는 작업*/

SELECT *
	FROM emp, DEPT
	ORDER BY empno
	;
	
SELECT *
FROM  emp e, dept d
WHERE e.name="MILLER"
ORDER BY E.EMPNO 
;

SELECT *
FROM  emp, dept
WHERE emp.DEPTNO = dept.DEPTNO 
ORDER BY EMPNO 
;

SELECT E.EMPNO 
	,E.HIREDATE 
	,D.DNAME 
FROM emp E JOIN DEPT D
	ON E.DEPTNO = D.DEPTNO  --on키워드 뒤에 값 비교
ORDER BY empno

/*
 * 자바 등 프로그래밍에서 sql 쿼리문을 사용하는 경우
 * 쿼리문을 문자열로 사용가능
 */
var_deptno ;


var_sql="SELECT E.EMPNO 
	,E.HIREDATE 
	,D.DNAME 
FROM emp E JOIN DEPT D
	USING (deptno)  --USING 키워드 하나로 동일 칼럼
"
--oracle join

SELECT e.EMPNO 
	-- ,e.HIREDATE  
	,TO_CHAR(e.HIREDATE , 'yyyy/mm/dd hh24') AS hire_date
	,e.ENAME 
	,d.DEPTNO 
	,d.LOC 
	FROM emp e
		,DEPT d 
	WHERE e.DEPTNO = d.DEPTNO 
	ORDER BY d.DEPTNO, e.EMPNO 
	;
	
SELECT e.EMPNO 
	-- ,e.HIREDATE  
	,TO_CHAR(e.HIREDATE , 'yyyy/mm/dd hh24') AS hire_date
	,e.ENAME 
	,d.DEPTNO 
	,d.LOC 
	,e.SAL 
	FROM emp e
		,DEPT d 
	WHERE e.DEPTNO = d.DEPTNO AND e.SAL < 2000
	ORDER BY e.sal DESC 
	;

	--avg
SELECT round(avg(e.sal),0) AS avg_sal
	,sum(e.sal) AS sum_sal
	,max(e.sal) AS max_sal
	,min(e.sal) AS min_sal
	,count(e.sal) AS cnt_sal
	FROM emp e
		,DEPT d 
	WHERE e.DEPTNO = d.DEPTNO AND e.SAL < 2000
	GROUP BY d.DNAME , e.JOB 
	;




FROM emp e, dept d
WHERE e.DEPTNO = d.DEPTNO  AND e.sal<2000
GROUP BY d.DNAME ,e.JOB 
ORDER BY AVG_sal DESC 
;


SELECT e.ENAME 
	 ,s.GRADE 
	 ,d.deptno
	 ,e.SAL 
	 ,e.job
	 ,e.HIREDATE 
FROM emp e, SALGRADE s
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL 
;
--error
SELECT s.GRADE  
	,COUNT(e.ename) AS emp_cnt
FROM emp e
	,SALGRADE s  
WHERE e.sal 
BETWEEN s.losal AND s.HISAL 
GROUP BY s.GRADE 
ORDER BY emp_cnt desc
;

--
SELECT e.ename
	,e.DEPTNO 
	,e.JOB 
	,s.GRADE 
	,e.SAL
	,s.LOSAL  AS low_rng
	,s.hisal AS high_rng
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.HISAL 
;

SELECT 
FROM emp e, DEPT d 
WHERE e.DEPTNO = d.DEPTNO 
;

/* self-join 자기 자신의 릴레이션을 이요애서 테이블컬럼을 조작
 * 
 */

SELECT el.empno AS emp_no
	,e1.ENAME AS emp_name
	,e2.MGR  AS mgr_no
	,e2.ENAME AS mgr_name
FROM emp e1, emp e2
WHERE e1.EMPNO = e2.MGR 
;

SELECT e1.empno AS emp_no
	,e1.ENAME AS emp_name
	,e2.MGR  AS mgr_no
	,e2.ENAME AS mgr_name
FROM emp e1, emp e2
WHERE e1.EMPNO = e2.MGR ;


SELECT e1.EMPNO 
	,e1.ENAME 
	,e1.MGR 
	,e2.empno AS mgr_no
	,e2.ENAME AS mgr_name
FROM EMP e1, EMP e2
WHERE e1.MGR  = e2.EMPNO ;

/*
LEFT-JOIN 왼쪽 테이블 값을 모두 가져오고
JOIN 하는 테이블에서 해당되는 값 일부만 가져오기
*/

SELECT e1.EMPNO 
	,e1.ENAME 
	,e1.MGR 
	,e2.EMPNO 
	,e2.ENAME 
	FROM emp e1, emp e2
	WHERE e1.mgr = e2.EMPNO (+) --왼쪽은 다 오고 오른쪽은 붙인다.
	ORDER BY e1.EMPNO 
	;
	
/*
LEFT-JOIN:표준 SQL
*/

SELECT e1.EMPNO 
	,e1.ENAME 
	,e1.MGR 
	,e2.EMPNO 
	,e2.ENAME
FROM EMP e1 LEFT OUTER JOIN EMP E2
		ON E1.MGR =E2.EMPNO
;

SELECT e1.EMPNO 
	,e1.ENAME 
	,e1.MGR 
	,e2.EMPNO 
	,e2.ENAME
FROM EMP e1, EMP E2
WHERE E1.MGR(+) = E2.EMPNO(+)  --RIGHT JOIN
;

/* 표준SQL로 RIGHT OUTER JOIN출력
 * 
 * 
 */
SELECT e1.EMPNO 
	,e1.ENAME 
	,e1.MGR 
	,e2.EMPNO 
	,e2.ENAME
FROM  EMP E1 RIGHT OUTER JOIN EMP E2
	ON E1.MGR = E2.EMPNO 
ORDER BY E1.EMPNO 
	
;

--양측 조인
SELECT e1.EMPNO 
	,e1.ENAME 
	,e1.MGR 
	,e2.EMPNO 
	,e2.ENAME
	FROM EMP E1 FULL OUTER JOIN EMP E2
	ON E1.MGR = E2.EMPNO;


SELECT D.DEPTNO
		,D.DNAME
		,E.EMPNO
		,E.ENAME
		,E.MGR
		,E.SAL
		,E.DEPTNO
		,S.LOSAL
		,S.HISAL
		,S.GRADE
		,E2.EMPNO AS MGR_EMPNO
		,E2.ENAME AS MGR_ENAME
FROM EMP E RIGHT JOIN DEPT D ON(E.DEPTNO =D.DEPTNO)
	LEFT OUTER JOIN SAGRADE S ON (E.SAL >=S.LOSAL AND E.SAL <=S.HISAL)
	LEFT OUTER JOIN EMP E2 ON(E.MGR=E2.EMPNO)
	ORDER BY D.DEPTNO, E.EMPNO 
;

SELECT D.DEPTNO
		,D.DNAME
		,E.EMPNO
		,E.ENAME
		,E.MGR
		,E.SAL
		,E.DEPTNO
		,S.LOSAL
		,S.HISAL
		,S.GRADE
		,E2.EMPNO AS MGR_EMPNO
		,E2.ENAME AS MGR_ENAME
FROM EMP E, DEPT D, SALGRADE s ,EMP e2 
WHERE E.DEPTNO(+) = D.DEPTNO 
AND E.SAL BETWEEN S.LOSAL(+)AND S.HISAL(+)
AND E.MGR = E2.EMPNO(+)
ORDER BY D.DEPTNO,E.EMPNO 
;

/* EMP, DEPT, SALGRAE, SELFJOIN EMP
 * 
 */
SELECT D.DEPTNO
		,D.DNAME
		,E.EMPNO
		,E1.ENAME
		,E1.MGR
		,E1.SAL
		,E1.DEPTNO
		,S.LOSAL
		,S.HISAL
		,S.GRADE
		,E2.EMPNO AS MGR_EMPNO
		,E2.ENAME AS MGR_ENAME
FROM EMP E1,DEPT D
	,SALGRADE s 
	,EMP E2
WHERE E1.DEPTNO(+)=D.DEPTNO 
	AND E1.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
	AND E1.MGR = E2.EMPNO(+)
	;
	

/*표준SQL 출력

*/

SELECT D.DEPTNO
		,D.DNAME
		,E1.EMPNO
		,E1.ENAME
		,E1.MGR
		,E1.SAL
		,E1.DEPTNO
		,S.LOSAL
		,S.HISAL
		,S.GRADE
		,E2.EMPNO AS MGR_EMPNO
		,E2.ENAME AS MGR_ENAME
	FROM emp e1 RIGHT JOIN DEPT d 
		ON e1.DEPTNO = d.DEPTNO 
		LEFT OUTER JOIN SALGRADE s 
		ON (e1.sal  >= s.losal AND e1.SAL <= s.HISAL)
		LEFT OUTER JOIN emp e2
		ON (e1.mgr=e2.EMPNO)
;


/*
 * 
 *단일행 서브쿼리 - 쿼리안에 쿠ㅓ리문장을 사용
 *select 쿼리의 결과는 -- 2차원 테이블에 불과
 */


SELECT ename, sal
FROM EMP e 

SELECT *
FROM EMP 
WHERE sal>2850;

SELECT *
FROM EMP 
WHERE sal > (SELECT sal FROM emp WHERE ename ='blake');

--p204
SELECT e.empno
	,e.ename
	,e.job
	,e.sal
	,d.deptno
	,d.dname
	,d.loc
FROM emp e, DEPT d 
WHERE e.DEPTNO = d.DEPTNO 
	AND e.DEPTNO = 20
	AND e.SAL >(SELECT avg(sal)FROM emp)
;


/*다중행 서브쿼리
 * select 쿼리의 결과는 --> 두개이상의 값으로 된 테이블
 * avg
*/

SELECT deptno, ename, sal
	FROM EMP 
	WHERE sal in(SELECT avg(sal) FROM emp GROUP BY deptno);

SELECT max(sal)
FROM EMP 
GROUP BY DEPTNO 
ORDER BY DEPTNO 
;


SELECT *
	FROM EMP 
	WHERE sal = any(sub_query)
;

SELECT min(sal), max(sal)
FROM EMP
WHERE deptno=30
;

SELECT *
	FROM EMP 
	WHERE sal < any(SELECT sal FROM emp WHERE DEPTNO = 30)
	-- 어느하나라도 
;

SELECT *
	FROM EMP 
	WHERE (deptno, sal) IN (SELECT deptno, max(sal)
	FROM EMP GROUP BY deptno)
	-- 어느하나라도 
;

SELECT A.EMPNO
	,A.SAL
	,B.DNAME 
FROM (SELECT * FROM emp WHERE deptno=30) A
	, (select * FROM DEPT) B
WHERE  A.deptno = B.DEPTNO 
;

/*
WITH절 (구문) - 편리한 가상 테이블로 활용
*/

WITH E AS (SELECT * FROM EMP WHERE DEPTNO = 20)
	,D AS (SELECT * FROM DEPT)
	,S AS (SELECT * FROM SALGRADE)
SELECT  E.ENAME
	,D.DNAME
	,D.LOC
	,E.SAL
	,S.GRADE
FROM E,D,S
WHERE E.DEPTNO = D.DEPTNO
	AND E.SAL BETWEEN S.LOSAL AND S.HISAL
;


CREATE TABLE DEPT_TEMP
	AS SELECT * FROM DEPT
;
