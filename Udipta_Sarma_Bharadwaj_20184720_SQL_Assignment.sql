select * from scott.dept;
select * from scott.emp;
--1) List the emps who are senior to their own manager. 
select * from scott.emp em, scott.emp ma where em.empno = ma.mgr and em.hiredate < ma.hiredate;


--2) List the emps whose sal greater than blakes sal. 
select * from scott.emp em where em.sal > (select sal from scott.emp where ename = 'BLAKE');

--3) List the dept 10 emps whose sal>allen sal. 
select * from scott.emp em where em.sal > (select sal from scott.emp where ename = 'ALLEN') and em.deptno = 10;

--4) List the mgrs who are senior to king and who are junior to smith.
select * from scott.emp where hiredate < (select hiredate from scott.emp where ename= 'KING') and hiredate > (select hiredate from scott.emp where ename = 'SMITH');

--5) List the empno,ename,loc,sal,dname,loc of the all the emps belonging to king dept.
select em.empno,em.ename,em.sal,de.loc,de.dname from scott.emp em,scott.dept de where em.deptno = de.deptno and em.deptno = (select deptno from scott.emp where ename='KING');

--6) List the emps whose sal  are greater than the grade of miller. 
select * from scott.emp em where em.sal > (select sal from scott.emp em1 where ename = 'MILLER');

--7) List the emps who are belonging dallas or Chicago with the job same as adams or exp more than smith. 
select * from scott.emp em, scott.dept de where (de.loc = 'DALLAS' or de.loc = 'CHICAGO') and (em.job = (select job from scott.emp where ename = 'ADAMS') or em.hiredate < (select hiredate from scott.emp where ename = 'SMITH'));

--8) List the emps whose sal is same as ford or blake.  
select * from scott.emp em where em.sal = (select sal from scott.emp where ename = 'FORD') or em.sal = (select sal from scott.emp where ename = 'BLAKE');

--9) List the emps whose sal is same as any one of the following.
--Here asking questions invlolving different employee tables.
--Considering them to be present in the same table.

--a) Sal of any clerk of emp1 table. 
select * from scott.emp em where em.job = 'CLERK';

-- b) Any emp of emp2 joined before 82.
select * from scott.emp em where em.hiredate < (select hiredate from scott.emp where to_char(hiredate, 'YY')='82');

-- c) The total remuneration (sal+comm.) of all sales person of Sales dept belonging to emp3 table.
select * from scott.emp em where em.sal = (select sum(em1.sal + em1.comm) from scott.emp em1 where em1.deptno = 30 and em1.job = 'SALESMAN');

--d) Any Grade 4 emps Sal of emp 4 table. 
select * from scott.emp em where em.deptno = 40;

--e) Any emp Sal of emp5 table.
select * from scott.emp em;



--10) List the details of most recently hired emp of dept 30. 
select * from scott.emp em where em.deptno = 30 and em.hiredate = (select max(hiredate) from scott.emp where deptno = 30);

--11) List the highest paid emp of Chicago joined before the most  recently hired emp of grade 2. 
-- Here taken grade as deptno.
select * from scott.emp em where em.sal = (select max(sal) from scott.emp em1, scott.dept de where de.loc = 'CHICAGO' and em1.hiredate = (select max(hiredate) from scott.emp where deptno = 20));

--12) List the highest paid emp working under king. 
select * from scott.emp em where em.sal = (select max(sal) from scott.emp em2 where em2.mgr=(select empno from scott.emp where ename='KING'));

--13) List the empno,ename,deptno,loc of all the emps.
select em.empno, em.ename, de.deptno, de.loc from scott.emp em, scott.dept de where em.deptno = de.deptno;

--14) List the empno,ename,loc,dname of all the depts.,10 and 20.
select em.empno, em.ename, de.loc, de.dname from scott.emp em, scott.dept de where em.deptno = de.deptno and (em.deptno = 10 or em.deptno = 20);

--15) List the empno, ename, sal, loc of the emps working at Chicago dallas with an exp>6ys.
select em.empno, em.ename, em.sal, de.loc from scott.emp em, scott.dept de where em.deptno = de.deptno and (de.loc = 'CHICAGO' or de.loc = 'DALLAS') and (extract(year from sysdate) - extract(year from em.hiredate))>6;

