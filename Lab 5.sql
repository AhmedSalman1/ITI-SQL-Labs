----Part-1: Use ITI DB----
--1
select ins_name, dept_name
from Instructor i, Department d
where i.Dept_Id = d.Dept_Id

--2
select st_fname+' '+st_lname as [full name], crs_name, grade
from Stud_Course sc inner join Course c on c.Crs_Id = sc.Crs_Id
inner join Student s on s.St_Id = sc.St_Id

--3
select top_name, count(*) NoOfCourses
from Course c inner join Topic t on c.Top_Id = t.Top_Id
group by top_name

--4
select max(salary) as max, min(salary) as min from Instructor

--5
select * from Instructor
where salary < (select avg(salary) from Instructor)

--6
select dept_name
from Department d inner join Instructor i on d.Dept_Id = i.Dept_Id
where salary = (select min(salary) from Instructor)


----Part-2: Use AdventureWorks DB----
--1
select salesorderid, shipdate from sales.SalesOrderHeader
where ShipDate between '7/28/2008' and '7/29/2014'

--2
select productid, name from Production.Product
where StandardCost < 110.00

--3
select productid, name from Production.Product
where Weight is null

--4
select * from Production.Product
where Color in ('silver', 'black', 'red')

--5
select * from Production.Product
where name like 'b%'

--6 no
select * into customer_Archive1
from sales.Customer
where 1 = 2

select * from customer_Archive1