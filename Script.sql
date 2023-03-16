--
--SELECT ENAME 		--ename :
--	,SAL * 3		--quarterly :
--	,COMM  			--commision : why?when? :
--FROM EMP;



--SELECT *
--	FROM emp;
--	
--SELECT ename
--	FROM emp e 
--	WHERE a= 'SMITH';
--	
--SELECT ename
--	FROM emp e 
--;
--	


/*
 *
 */

--SELECT 100 + 5, 10 - 3, 30 * 2, 10 / 3
----	FROM EMP e 
--	;
--	

--SELECT 100+ 5
--	, 10 - 3
--	, 30 * 2
--	, 10 / 3 
--	FROM dual
--	;
	

--SELECT dbms_random.value() 
--	* 100 
--	FROM dual --from dual 은 가상의 from공간, 가상
--	;
	
--SELECT 
--	ENAME 
--	FROM EMP 
--	AS employee
--;
--	

SELECT 
	ENAME 
	AS "employee name"
	FROM EMP emplyee
	;


SELECT *
	FROM EMP 
	ORDER BY SAL;
	
SELSECT *
	FROM EMP 
	ORDER BY SAL DESC;
	
SELECT *
	FROM EMP 
	ORDER BY DEPTNO
	ASC 
	, SAL DESC 
	;