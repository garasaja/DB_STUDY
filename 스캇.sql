SELECT HIREDATE FROM EMP WHERE  HIREDATE = '80/12/17';

ALTER SESSION SET NLS_DATE_FORMAT = 'YY/MM/DD';

SELECT * FROM EMP;

SELECT * FROM EMP WHERE SAL BETWEEN 1500 AND 2000;

SELECT * FROM EMP WHERE JOB LIKE 'S%';

SELECT * FROM EMP WHERE JOB LIKE 'S_______';

SELECT * FROM EMP WHERE COMM IS NULL;

SELECT * FROM EMP WHERE COMM IS NOT NULL;

-- 사원들 중에 보너스가 500보다 작은사람!!

SELECT * FROM EMP WHERE COMM <500;

SELECT NVL(NULL,0) , NVL(100,3) FROM DUAL;
                                                                                                                                                  
SELECT ENAME , SAL ,NVL(COMM,0) FROM EMP WHERE NVL(COMM,0)<500;

SELECT * FROM EMP WHERE SAL>1000 ORDER BY SAL DESC;

SELECT POWER(2,10) FROM DUAL;

SELECT MOD(123,10) FROM DUAL;

SELECT CEIL(123.45) FROM DUAL;

SELECT SYSDATE FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD-HH-MI-SS';

SELECT DECODE('LOVE','LEVE','TRUE') FROM DUAL;

SELECT * FROM PROFESSOR;

SELECT DEPTNO,NAME,DEPTNO,DECODE(DEPTNO , 101,'COMPUTER ENGNEERING','ETC') FROM PROFESSOR ; 

SELECT DEPTNO , NAME , DECODE(DEPTNO,101,'COMPUTER ENGNEERING',102,'MULTIMEDIA ENGINEERING',103,'SOFTWARE ENGINEERING','ETC') "DNAME" FROM PROFESSOR;

SELECT DEPTNO , NAME , DECODE(DEPTNO,101,DECODE(NAME,'조인형','BEST!')) "ETC" FROM PROFESSOR;

SELECT DEPTNO , NAME , DECODE(DEPTNO,'101',DECODE(NAME,'조인형','BEST!','GOOD!')) "ETC" FROM PROFESSOR;

SELECT DEPTNO , NAME , DECODE(DEPTNO,'101',DECODE(NAME,'조인형','BEST!','GOOD!'),'N/A') "ETC" FROM PROFESSOR;

SELECT * FROM STUDENT;
SELECT NAME , JUMIN , DECODE(SUBSTR(JUMIN,7,1),1,'MAN',2,'WOMAN') "GENGER" FROM STUDENT WHERE DEPTNO1 = 101;

SELECT NAME , TEL , DECODE(SUBSTR(TEL,1,INSTR(TEL,')',1,1)-1),'02','SEOUL','031','GYEONGGI','051','BUSAN','052','ULSAN','055','GYEONGNAM') "LOC" FROM STUDENT WHERE DEPTNO1 = '101';

SELECT * FROM EMP WHERE EMPNO NOT IN (BETWEEN  7654 AND 7782);

SELECT COUNT(ENAME) FROM EMP;

SELECT MAX(SAL) FROM EMP;

SELECT * FROM EMP WHERE SAL = (SELECT MAX(SAL) FROM EMP);

SELECT MAX(SAL),JOB FROM EMP GROUP BY JOB ;

SELECT SUM(SAL) , DEPTNO FROM EMP GROUP BY DEPTNO ORDER BY 1;

SELECT JOB, COUNT(*) FROM EMP GROUP BY JOB;

SELECT JOB, TRUNC(AVG(SAL)) FROM EMP GROUP BY JOB HAVING JOB<>'MANAGER';

SELECT DEPTNO"부서번호" , FLOOR(AVG(SAL))"평균 급여" FROM EMP GROUP BY DEPTNO HAVING AVG(SAL)>=2000;

SELECT * FROM GOGAK;

--3~8 최고값 9~나머지 최고값

SELECT MAX(POINT) FROM GOGAK;

SELECT MAX(POINT) FROM GOGAK WHERE ROWNUM > 0 AND ROWNUM <9
UNION ALL
SELECT MAX(POINT) FROM (SELECT MAX(POINT) , ROWNUM "NO" FROM GOGAK) WHERE NO>8 AND NO<21;

