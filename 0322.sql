

CREATE TABLE dept_TEMP
	 AS( SELECT * FROM dept);
	 
/*
 * insert 데이터를 입력하는 방식
 * 
 * insert into테이블명*-(칼럼명1, 칼럼명2,...)
 * values (데이터1, 데이터 2,...)
 */	
INSERT INTO dept_temp (deptno,dname, loc)
	VALUES (50, 'DATABASE','SEOUT')
	;
	

INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES (70,'WEB',NULL);

INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES (70,'WEB',NULL);

INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES (10,'MOBILE','');

INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES (90,'INCHEON');

COMMIT;

SELECT * FROM DEPT_TEMP dt;

/*
 * 컬럼값만 복사하여 새로운 테이블을 생성
 * where 조건에 1 <> 1
 */

CREATE TABLE emp_temp AS
	SELECT* FROM EMP e 	
		WHERE 1 <> 1
;

COMMIT;

SELECT *  FROM emp_temp;

INSERT INTO emp_temp (empno, ename, job, mgr, hiredate,sal,comm,deptno)
values(9999,'홍길동','PRESIDENT',NULL, TO_DATE('2001/01/01','YYYY/MM/DD'),6000,500,10)
;
INSERT INTO emp_temp (empno, ename, job, mgr, hiredate,sal,comm,deptno)
values(2111,'이순신','MANAGER',9999,TO_DATE('07/01/1999', 'DD/MM/YYYY'),4000,NULL,20);

INSERT INTO emp_temp (empno, ename, job, mgr, hiredate,sal,comm,deptno)
values(3111, '심청이', 'MANAGER',9999,SYSDATE, 4000, NULL ,30);


--COMMIT

SELECT *
FROM EMP_TEMP 
;


INSERT INTO emp_temp (empno, ename, job, mgr, hiredate,sal,comm,deptno)
SELECT e.empno
	,e.ename
	e,e.job
	,e.mgr
	,e.hiredate
	,e.sal
	,e.comm
	,e.deptno
FROM emp e, SALGRADE s 
WHERE e.sal BETWEEN s.LOSAL 
					AND s.HISAL 
					AND s.GRADE = 1;
				
SELECT *
from emp_temp;

/*
 * update 문 : 필터된 데이터에 대해서 레코드 값을 수정
 * 
 */

CREATE TABLE dept_temp2 --테스트 개발을 위하 임시 테이블 생성
	AS (SELECT * FROM dept)
	;

SELECT *
	FROM dept_temp2--테스트 개발을 위하 임시 테이블 조회
	;


/*
 * update...set... : 한 구문의 개념 
 */
UPDATE DEPT_temp2
	SET loc ='SEOUL';
	
ROLLBACK;

SELECT *
	FROM EMP 
	WHERE ROWNUM < 3;
	
UPDATE dept_temp2
SET dname='DATABASE'
	,loc ='SEOUL'
WHERE deptno = 40
;


/*
 * 서브쿼리 사용하여 업데이트
 * 
 */

UPDATE DEPT_temp2
SET (dname,loc) = (SELECT dname,LOC 
						FROM DEPT 
						WHERE deptno=40)
WHERE deptno=40; --서울발령

SELECT *
	FROM dept_temp2--테스트 개발을 위하 임시 테이블 조회
	;
	

ROLLBACK;

COMMIT; --원복 불가


/*
 * delete 구문으로 테이블에서 값을 제거
 * 대부분의 경우(또는 반드시) where조건이 필요
 * 보통의 경우 delete 보다 update구문으로 상태값을 변경
 * 예시ㅣ 근무/휴직/퇴사 등의 유형으로 값을 변경
 */

SELECT *
FROM emp_temp2

;

CREATE TABLE emp_temp2
	AS (SELECT*FROM emp)
	;

COMMIT;

   
;--인사팀에서 명령 실행  요청


