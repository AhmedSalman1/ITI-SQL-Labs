--1
create schema HR
create schema Company

alter schema HR transfer emp
alter schema Company transfer sales.Department

select * from Company.department



----Part 1: Use ITI DB
--1
create view NewPassStudent
as
	select st_fname+' '+st_lname as fullname, crs_name
	from hr.Student hs inner join Stud_Course sc
	--on hs.St_Id = c.Top_Id
	on hs.St_Id = sc.St_Id
	inner join Course c on sc.Crs_Id = c.Crs_Id
	where Grade > 50

select * from NewPassStudent

--2
create view EncryptedView
with encryption
as
	select ins_name, ct.top_name
	from Company.department cd, HR.Instructor i, Ins_Course ic, Course c, Company.Topic ct
	where cd.Dept_Manager = i.Ins_Id and i.Ins_Id = ic.Ins_Id and ic.Crs_Id = c.Crs_Id and c.Top_Id = ct.Top_Id

select * from EncryptedView

--3
create view Ind_dept
as
	select ins_name, dept_name
	from HR.Instructor hi, Company.Department cd
	where Dept_Name in ('SD', 'Java')

select * from Ind_dept

--4
create view V1
as
	select * from HR.Student
	where St_Address in ('Alex', 'Cairo')
	with check option

select * from V1

update v1
set St_Address = 'tanta'
where St_Address = 'alex'

--5
create table #TempTable
(
	Emp_Name varchar(50),
	TodayTask varchar(50)
)

select * from #TempTable



----Part 3: Use Company DB
--1
create view project_info(PName,NoOfEmps)
as
	select Pname, count(ESSn)
	from Project p, Works_for w
	where p.Pnumber = w.Pno
	group by Pname

select * from project_info

--1 try
create view p_info(Pnew,HowHow)
as
	select Pname, count(ESSn)
	from Project p, Works_for w
	where p.Pnumber = w.Pno
	group by Pname

--2
create view v_count(Pname, NoOfHours)
as
	select Pname, count(Hours)
	from Project p, Works_for w
	where p.Pnumber = w.Pno
	group by Pname

select * from v_count

--3
create view v_D30(Enum,Pnum,Hours_P_inDept30)
as
	select SSN, Pnumber, hours
	from Employee e, Project p, Departments d, Works_for w
	where e.SSN = w.ESSn and w.Pno = p.Pnumber
		and p.Dnum = d.Dnum and d.Dnum = 30

select * from v_D30

--4
create view v_project_500
as
	select Enum
	from v_D30
	where Pnum = 500

select * from v_project_500

--5
drop view v_D30
drop view v_count

--6
select * from project_info

select Pname from project_info
where PName like '%c%'

--7 wow
select * from Works_for

alter table Works_for
Add Enter_Date date

--
create view v_2021_check
as
	select ESSn
	from Works_for
	where Enter_Date between '1/1/2021' and '12/31/2021'
	with check option

select * from v_2021_check

--8 'Amazing'
create rule sal_l_than_2000 as @salary > 2000
sp_bindrule sal_l_than_2000, 'employee.salary'

sp_unbindrule 'employee.salary'
drop rule sal_l_than_2000

--wrong--
--alter table employee
--add constraint sal_l_than_2000 check(salary < 2000)

--9 'Very good'
create table d_num9
(
DeptNo varchar(3) primary key ,
DeptName varchar(20),
Location varchar(5)
)
insert into d_num9 values
('d1','Research','NY'),('d2','Accounting','DS'),('d3','Markiting','KW')

create default def1 as 'NY'

create rule rule1 as @r in ('NY','DS','KW')

sp_addtype loc, 'nchar(2)'

sp_bindefault def1, 'loc'
sp_bindrule rule1, 'loc'

alter table d_num9 alter column Location loc

--7
create table newStudent
(
ID loc
)

--8 no
create sequence seq1
as int
start with 1
increment by 1

-- Insert the first record
INSERT INTO d_num9 (DeptNo, DeptName, Location)
VALUES (4, 'Name1', 'Location1');

-- Insert the second record
INSERT INTO d_num9 (DeptNo, DeptName, Location)
VALUES (NEXT VALUE FOR seq1, 'Name2', 'Location2');

-- Insert the third record
INSERT INTO d_num9 (DeptNo, DeptName, Location)
VALUES (NEXT VALUE FOR seq1, 'Name3', 'Location3');
