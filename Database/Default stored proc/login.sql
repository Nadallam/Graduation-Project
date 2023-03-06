create proc Student_login @username nvarchar(30) , @password nvarchar(30)
as
select Username , Password
from Student
where Username = @username and Password = @password

Go
create proc Admin_login @username nvarchar(30) , @password nvarchar(30)
as
select Username , Password
from Admin
where username = @username and Password = @password

Go
create proc Instructor_login @username nvarchar(30) , @password nvarchar(30)
as
select Username , Password
from Instructor
where Username = @username and Password = @password