--16) List the emps along with loc of those who belongs to dallas ,newyork with sal ranging from 2000 to 5000 joined in 81.
select em.ename, em.empno, de.loc from scott.emp em, scott.dept de where em.deptno = de.deptno and (de.loc = 'DALLAS' or de.loc = 'NEWYORK') and (em.sal > 2000 and em.sal < 5000) and to_char(em.hiredate, 'YY')='81';

--17) List the empno,ename,sal,job of all emps 
select empno,ename,sal,job from scott.emp;

--18) List the grade 2 and 3 emp of Chicago 
-- Here grade taken as deptno
select em.ename, em.sal, em.job,de.deptno from scott.emp em, scott.dept de where em.deptno = de.deptno and de.loc = 'CHICAGO' and em.deptno in (20,30);


--19) List the emps with loc and grade of accounting dept or the locs dallas or Chicago with the grades 3 to 5 &exp >6y 
select * from scott.emp em, scott.dept de where em.deptno = de.deptno and (de.dname = 'ACCOUNTING' or de.loc in ('DALLAS','CHICAGO') and (extract(year from sysdate) - extract(year from em.hiredate)) >  6);

--20) List the grades 3 emps of research and operations depts.. joined after 1987 and whose names should not be either miller or allen.
-- Here ignoring the grade concept as problem unable to solve without
select * from scott.emp em, scott.dept de where em.deptno = de.deptno and (de.dname in ('RESEARCH','ACCOUNTING') and em.ename not in ('MILLER','ALLEN') and extract(year from em.hiredate) > 1987);

--21) List the emps whose job is same as smith. 
select * from scott.emp em where em.job = (select job from scott.emp where ename = 'SMITH');

--22)  List the emps who are senior to miller. 
select * from scott.emp em where em.hiredate < (select hiredate from scott.emp where ename = 'MILLER');

--23) List the emps whose job is same as either allen or sal>allen
select * from scott.emp em where em.job = (select job from scott.emp where ename = 'ALLEN') or em.sal > (select sal from scott.emp where ename = 'ALLEN');

--GROUP BY CLAUSE

--1.       List the count and average salary for employees in department 20.
select count(em.sal), avg(em.sal) from scott.emp em where em.deptno = 20;

--2.       List names of employees who are older than 30 years in the company. 
select * from scott.emp em where (extract(year from sysdate) - extract(year from em.hiredate)) > 30;

--3.       List the employee name , hire date in the descending order of the hire date.
select em.ename, em.hiredate from scott.emp em order by em.hiredate desc;

--4.       List employee name, salary, PF, HRA, DA and gross; order the results in the ascending order of gross. HRA is 50% of the salary and DA is 30% of the salary.
select em.ename, em.sal, 0.5*em.sal as HRA, 0.3*em.sal as DA from scott.emp em order by sal asc;

--5.       List the department numbers and number of employees in each department
select em.deptno, count(*) from scott.emp em group by em.deptno order by em.deptno asc;


--JOINS

--1.       List employee name, department number and their corresponding department name. 
select em.ename, em.deptno, de.dname from scott.emp em, scott.dept de where em.deptno = de.deptno;

--2.       List employee name and their manager name
select em.ename, em1.ename from scott.emp em inner join scott.emp em1 on em.mgr = em1.empno;

--3.       List employees who work in Research department 
select em.ename,de.dname from scott.emp em, scott.dept de where em.deptno = de.deptno and em.deptno = (select deptno from scott.dept where dname = 'RESEARCH');

--4.       List all rows from EMP table and only the matching rows from DEPT table.
select * from scott.emp em left join scott.dept de on em.deptno = de.deptno;


--SUBQUERIES

--1.       List employees whose job is same as that of Smith 
select * from scott.emp em where em.job = (select job from scott.emp where ename = 'SMITH');

--2.       List employees who have joined after Adam
select * from scott.emp em where em.hiredate > (select hiredate from scott.emp where ename = 'ADAMS');

--3.       List employees who salary us greater than Scott’s salary
select * from scott.emp em where em.sal > (select sal from scott.emp where ename = 'SCOTT');

--4.       List employees getting the max salary
select * from scott.emp em where em.sal = (select max(sal) from scott.emp);

--5.       List employees show salary is > the max salary in deptno 30 
select * from scott.emp em where em.sal > (select max(sal) from scott.emp where deptno = 30);

--6.       List all employees whose department and designation is same as that of employee with empno 7788.
select * from scott.emp em where em.deptno = (select deptno from scott.emp where empno = 7788) and em.job = (select job from scott.emp where empno = 7788);







































