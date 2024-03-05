select * from Employee

select Fname, Lname, Salary, Dno
from Employee

select Pname, Plocation, Dnum
from Project

select Fname+' '+Lname as [full name], 
(Salary*10)/100 as [ANNUAL COMM]
from Employee

select ssn, Fname+' '+Lname as [full name]
from Employee
where salary > 1000

select ssn, Fname+' '+Lname as [full name]
from Employee
where salary*12 > 10000

select Fname+' '+Lname as [full name], salary
from Employee
where Sex = 'F'

select Dnum, Dname
from Departments
where mgrssn = 968574

select Pnumber, Pname, Plocation
from project
where Dnum = 10