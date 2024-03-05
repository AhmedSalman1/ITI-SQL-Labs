--1.Create a view that displays student full name, course name if the student has a grade more than 50. 
create view displyStdInfo
as
	select st_fname +' '+ st_lname as full_name, crs_name
	from Student s, Stud_Course sc, Course c
	where s.St_Id = sc.St_Id and sc.Crs_Id = c.Crs_Id and sc.grade > 50

select * from displyStdInfo

--2.Create an Encrypted view that displays manager names and the topics they teach. 
create view displyMngInfo(MangerName,TopicName)
with encryption
as
	select ins_name, top_name
	from Instructor i, Ins_Course ic, Course c, Topic t
	where i.Ins_Id = ic.Ins_Id and ic.Crs_Id = c.Crs_Id and c.Top_Id = t.Top_Id

select * from displyMngInfo

--3.Create a view that will display Instructor Name, Department Name for the ëSDí or ëJavaí Department
create view displayDeptInfo
as
	select ins_name, dept_name
	from Instructor i, Department d
	where i.Dept_Id = d.Dept_Id and dept_name in ('SD', 'Java')

select * from displayDeptInfo

--4.Create a view ìV1î that displays student data for student who lives in Alex or Cairo. 
--Note: Prevent the users to run the following query 
--Update V1 set st_address=ítantaí Where st_address=íalexí;		--> use (with check option)

create view V1
as
	select * from Student
	where St_Address in ('Alex', 'Cairo')
	with check option

select * from V1

--OK
update V1
	set St_Address = 'tanta' where St_Address = 'alex'

--5.Create a view that will display the project name and the number of employees work on it. ìUse SD databaseî
create view displayProjectInfo
as
	select pname, count(w.essn) as NoOfEmp
	from Project p, Works_for w
	where p.Pnumber = w.Pno
	group by pname

select * from displayProjectInfo

--6.Create index on column (Hiredate) that allow u to cluster the data in table Department. What will happen? 
create nonclustered index Hiredate_Dept
on Departments([MGRStart Date])
--we will get an error becuase already there's an clustered index on dept_id.
--but i create nonclustered
drop index Hiredate_Dept on departments

select * from Departments

--7.Create index that allow u to enter unique ages in student table. What will happen? 
use iti
create unique index stdAges
on Student(st_age)
-- we will get an error becuase there are a duplicate values in ages col

--8.Using Merge statement between the following two tables [User ID, Transaction Amount]
create table daily_transaction(userId int, transAmount int)
insert into daily_transaction values(1,1000),(2,2000),(3,3000)

create table last_transaction(userId int, transAmount int)
insert into last_transaction values(1,4000),(2,2000),(3,10000)

merge into last_transaction as l
using daily_transaction as d
on l.userId = d.userId
when matched then
	update
		set l.transAmount = d.transAmount
when not matched then
	insert
	values(d.userId, d.transAmount)
output $action;

select * from daily_transaction
select * from last_transaction

--  Ã—»…
create table new_transaction(userId int, transAmount int)
insert into new_transaction values(1,4000),(2,2000),(3,10000)

create table l_transaction(userId int, transAmount int)
insert into l_transaction values(1,1000),(2,2000),(3,3000)

select * from new_transaction
select * from l_transaction

merge into l_transaction as l
using new_transaction as n
on l.userId = n.userId
when matched then
	update
		set l.transAmount = n.transAmount
when not matched then
	insert values(n.userId, n.transAmount)
output $action;

select * from new_transaction
select * from l_transaction
