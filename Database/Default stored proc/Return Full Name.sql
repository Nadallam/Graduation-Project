create proc return_full_admin_name @username nvarchar(30) , @password nvarchar(30)
as
select FirstName + ' ' + LastName as FullName
from Admin
where Username = @username and Password = @password

Go

create proc return_full_Student_name @username nvarchar(30) , @password nvarchar(30)
as
select FirstName + ' ' + LastName as Fullname
from Student
where Username = @username and Password = @password

Go

create proc return_full_instructor_name @username nvarchar(30) , @password nvarchar(30)
as
select InstructorFirstName + ' ' + InstructorLastName as Fullname
from Instructor
where Username = @username and Password = @password

Go
create proc return_Student_id @username nvarchar(30) , @password nvarchar(30)
as
select StudentID
from Student
where Username = @username and Password = @password