SELECT GNO,GNAME, POINT , NO , DECODE(NO,1,1,2,1,3,1,4,1,5,1,6,1,7,1,8,1,2) FROM(SELECT GNO, GNAME , POINT , ROWNUM "NO" FROM GOGAK);
---------------------------------------------------
SELECT MAX(POINT)
FROM 
(
    SELECT GNO,GNAME, POINT , NO , 
    CASE WHEN NO <9 THEN 1 ELSE 2 END "G"
    FROM
    (
        SELECT GNO, GNAME , POINT , ROWNUM "NO" 
        FROM GOGAK
    ) 
)
GROUP BY G;
-------------------------------------------------
SELECT GNO, GNAME , POINT , ROWNUM "NO" 
        FROM GOGAK;
-------------------------------------------------
SELECT GNO,GNAME, POINT , NO , 
    CASE WHEN NO <9 THEN 1 ELSE 2 END "G"
    FROM
    (
        SELECT GNO, GNAME , POINT , ROWNUM "NO" 
        FROM GOGAK
    ) ;
-------------------------------------------------
SELECT MAX(POINT) , G
FROM
(
    SELECT POINT , CASE WHEN ROWNUM <9 THEN 1 ELSE 2 END "G"
    FROM GOGAK
)
GROUP BY G;
-------------------------------------------------

SELECT *
FROM CAL;
-------------------------------------------------
SELECT WEEK , MAX(NUM_DAY)
FROM CAL
GROUP BY WEEK
ORDER BY WEEK ;
-------------------------------------------------
SELECT *
FROM GOGAK;
-------------------------------------------------
--5명씩 끊어서 POINT의 합을 구하시오.(방법1)
SELECT SUM(POINT) , SS
FROM
(
    SELECT GNO , GNAME , JUMIN , POINT , CASE WHEN ROWNUM <6 THEN 1 WHEN ROWNUM <11 THEN 2 WHEN ROWNUM <16 THEN 3 ELSE 4 END "SS" 
    FROM GOGAK
)
GROUP BY SS
ORDER BY SS;
-------------------------------------------------
--5명씩 끊어서 POINT의 합을 구하시오.(방법2)
SELECT SUM(POINT), CEIL(ROWNUM/5) "5명씩"
FROM GOGAK
GROUP BY CEIL(ROWNUM/5)
ORDER BY CEIL(ROWNUM/5);

-------------------------------------------------
--같은 나이의 POINT의 합을 구하시오.(방법1)
SELECT SUM(POINT), AGE
FROM
    (
        SELECT POINT , CASE SUBSTR(JUMIN,2,1) WHEN '5' THEN '75년생' WHEN '6' THEN '76년생' WHEN '7' THEN '77년생' WHEN '8' THEN '78년생' END "AGE" FROM GOGAK
    )
GROUP BY AGE;
-------------------------------------------------
--같은 나이의 POINT의 합을 구하시오.(방법2)
SELECT SUM(POINT), SUBSTR(JUMIN,1,2) "AGE"
FROM GOGAK
GROUP BY SUBSTR(JUMIN,1,2);
-------------------------------------------------
--월급 순위구하기
SELECT ENAME , SAL ,ROWNUM "순위"
FROM
    (
        SELECT ENAME , SAL
        FROM EMP
        ORDER BY SAL DESC
    );
