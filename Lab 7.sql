--1	ok
create function getNameOfMonth(@date date)
returns varchar(20)
begin
	declare @name varchar(20)
	select @name = format(@date, 'MMMM')
	return @name
end

select dbo.getNameOfMonth('12/10/2002')

--2 wow
create function getValues(@x int, @y int)
returns @t table
(
	value int
)
as
begin
	while @x < @y
	begin
	insert into @t (value) values (@x)
	set @x = @x + 1
	end
	return
end

select * from dbo.getValues(11,15) 

--3	ok
create function stdInfo(@id int)
returns table
as
return
(
	select d.dept_name, s.St_Fname +' '+ s.St_Lname as full_name
	from department d, student s
	where s.Dept_Id = d.Dept_Id and st_id = @id
)

select * from stdInfo(10)

--4	ok
create function getMsg(@id int)
returns varchar(50)
begin
	declare @msg varchar(100)
	declare @fname varchar(20)
	declare @lname varchar(20)
	select @fname = st_fname from student where st_id = @id
	select @lname = st_lname from student where st_id = @id

	if @fname is null and @lname is null
	select @msg = 'First name & last name are null'
	if @fname is null
	select @msg = 'first name is null'
	if @lname is null
	select @msg = 'last name is null'
	else
	select @msg = 'First name & last name are not null'
	return @msg
end

select dbo.getMsg(8)


--5	ok
create function mngData(@mid int)
returns table
as
return
(
	select ins_name, dept_name, manager_hiredate
	from instructor i, department d
	where i.Ins_Id = d.Dept_Manager and d.Dept_Manager = @mid
)

select * from mngData(1)

--6 amazing
create function sName(@name varchar(20))
returns @t table
(
	name varchar(30)
)
as
begin
	if @name = 'first name'
	insert into @t
	select isnull(st_fname, ' ') from student
	else if @name = 'last name'
	insert into @t
	select isnull(st_lname, ' ') from Student
	else if @name = 'full name'
	insert into @t
	select isnull(st_fname +' '+ st_lname, ' ')
	from student
	return
end

select * from sName('first name')

--7
select st_id, left(st_fname,len(st_fname)-1) as NewFirstName
from student

--8
declare @cols varchar(100) = 'st_fname, st_lname, st_age'
declare @Tname varchar(100) = 'student'
declare @sql varchar(100)

set @sql = 'select ' + @cols + ' from ' + @Tname

exec(@sql)


--Part 2: Use Company DB

create function getEmpInformation(@id int)
returns varchar(20)
begin
	declare @name varchar(20)
	select @name = fname from Employee e, Works_for w, Project p
	where e.SSN = w.ESSn and w.Pno = p.Pnumber
	and pnumber = @id
	return @name
end

select dbo.getEmpInformation(100)
