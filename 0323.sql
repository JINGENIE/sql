/*
GROUP by구문: 집계 함수를 사용하여 값을 표시 
*/
SELECT * FROM 
SCOTT.SALGRADE ;


SELECT deptno, sal
FROM emp
GROUP BY deptno
;

SELECT DEPTNO 
	,JOB 
	,floor(avg(sal)) AS avg_sal
	,max(sal) AS max_sal
	,max(sal) AS min_sal
FROM EMP
GROUP BY JOB ,deptno
HAVING max(sal) >= 2000
ORDER BY JOB ,deptno
;	


/* listagg/pivot
SELECT *
FROM user_indexes
WHERE table_name = 'EMP'
;

SELECT 