-------------------------------------------------
SELECT ENAME ,JOB ,DEPTNO, TO_CHAR(S,'$9,999') 
FROM
(
SELECT ENAME , JOB , SAL + (DECODE(COMM,NULL,0,COMM)) "S",DEPTNO
FROM EMP
ORDER BY DEPTNO
)
WHERE DEPTNO = 10
UNION ALL
SELECT NULL,NULL,NULL,TO_CHAR(SUM(SAL),'$9,999')
FROM EMP 
WHERE DEPTNO = 10;
--------------------------------------------------------------------------------------------------
-- 소계, 총계 구하기
SELECT ENAME, JOB, DEPTNO, TO_CHAR(S,'$9,999')
FROM
(
    SELECT ENAME, JOB, SAL+(DECODE(COMM, NULL, 0, COMM)) "S", DEPTNO
    FROM EMP
    ORDER BY DEPTNO
)
WHERE DEPTNO = 10
UNION ALL
SELECT '소계', NULL, NULL, TO_CHAR(SUM(SAL),'$99,999')
FROM EMP
WHERE DEPTNO = 10
UNION ALL
SELECT ENAME, JOB, DEPTNO, TO_CHAR(S,'$99,999')
FROM
(
    SELECT ENAME, JOB, SAL+(DECODE(COMM, NULL, 0, COMM)) "S", DEPTNO
    FROM EMP
    ORDER BY DEPTNO
)
WHERE DEPTNO = 20
UNION ALL
SELECT '소계', NULL, NULL, TO_CHAR(SUM(SAL),'$99,999')
FROM EMP
WHERE DEPTNO = 20
UNION ALL
SELECT ENAME, JOB, DEPTNO, TO_CHAR(S,'$99,999')
FROM
(
    SELECT ENAME, JOB, SAL+(DECODE(COMM, NULL, 0, COMM)) "S", DEPTNO
    FROM EMP
    ORDER BY DEPTNO
)
WHERE DEPTNO = 30
UNION ALL
SELECT '소계', NULL, NULL, TO_CHAR(SUM(SAL),'$99,999')
FROM EMP
WHERE DEPTNO = 30
UNION ALL
SELECT '총계', NULL, NULL, TO_CHAR(SUM(SAL),'$99,999')
FROM EMP;
--------------------------------------------------------------------------------------------------

SELECT  DEPTNO , JOB , AVG(SAL) "급여평균" ,COUNT(SAL) "사원수"
FROM EMP
GROUP BY DEPTNO , JOB
ORDER BY DEPTNO;
--------------------------------------------------------------------------------------------------
SELECT DEPTNO , NULL JOB , ROUND(AVG(SAL),1) AVG_SAL , COUNT(*) CNT_EMP
FROM EMP
GROUP BY DEPTNO
UNION ALL
SELECT DEPTNO , JOB , ROUND(AVG(SAL),1) AVG_SAL , COUNT(*) CNT_EMP
FROM EMP
GROUP BY DEPTNO, JOB
UNION ALL
SELECT NULL DEPTNO, NULL JOB , ROUND(AVG(SAL),1) AVG_SAL ,COUNT(*) CNT_EMP
FROM EMP
ORDER BY DEPTNO, JOB;
--------------------------------------------------------------------------------------------------
SELECT DEPTNO ,JOB , ROUND(AVG(SAL),1) AVG_SAL , COUNT(*) CNT_EMP
FROM EMP
GROUP BY ROLLUP (DEPTNO,JOB);
--------------------------------------------------------------------------------------------------
SELECT * FROM STUDENT;
--------------------------------------------------------------------------------------------------
--학생테이블에서 키(HEIGHT)의 평균을 구하시오
SELECT AVG(HEIGHT)"키평균"
FROM STUDENT;
--------------------------------------------------------------------------------------------------
--학생테이블에서 학과별(DEPTNO1) 학생들의 키의 평균을 구하시오.
SELECT DEPTNO1 "학과", ROUND(AVG(HEIGHT),1)"키평균"
FROM STUDENT
GROUP BY DEPTNO1;
--------------------------------------------------------------------------------------------------
--학생테이블에서 학과별 학년별 학생들의 키의 평균과 소계값을 구하시오.
SELECT DEPTNO1 "학과" ,GRADE"학년",  ROUND(AVG(HEIGHT),1)"키평균" ,COUNT(STUDNO)"학생수"
FROM STUDENT
GROUP BY ROLLUP(DEPTNO1,GRADE);
--------------------------------------------------------------------------------------------------
SELECT * FROM EMP;
--------------------------------------------------------------------------------------------------
--직업별 급여합계 조회 마지막줄에 총합계 추가해서 표시
SELECT JOB"직업", SUM(SAL)"급여총합"
FROM EMP
GROUP BY ROLLUP(JOB);
--------------------------------------------------------------------------------------------------
--EMP테이블에서 직업별 급여합계 조회 마지막줄에 총합계 추가
SELECT JOB"직업", SUM(SAL)"급여총합"
FROM EMP
GROUP BY ROLLUP(JOB);
--------------------------------------------------------------------------------------------------
SELECT * FROM PANMAE;
--------------------------------------------------------------------------------------------------
----PANMAE테이블에서 날짜별 (P_DATE) 상품이(P_CODE) 몇개(P_QTY) 판매되었는지와 소계값을 구하시오
SELECT P_DATE "날짜" , P_CODE "상품", SUM(P_QTY)"판매갯수"
FROM PANMAE
GROUP BY ROLLUP(P_DATE , P_CODE);
--------------------------------------------------------------------------------------------------
--PANMAE테이블에서 상품별 (P_DATE)로 날짜마다(P_DATE) 얼마의 금액(P_TOTAL)이 판매되었는지와 소계값을 구하시오
SELECT P_CODE "상품", P_DATE "날짜", SUM(P_TOTAL)"판매값"
FROM PANMAE
GROUP BY ROLLUP(P_CODE , P_DATE);
--------------------------------------------------------------------------------------------------
SELECT  DEPTNO ,JOB, SUM(SAL) , COUNT(*)
FROM EMP
GROUP BY JOB , ROLLUP(DEPTNO);
--ORDER BY DEPTNO;
--------------------------------------------------------------------------------------------------
SELECT POSITION , SUM(PAY)
FROM PROFESSOR
GROUP BY ROLLUP(POSITION);
--------------------------------------------------------------------------------------------------
SELECT GRADE ,AVG(HEIGHT) , DEPTNO1 , COUNT(*)
FROM STUDENT
GROUP BY ROLLUP(GRADE,DEPTNO1);
--------------------------------------------------------------------------------------------------
학년별 몸무게 평균 /전체학년 몸무게 평균
SELECT GRADE , AVG(WEIGHT)
FROM STUDENT
GROUP BY ROLLUP(GRADE);
--------------------------------------------------------------------------------------------------
SELECT WEEK , 
MAX(DECODE(DAY,'일',NUM_DAY)) "조강지처가 좋더라",
MAX(DECODE(DAY,'월',NUM_DAY)) "썬연료가 좋더라",
MAX(DECODE(DAY,'화',NUM_DAY)) "친구는 오랜친구",
MAX(DECODE(DAY,'수',NUM_DAY)) "죽마고우",
MAX(DECODE(DAY,'목',NUM_DAY)) "국민연료",
MAX(DECODE(DAY,'금',NUM_DAY)) "썬연료",
MAX(DECODE(DAY,'토',NUM_DAY)) "국민연료 썬연료"
FROM CAL
--WHERE WEEK =1
GROUP BY WEEK
ORDER BY WEEK;
--------------------------------------------------------------------------------------------------
SELECT DEPTNO ,JOB  
FROM EMP
ORDER BY DEPTNO;