DELETE FROM EMP_TEMP2 -- 임시테이블2
	WHERE EMPNO IN (SELECT EMPNO
					FROM EMP_TEMP2 e, SALGRADE s 
					WHERE e.sal BETWEEN s.LOSAL AND s.HISAL 
						AND s.GRADE = 3
						AND deptno = 30)
;

	SELECT e.EMPNO
		FROM EMP_TEMP2 e, SALGRADE s 
	    WHERE e.sal BETWEEN s.LOSAL AND s.HISAL 
		AND s.GRADE = 3
	    AND deptno = 30
	    ;
	    
	   
/*
	CREATE 문을 정의 : 기존에 없는 테이블 구조를 생성
	데이터는 없고, 테이블의 컬럼과 데이터타입, 제약 조건등의구조를 생성
*/
	   
CREATE TABLE emp_new
( 
	empno		number(4)
	, ename 	varchar(10)
	, job		varchar(9)
	, mgr		number(4)
	, hiredate 	DATE
	, SALGRADE 	number(7,2)
	, comm 		number(7,2)
	, deptno	number(2)
);


SELECT *
	FROM emp_new
;

ALTER TABLE emp_new
 ADD hp varchar(20)
;

ALTER TABLE EMP_NEW 
RENAME COLUMN  hp TO tel_no
;

ALTER TABLE EMP_NEW
MODIFY EMPNO NUMBER(5)
;

ALTER TABLE EMP_NEW
DROP COLUUMN tel_no
; 

--sequence 일련번호를 생성하여 테이블 관리를 편리하게 하고자 함

CREATE SEQUENCE seq_deptno
	INCREMENT BY 1
	START WITH 1
	MAXVALUE 999
	MINVALUE 1
	NOCYCLE 
	NOCACHE
	;


INSERT INTO dept_temp2 (deptno,dname,loc)
	VALUES (seq_deptno.nextval, 'DATABASE','SEOUL')
;

INSERT INTO dept_temp2 (deptno,dname,loc)
	VALUES (seq_deptno.nextval, 'WEB','BUSAN')
;
	
INSERT INTO dept_temp2 (deptno,dname,loc)
	VALUES (seq_deptno.nextval,'MOBILE','SEUNGSOO')
;


/*
 * 제약 조건(CONSTRAINT)지정 
 *
 * 테이블을 생성할 때, 테이블 컬럼별 제약 조건을 설정
 * 자주 사용되는 중요한 제약조건 유형
 * NOT NULL
 * UNIQUE
 * PK
 */

CREATE TABLE LOGIN
(
	log_id		VARCHAR2(20)	NOT NULL
	,log_pwd 	VARCHAR2(20)	NOT NULL
	,TEL 		VARCHAR2(20)
);

INSERT INTO login(log_id,log_pwd)
VALUES ('test01','1234')
;

SELECT *
FROM login;

/*
 * tel컬럼의 중요성을 나중에 인지하고 not null제약조건을 설정
 */

ALTER TABLE login
MODIFY tel NOT NULL
;


/*tel 없는 고객이 발견되어 어렵게 어렵게 전화벊호를 구함
 */
 
UPDATE login
SET tel ='010-1211-1111'
WHERE log_id = 'test01'
;

/*
오라클 dbms가 사용자를 위해 만들어 놓은 제약조건 설정값 테이블
*/

SELECT OWNER 
	,CONSTRAINT_name
	,CONSTRAINT_type
	,table_name
	FROM user_constraints
	WHERE TABLE_name = 'LOGIN'
;

ALTER TABLE LOGIN 
	MODIFY (TEL CONSTRAINT TEL_NN NOT NULL)
	;
	
ALTER TABLE LOGIN
	DROP CONSTRAINT SYS_C007040 --제약조건 이름이 없어 주어진 이름 사용 
;

CREATE TABLE LOG_UNIQUE
(
	log_id varchar2(20) UNIQUE 
	,log_pwd varchar2(20) NOT NULL
	,tel varchar2(20) 
);

