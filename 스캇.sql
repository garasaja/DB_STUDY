SELECT HIREDATE FROM EMP WHERE  HIREDATE = '80/12/17';

ALTER SESSION SET NLS_DATE_FORMAT = 'YY/MM/DD';

SELECT * FROM EMP;

SELECT * FROM EMP WHERE SAL BETWEEN 1500 AND 2000;

SELECT * FROM EMP WHERE JOB LIKE 'S%';

SELECT * FROM EMP WHERE JOB LIKE 'S_______';

SELECT * FROM EMP WHERE COMM IS NULL;

SELECT * FROM EMP WHERE COMM IS NOT NULL;

-- ����� �߿� ���ʽ��� 500���� �������!!

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

SELECT DEPTNO , NAME , DECODE(DEPTNO,101,DECODE(NAME,'������','BEST!')) "ETC" FROM PROFESSOR;

SELECT DEPTNO , NAME , DECODE(DEPTNO,'101',DECODE(NAME,'������','BEST!','GOOD!')) "ETC" FROM PROFESSOR;

SELECT DEPTNO , NAME , DECODE(DEPTNO,'101',DECODE(NAME,'������','BEST!','GOOD!'),'N/A') "ETC" FROM PROFESSOR;

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

SELECT DEPTNO"�μ���ȣ" , FLOOR(AVG(SAL))"��� �޿�" FROM EMP GROUP BY DEPTNO HAVING AVG(SAL)>=2000;

SELECT * FROM GOGAK;

--3~8 �ְ� 9~������ �ְ�

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
--5�� ��� POINT�� ���� ���Ͻÿ�.(���1)
SELECT SUM(POINT) , SS
FROM
(
    SELECT GNO , GNAME , JUMIN , POINT , CASE WHEN ROWNUM <6 THEN 1 WHEN ROWNUM <11 THEN 2 WHEN ROWNUM <16 THEN 3 ELSE 4 END "SS" 
    FROM GOGAK
)
GROUP BY SS
ORDER BY SS;
-------------------------------------------------
--5�� ��� POINT�� ���� ���Ͻÿ�.(���2)
SELECT SUM(POINT), CEIL(ROWNUM/5) "5��"
FROM GOGAK
GROUP BY CEIL(ROWNUM/5)
ORDER BY CEIL(ROWNUM/5);

-------------------------------------------------
--���� ������ POINT�� ���� ���Ͻÿ�.(���1)
SELECT SUM(POINT), AGE
FROM
    (
        SELECT POINT , CASE SUBSTR(JUMIN,2,1) WHEN '5' THEN '75���' WHEN '6' THEN '76���' WHEN '7' THEN '77���' WHEN '8' THEN '78���' END "AGE" FROM GOGAK
    )
GROUP BY AGE;
-------------------------------------------------
--���� ������ POINT�� ���� ���Ͻÿ�.(���2)
SELECT SUM(POINT), SUBSTR(JUMIN,1,2) "AGE"
FROM GOGAK
GROUP BY SUBSTR(JUMIN,1,2);
-------------------------------------------------
--���� �������ϱ�
SELECT ENAME , SAL ,ROWNUM "����"
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
-- �Ұ�, �Ѱ� ���ϱ�
SELECT ENAME, JOB, DEPTNO, TO_CHAR(S,'$9,999')
FROM
(
    SELECT ENAME, JOB, SAL+(DECODE(COMM, NULL, 0, COMM)) "S", DEPTNO
    FROM EMP
    ORDER BY DEPTNO
)
WHERE DEPTNO = 10
UNION ALL
SELECT '�Ұ�', NULL, NULL, TO_CHAR(SUM(SAL),'$99,999')
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
SELECT '�Ұ�', NULL, NULL, TO_CHAR(SUM(SAL),'$99,999')
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
SELECT '�Ұ�', NULL, NULL, TO_CHAR(SUM(SAL),'$99,999')
FROM EMP
WHERE DEPTNO = 30
UNION ALL
SELECT '�Ѱ�', NULL, NULL, TO_CHAR(SUM(SAL),'$99,999')
FROM EMP;
--------------------------------------------------------------------------------------------------