SELECT DEPTNO , 
COUNT(DECODE(JOB,'CLERK',0))"CLERK",  
COUNT(DECODE(JOB,'MANAGER',0))"MANAGER",
COUNT(DECODE(JOB,'PRESIDENT',0))"PRESIDENT",
COUNT(DECODE(JOB,'ANALYST',0))"ANALYST",
COUNT(DECODE(JOB,'SALESMAN',0))"SALESMAN"
FROM EMP
GROUP BY DEPTNO 
ORDER BY DEPTNO;
--------------------------------------------------------------------------------------------------
SELECT *
FROM PROFESSOR;
--------------------------------------------------------------------------------------------------
SELECT  
FLOOR(AVG(DECODE(POSITION,'정교수',PAY)))"정교수",
FLOOR(AVG(DECODE(POSITION,'조교수',PAY)))"조교수",
FLOOR(AVG(DECODE(POSITION,'전임강사',PAY)))"전임강사"
FROM PROFESSOR
ORDER BY POSITION;
--------------------------------------------------------------------------------------------------
--EMP 타입별 DEPTNO별 PAY의합
계약직 1줄로 바꾸고 1008 1009 등 이것을 위로 올린다. 거기에 금액뿌리기
SELECT
EMP_TYPE , 
SUM(DECODE(DEPTNO,1008,PAY))"1008",
SUM(DECODE(DEPTNO,1009,PAY))"1009",
SUM(DECODE(DEPTNO,1010,PAY))"1010",
SUM(DECODE(DEPTNO,1011,PAY))"1011"
FROM EMP2
WHERE EMP_TYPE = '계약직'
GROUP BY EMP_TYPE ;



