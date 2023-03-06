Create proc insert_job_by_student 
 @studentid int , @type nvarchar(30) , @title nvarchar(30),
@position nvarchar(30), @salary int
as
insert into Job (JobID , StudentID , JobType , JobTitle , Position , Salary)
values (((select max(JobID)from job)+1),
@studentid , @type , @title , @position , @salary
)