SELECT  DEPTNO , JOB , AVG(SAL) "�޿����" ,COUNT(SAL) "�����"
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
--�л����̺��� Ű(HEIGHT)�� ����� ���Ͻÿ�
SELECT AVG(HEIGHT)"Ű���"
FROM STUDENT;
--------------------------------------------------------------------------------------------------
--�л����̺��� �а���(DEPTNO1) �л����� Ű�� ����� ���Ͻÿ�.
SELECT DEPTNO1 "�а�", ROUND(AVG(HEIGHT),1)"Ű���"
FROM STUDENT
GROUP BY DEPTNO1;
--------------------------------------------------------------------------------------------------
--�л����̺��� �а��� �г⺰ �л����� Ű�� ��հ� �Ұ谪�� ���Ͻÿ�.
SELECT DEPTNO1 "�а�" ,GRADE"�г�",  ROUND(AVG(HEIGHT),1)"Ű���" ,COUNT(STUDNO)"�л���"
FROM STUDENT
GROUP BY ROLLUP(DEPTNO1,GRADE);
--------------------------------------------------------------------------------------------------
SELECT * FROM EMP;
--------------------------------------------------------------------------------------------------
--������ �޿��հ� ��ȸ �������ٿ� ���հ� �߰��ؼ� ǥ��
SELECT JOB"����", SUM(SAL)"�޿�����"
FROM EMP
GROUP BY ROLLUP(JOB);
--------------------------------------------------------------------------------------------------
--EMP���̺��� ������ �޿��հ� ��ȸ �������ٿ� ���հ� �߰�
SELECT JOB"����", SUM(SAL)"�޿�����"
FROM EMP
GROUP BY ROLLUP(JOB);
--------------------------------------------------------------------------------------------------
SELECT * FROM PANMAE;
--------------------------------------------------------------------------------------------------
----PANMAE���̺��� ��¥�� (P_DATE) ��ǰ��(P_CODE) �(P_QTY) �ǸŵǾ������� �Ұ谪�� ���Ͻÿ�
SELECT P_DATE "��¥" , P_CODE "��ǰ", SUM(P_QTY)"�ǸŰ���"
FROM PANMAE
GROUP BY ROLLUP(P_DATE , P_CODE);
--------------------------------------------------------------------------------------------------
--PANMAE���̺��� ��ǰ�� (P_DATE)�� ��¥����(P_DATE) ���� �ݾ�(P_TOTAL)�� �ǸŵǾ������� �Ұ谪�� ���Ͻÿ�
SELECT P_CODE "��ǰ", P_DATE "��¥", SUM(P_TOTAL)"�ǸŰ�"
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
�г⺰ ������ ��� /��ü�г� ������ ���
SELECT GRADE , AVG(WEIGHT)
FROM STUDENT
GROUP BY ROLLUP(GRADE);
--------------------------------------------------------------------------------------------------
SELECT WEEK , 
MAX(DECODE(DAY,'��',NUM_DAY)) "������ó�� ������",
MAX(DECODE(DAY,'��',NUM_DAY)) "�㿬�ᰡ ������",
MAX(DECODE(DAY,'ȭ',NUM_DAY)) "ģ���� ����ģ��",
MAX(DECODE(DAY,'��',NUM_DAY)) "�׸����",
MAX(DECODE(DAY,'��',NUM_DAY)) "���ο���",
MAX(DECODE(DAY,'��',NUM_DAY)) "�㿬��",
MAX(DECODE(DAY,'��',NUM_DAY)) "���ο��� �㿬��"
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
FLOOR(AVG(DECODE(POSITION,'������',PAY)))"������",
FLOOR(AVG(DECODE(POSITION,'������',PAY)))"������",
FLOOR(AVG(DECODE(POSITION,'���Ӱ���',PAY)))"���Ӱ���"
FROM PROFESSOR
ORDER BY POSITION;
--------------------------------------------------------------------------------------------------
--EMP Ÿ�Ժ� DEPTNO�� PAY����
����� 1�ٷ� �ٲٰ� 1008 1009 �� �̰��� ���� �ø���. �ű⿡ �ݾ׻Ѹ���
SELECT
EMP_TYPE , 
SUM(DECODE(DEPTNO,1008,PAY))"1008",
SUM(DECODE(DEPTNO,1009,PAY))"1009",
SUM(DECODE(DEPTNO,1010,PAY))"1010",
SUM(DECODE(DEPTNO,1011,PAY))"1011"
FROM EMP2
WHERE EMP_TYPE = '�����'
GROUP BY EMP_TYPE ;



