

		
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

 
	