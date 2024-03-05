-- Lab
select * from Employee

select fname, lname, salary, dno
from Employee

select pname, plocation, dnum
from Project

select fname+' '+lname as [full name],
(salary*1.1 - salary) as [ANNUAL COMM]
from Employee

select SSN, fname from Employee
where salary > 1000

select SSN, fname from Employee
where salary*12 > 10000

select fname, salary from Employee
where sex = 'F'

select dnum, dname from Departments
where mgrssn = 968574

select pnumber, pname, plocation from Project
where dnum = 10

select dname, max(salary), min(salary), avg(salary)
from Departments d inner join Employee e on d.Dnum = e.Dno
group by dname
