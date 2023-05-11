SELECT e1.*
FROM
( ( SELECT e2.job, e2.deptno, SUM(e2.sal) summegeh
FROM emp e2
GROUP BY e2.job, e2.deptno
) e3
PIVOT ( SUM(e3.summegeh)
FOR DEPTNO IN (10, 20, 30)
)
) e1;

SELECT e1.* FROM
   (    ( SELECT e2.job, e2.deptno, SUM(e2.sal) summegeh
            FROM emp e2
            GROUP BY e2.job, e2.deptno
        ) e3
    PIVOT ( SUM(e3.summegeh)
    FOR job IN ('CLERK', 'MANAGER')
        )
    ) e1;
    
    
    
SELECT e1.empno, e1.ename, e1.job, e1.sal , e1.comm
FROM
emp e1;

SELECT e1.empno, e1.ename, e1.job, e1.zahlungsart, e1.monatszahlen
    FROM    (emp e2
               UNPIVOT ( monatszahlen FOR  Zahlungsart IN
                            (SAL AS 'Gehalt', COMM AS 'Provision')
                        )
            ) e1
    ORDER BY e1.empno;
