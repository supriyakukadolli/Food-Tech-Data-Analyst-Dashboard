create database project;
#EMPLOYEE DEPARTMENT ANALYSIS
drop table dept;
#2.	  Create the Dept Table as below
create table Dept(
			deptno int primary key, 
            dname varchar(20),
            loc varchar(20));
insert into dept(deptno,dname,loc)
values
(10,"OPERATIONS","BOSTON"),
(20,"RESEARCH","DALLAS"),
(30,"SALES","CHICAGO"),
(40,"ACCOUNTING","NEWYORK");
SELECT * from dept;
drop table employee;
#1.	Create the Employee Table as per the Below Data Provided
create table employee(
				empno int primary key,
                ename varchar(20) unique,
                job varchar(20) default "CLERK",
                mgr int,
                hiredate date,
                salary decimal(10,2) check (salary>0),
                comm decimal(10,2),
                deptno int,
                foreign key (deptno) references dept(deptno));
desc employee;
insert into employee (empno,ename,job,mgr,hiredate,salary,comm,deptno) values
	(7369,"SMITH","CLERK",7902,"1890-12-17",800,NULL,20),
    (7499,"ALLEN","SALESMAN",7698,"1981-02-20",1600,300,30),
	(7521,"WARD","SALESMAN",7698,"1981-02-22",1250,500,30),
	(7566,"JONES","MANAGER",7839,"1981-04-02",2975,NULL,20),
	(7654,"MARTIN","SALESMAN",7698,"1981-09-28",1250,1400,30),
	(7698,"BLAKE","MANAGER",7839,"1981-05-01",2850,NULL,30),
	(7782,"CLARK","MANAGER",7839,"1981-06-09",2450,NULL,10),
	(7788,"SCOTT","ANALYST",7566,"1987-04-19",3000,NULL,20),
	(7839,"KING","PRESIDENT",NULL,"1981-11-17",5000,NULL,10),
	(7844,"TURNER","SALESMAN",7698,"1981-09-08",1500,0,30),    
    (7876,"ADAMS","CLERK",7788,"1987-05-23",1100,NULL,20),
	(7900,"JAMES","CLERK",7698,"1981-12-03",950,NULL,30),
	(7902,"FORD","ANALYST",7566,"1981-12-03",3000,NULL,20),
	(7934,"MILLER","CLERK",7782,"1982-01-23",1300,NULL,10);
select * from employee;
#3.List the Names and salary of the employee whose salary is greater than 1000
select ename,salary from employee where salary>1000;

#4.	List the details of the employees who have joined before end of September 81.
select * from employee where hiredate<"1981-09-30";

#5.List Employee Names having I as second character.
select ename from employee where ename like "_I%";

#6.	List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns
select 
	ename,salary,
	(0.4*salary) as allowances,
	(0.1*salary) as PF,
    (salary + (0.4*salary) - (0.1*salary) + ifnull(comm,0)) as net_salary
    from employee;
    
#7.	 List Employee Names with designations who does not report to anybody
select ename,job,mgr from employee where mgr is null;

#8.List Empno, Ename and Salary in the ascending order of salary.
select empno,ename,salary from employee order by salary;

#9.	How many jobs are available in the Organization ?
select count(distinct job) total_jobs from employee ;

#10.Determine total payable salary of salesman category
select job,sum(salary) from employee 
	where job="salesman";
    
#11.	List average monthly salary for each job within each department 
select job,deptno,round(avg(salary),2) avg_monthly_salary from employee group by job,deptno;

#12.Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.
select e.ename,e.salary,d.dname from employee e join dept d on e.deptno=d.deptno;

#13.Create the Job Grades Table as below
create table Job_Grades(grade char(1),lowest_salary int,highest_salary int);
desc job_grades;
insert into job_grades(grade,lowest_salary,highest_salary)
 values
	("A",0,999),
    ("B",1000,1999),
    ("C",2000,2999),
    ("D",3000,3999),
    ("E",4000,5000);
select * from job_grades;

#14.Display the last name, salary and  Corresponding Grade.
SELECT 
    e.ename AS "Last_Name",
    e.salary AS "Salary",
    j.grade AS "Grade"
FROM 
    employee e
JOIN 
    job_grades j
ON 
    e.salary BETWEEN j.lowest_salary AND j.highest_salary;
	
#15.Display the Emp name and the Manager name under whom the Employee works in the below format .
#Emp Report to Mgr.
select e.ename  emp_name,m.ename mgr_name  from employee e join employee m on e.mgr=m.empno;

select * from employee;
#16.	Display Empname and Total sal where Total Sal (sal + Comm)
select ename,(salary+ifnull(comm,0)) tot_salary  from employee;

#17.	Display Empname and Sal whose empno is a odd number
select empno,ename,salary from employee where mod(empno,2)<>0;

#18.	Display Empname , Rank of sal in Organisation , Rank of Sal in their department
select ename,salary,deptno,rank() over( order by salary DESC) as rnk_in_organisation,
	   rank() over(partition by deptno order by salary) as rank_in_dept from employee
       order by salary desc;
       
#19.Display Top 3 Empnames based on their Salary
select ename,salary from employee order by salary desc limit 3 offset 3;

#20.	 Display Empname who has highest Salary in Each Department.
select ename,salary,deptno from employee
where salary=(select max(salary) from employee);






