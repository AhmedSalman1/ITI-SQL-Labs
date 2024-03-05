--use iti
--1.Create a stored procedure without parameters to show the number of students per department name.[use ITI DB]
create proc getStdinDept
as
	select count(*) "NoOfStd", dept_name
	from Student s, Department d
	where s.Dept_Id = d.Dept_Id
	group by dept_name

getStdinDept


--2.Create a stored procedure that will check for the # of employees in the project p1 
--if they are more than 3 print message to the user “'The number of employees in the project p1 is 3 or more'” 
--if they are less display a message to the user “'The following employees work for the project 100'” 
--in addition to the first name and last name of each one. [Company DB]
create proc checkNoOfEmp
as
	declare @No int
	select @No = count(ssn)
	from Employee e, Works_for w
	where e.ssn = w.essn
	if (@NO > 3)
		select 'The number of employees in the project p1 is 3 or more'
	else
		select 'The following employees work for the project p1' as result, e.fname, e.lname
		from Employee e, Works_for w
		where e.ssn = w.essn and w.Pno = 100

checkNoOfEmp


--3.Create a stored procedure that will be used in case there is an old employee has left the project and a new one become instead of him. 
--The procedure should take 3 parameters (old Emp. number, new Emp. number and the project number) 
--and it will be used to update works_on table. [Company DB].
create proc empChange @old int, @new int, @pno int
as
	begin try
	update Works_for
		set ESSn = @new
		where ESSn = @old and Pno = @pno
	end try
	begin catch
		select 'Not allowed'
	end catch

empChange 223344,112233,100

--Hard
--4.Add column budget in project table and insert any draft values in it then Create an Audit table with the following structure:
--ProjectNo 	UserName 	ModifiedDate 	Budget_Old 	Budget_New 
--   p2 	       Dbo 	     2008-01-31	      95000 	  200000 
--This table will be used to audit the update trials on the Budget column (Project table, Company DB).
--Example: If a user updated the budget column then the project number, user name that made that update, the date of the modification and the value of the old and the new budget will be inserted into the Audit table.
--Note: This process will take place only if the user updated the budget column.
alter table project
add budget int

create table update_info
(
ProjectNo varchar(20),
UserName varchar(20),
ModifiedDate date,
Budget_Old int,
Budget_New int
)
select * from update_info

EXEC sp_rename 'update_info.Budget_New', 'Hours_New', 'COLUMN';
EXEC sp_rename 'update_info.Budget_Old', 'Hours_Old', 'COLUMN';

create trigger auditUpdateBudget
on project
after update
as
	if update(budget)
		begin
			declare @pnum int, @old int, @new int
			select @pnum = Pnumber from inserted
			select @new = budget from inserted
			select @old = budget from deleted
			insert into update_info values(@pnum,suser_name(),getdate(),@old,@new)
		end

update Project set budget=7000 where Pnumber=600
select * from update_info

--use iti
--5.Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]
--“Print a message for user to tell him that he can’t insert a new record in that table”
create trigger tPreventI
on department
instead of insert
as
	select 'You can’t insert a new record in that table'

insert into department
values(10,'new','new dept','Alex',1,'1/1/2022')


--use company_sd
--6.Create a trigger that prevents the insertion Process for Employee table in February [Company DB].
create trigger tPreventIinFebruary
on employee
instead of insert
as
	if (format(getdate(), 'MMMM') = 'February')
	begin
		select 'You cannot insert in February'
	end
	else
	begin
		delete from Employee where ssn = (select ssn from inserted)
	end

insert into employee
values('Ahmed','Ali',111262,'6-8-2021','egypt','f',50000,102660,10)


--use iti
--7.Create a trigger on student table after insert to add Row in Student Audit table (Server User Name , Date, Note) where note will be “[username] Insert New Row with Key=[Key Value] in table [table name]”
--ServerUser Name	Date  Note 
create table student_audit
(
	ServerUserName varchar(50),
	Date date,
	Note varchar(50)
)

create trigger std_audit
on student
after insert
as
	declare @note int
	select @note = st_id from inserted
	insert into student_audit
	values(suser_name(), getdate(), @note)

insert into student
values(101,'Ahmed','Mohamed','Cairo',21,10,1)

--alter table student disable trigger t1

--alter table student disable trigger t3
--drop trigger t3
--8.Create a trigger on student table instead of delete to add Row in Student Audit table (Server User Name, Date, Note) where note will be“ try to delete Row with Key=[Key Value]”
create trigger tAddRow
on student
instead of delete
as
	declare @note int
	select @note = st_id from deleted
	insert into student_audit
	values(suser_name(), getdate(), @note)

delete from student
where st_id = 100
select * from student_audit
