--1
select dnum, dname, fname+' '+lname as [full name]
from Departments D, Employee E
where d.MGRSSN = e.SSN

--2
select dname, pname
from Departments D inner join Project P
on d.Dnum = p.Dnum

--3
select d.*, fname+' '+lname as [full name]
from Dependent d, Employee e
where d.ESSN = e.SSN

--4
select pnumber, pname, plocation
from Project where city in('cairo', 'alex')

--5
select * from Project
where pname like 'a%'

--6
select fname, dnum, salary
from Employee e, Departments d
where dnum = 30 and (salary between 1000 and 2000)

--7  2ways
select fname, dnum, p.Pname
from Employee e, Works_for w, Project p
where e.SSN = w.ESSn and w.Pno = p.Pnumber
and p.pname = 'Al Rehab' and w.Hours >= 10

select fname, dnum, p.Pname
from Employee e join Works_for w on e.SSN = w.ESSn
join Project p on w.Pno = p.pnumber
where p.pname = 'Al Rehab' and w.Hours >= 10
 
--8
select fname
from Employee e
where Superssn = 223344

--9
select e.fname, p.pname
from Employee e join Works_for w on e.SSN = w.ESSn
join Project p on w.Pno = p.Pnumber

--10
select pnumber, dname, lname, address, bdate
from project p inner join Departments d on p.Dnum = d.Dnum
inner join Employee e on d.MGRSSN = e.SSN
where p.city = 'Cairo'

--11
select e.*
from Employee e, Departments d
where e.SSN = d.MGRSSN

--12
select lname
from Employee e, Departments d
where e.SSN = d.MGRSSN and d.MGRSSN not in (select essn from Dependent)



--1
insert into Employee (fname, lname, ssn, bdate, address, sex, salary,
superssn, dno)
values('Ahmed', 'Ali', 102672, '10/12/2002', 'Damas', 'M', 3000, 112233,
30)

--2
insert into Employee (fname, lname, ssn, bdate, address, sex, dno)
values('Mohamed', 'Ali', 102675, '11/5/2006', 'Damas', 'M', 30)

--3
update Employee
set salary = salary*1.2
where ssn = 102672

select * from Employee where ssn = 102672