SELECT *
	FROM  USER_constraints
	WHERE TABLE_name = 'LOG_UNIQUE'
	;
	
INSERT INTO LOG_UNIQUE(log_id,log_pwd,tel)
VALUES ('test01','pwd0123','010-0000-0000')
;

INSERT INTO LOG_UNIQUE(log_id,log_pwd,tel)
VALUES ('test02','pwd012222222223','010-0000-0000')
;

INSERT INTO LOG_UNIQUE(log_id,log_pwd,tel)
VALUES ('test03','0122222222223','010-0000-0000')
;

INSERT INTO LOG_UNIQUE(log_id,log_pwd,tel)
VALUES (NULL,'0122222222223','010-0000-0000')
;

SELECT *
FROM LOG_UNIQUE;

UPDATE LOG_UNIQUE
	 SET LOG_ID ='TEST_ID_NEW'
	 WHERE LOG_ID IS NULL
;

ALTER TABLE LOG_UNIQUE
	MODIFY (TEL UNIQUE)
;

CREATE TABLE LOG_PK2
(
	log_id 	VARCHAR2(20) UNIQUE
	,log_PWD 	VARCHAR2(20) NOT NULL
	,TEL   		VARCHAR2(20)
	
);

INSERT INTO LOG_PK2 (LOG_ID,LOG_PWD,TEL)
VALUES('PK01','PWD01','012-3456-7777')
;

INSERT INTO LOG_PK2 (LOG_ID,LOG_PWD,TEL)
VALUES('PK01','PWD02','002-3456-7777')
;

INSERT INTO LOG_PK2 (LOG_ID,LOG_PWD,TEL)
VALUES(NULL,'PWD02','002-3456-7777')
;

SELECT *
FROM EMP_TEMP;

--존재하지않는 부서번호를 EMP_TEMP 테이블에 입력을 시도

INSERT INTO emp_temp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(3333,'freak','surprise',9999,sysdate, 1200, NULL,99);
--
INSERT INTO emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
values(3333,'freak','surprise',9999,sysdate, 1200, NULL,99);

/*
INDEX 빠른 검색을 위한 색인
장점: 순식간에 원하는값을  찾아준다.
단점: 입력과 출력이 잦은 경우, 인덱스가 설정된 테이블의 속도가 저하된다.
*/
-- 색인 지정

CREATE INDEX idc_emp_job
	ON emp(job)
;

SELECT *
FROM user_indexes
WHERE TABLE_NAME IN('EMP','DEPT')
;

/*
VIEW: 테이블을 편리하게 사용하기 위한 목적으로 생성하는 가상 테이블
*/
SQLPLUS SYSTEM/ORACLE

GRANT CREATE VIEW TO SYSTEM;

CREATE VIEW VW_123
AS (SELECT EMPNO
			,ENAME
			,JOB
			,DEPTNO
	FROM EMP 
	WHERE DEPTNO =10 )
;

SELECT *
FROM vw_123
;

SELECT *
FROM USER_VIEWS WHERE view_name='VW_EMP'
;




--ROWNUM사용 : 상위 N개를 출력하기 위해 사용하여
-- 칼럼에 ROWNUM 순번을 입력하여 사용할 수 있음


SELECT ROWNUM
	,E.*
FROM  EMP E
ORDER BY SAL DESC
;

SELECT rownum, A.*			
FROM(SELECT ROWNUM
	,E.*
	FROM  EMP E
	ORDER BY SAL DESC) A
;


SELECT rownum, A.*			
FROM(SELECT ROWNUM
	,E.*
	FROM  EMP E
	ORDER BY SAL DESC) A
	WHERE ROWNUM<=5
;

SELECT *
FROM dict
WHERE table_name LIKE 'USER_CON%'-- %와일드카드
;


SELECT *
FROM DBA_USERS WHERE username = 'SCOTT%'
;

SELECT *
	FROM DBA_TABLES
	WHERE TABLE_NAME LIKE 'EMP%'
;
