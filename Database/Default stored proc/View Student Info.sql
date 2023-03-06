CREATE proc [dbo].[sp_Student_all] 
as
		begin try
			select s.StudentID ID,s.FirstName + ' ' + s.LastName as [Full Name], s.Age Age, 
		iif(s.Gender=1,'Female ','Male' )as Gender
		, s.EnrollmentDate EnrollmentDate
		,iif(s.Graduate=1,'True','False')as Graduate , s.GraduationDate GraduationDate, s.MaritalStatus MaritalStatus, 
		s.MilitaryStatus MilitaryStatus, 
		iif(s.RelatedFaculty=1,'Yes','No') as [Related Faculty]
		,s.University University, A.City City, A.Town Town
		from Student s  , StudentAddress as A
		where A.StudentID=s.StudentID
		end try
		begin catch
			Print 'Error, Something went wrong'
		end catch


GO
CREATE proc [dbo].[sp_Student_by_id] @id int
as
		begin try
			select s.StudentID ,s.FirstName + ' ' + s.LastName as [Full Name] , s.Age ,
		iif(s.Gender=1,'Female ','Male' )as Gender, s.EnrollmentDate
		,s.Graduate , s.GraduationDate , s.MaritalStatus , s.MilitaryStatus , 
		iif(s.RelatedFaculty=1,'Yes','No') as [Related Faculty]
		,s.University , A.City , A.Town
		from Student s  join StudentAddress as A
		on A.StudentID=s.StudentID
		where a.StudentID = @id
		end try
		begin catch
			Print 'Error, Something went wrong'
		end catch
go

create proc [dbo].[sp_Student_by_fname] @name nvarchar(30)
as

		begin try
		select s.StudentID ,s.FirstName + ' ' + s.LastName as [Full Name] , s.Age ,
		iif(s.Gender=1,'Female ','Male' )as Gender , s.EnrollmentDate
		,iif(s.Graduate=1,'True','False')as Graduate , s.GraduationDate , s.MaritalStatus , s.MilitaryStatus , 
		iif(s.RelatedFaculty=1,'Yes','No') as [Related Faculty]
		,s.University , A.City , A.Town
		from Student s  join StudentAddress as A
		on A.StudentID=s.StudentID
		where FirstName = @name
		end try
		begin catch
		print 'Error, Invalid Name'
		end catch

go
create proc [dbo].[sp_Student_by_gender] @gender bit
as
		begin try
		select s.StudentID ,s.FirstName + ' ' + s.LastName as [Full Name], s.Age ,
		iif(s.Gender=1,'Female ','Male' )as Gender, s.EnrollmentDate
		,iif(s.Graduate=1,'True','False')as Graduate , s.GraduationDate , s.MaritalStatus , s.MilitaryStatus ,
		iif(s.RelatedFaculty=1,'Yes','No') as [Related Faculty]
		,s.University , A.City , A.Town
		from Student s  join StudentAddress as A
		on A.StudentID=s.StudentID
		where Gender = @gender
		end try
		begin catch
		print 'Error'
		end catch

go
create Proc [dbo].[sp_Student_by_university] @university nvarchar(50)
as
		begin try
		select s.StudentID ,s.FirstName + ' ' + s.LastName as [Full Name], s.Age ,
		iif(s.Gender=1,'Female ','Male' )as Gender, s.EnrollmentDate
		,iif(s.Graduate=1,'True','False')as Graduate , s.GraduationDate , s.MaritalStatus , s.MilitaryStatus , 
		iif(s.RelatedFaculty=1,'Yes','No') as [Related Faculty]
		,s.University , A.City , A.Town
		from Student s  join StudentAddress as A
		on A.StudentID=s.StudentID
		where University = @university
		end try
		begin catch
		print 'Error, Invalid Name'
		end catch


go
create proc [dbo].[sp_Student_by_enrollmentdate] @date date
as
		begin try
		select s.StudentID ,s.FirstName + ' ' + s.LastName as [Full Name], s.Age ,
		iif(s.Gender=1,'Female ','Male' )as Gender, s.EnrollmentDate
		,iif(s.Graduate=1,'True','False')as Graduate , s.GraduationDate , s.MaritalStatus , s.MilitaryStatus , 
		iif(s.RelatedFaculty=1,'Yes','No') as [Related Faculty]
		,s.University , A.City , A.Town
		from Student s  join StudentAddress as A
		on A.StudentID=s.StudentID
		where EnrollmentDate = @date
		end try
		begin catch
		print 'Error, Invalid Date'
		end catch


go
create proc [dbo].[sp_Student_by_Gradeuated] @g bit
as
		begin try
		select s.StudentID ,s.FirstName + ' ' + s.LastName as [Full Name], s.Age , 
		iif(s.Gender=1,'Female ','Male' )as Gender, s.EnrollmentDate
		,iif(s.Graduate=1,'True','False')as Graduate , s.GraduationDate , s.MaritalStatus , s.MilitaryStatus , 
		iif(s.RelatedFaculty=1,'Yes','No') as [Related Faculty]
		,s.University , A.City , A.Town
		from Student s  join StudentAddress as A
		on A.StudentID=s.StudentID
		where Graduate = @g
		end try
		begin catch
		print 'Error, Invalid'
		end catch
GO
create proc sp_select_enrollmentdate_view_student
as
select EnrollmentDate from Student

create proc [dbo].[sp_Student_by_lastname] @name nvarchar(30)
as

		begin try
		select s.StudentID ,s.FirstName + ' ' + s.LastName as [Full Name] , s.Age ,
		iif(s.Gender=1,'Female ','Male' )as Gender , s.EnrollmentDate
		,iif(s.Graduate=1,'True','False')as Graduate , s.GraduationDate , s.MaritalStatus , s.MilitaryStatus , 
		iif(s.RelatedFaculty=1,'Yes','No') as [Related Faculty]
		,s.University , A.City , A.Town
		from Student s  join StudentAddress as A
		on A.StudentID=s.StudentID
		where LastName = @name
		end try
		begin catch
		print 'Error, Invalid Name'
		end catch


create Proc [dbo].[sp_Student_by_track] @trackid int
as
		begin try
		select s.StudentID ,s.FirstName + ' ' + s.LastName as [Full Name], s.Age ,
		iif(s.Gender=1,'Female ','Male' )as Gender, s.EnrollmentDate
		,iif(s.Graduate=1,'True','False')as Graduate , s.GraduationDate , s.MaritalStatus , s.MilitaryStatus , 
		iif(s.RelatedFaculty=1,'Yes','No') as [Related Faculty]
		,s.University , A.City , A.Town
		from Student s  join StudentAddress as A
		on A.StudentID=s.StudentID
		where s.TrackID=@trackid
		end try
		begin catch
		print 'Error, Track ID'
		end catch


		
create Proc [dbo].[sp_Student_by_relatedFaculty] @rf bit
as
		begin try
		select s.StudentID ,s.FirstName + ' ' + s.LastName as [Full Name], s.Age ,
		iif(s.Gender=1,'Female ','Male' )as Gender, s.EnrollmentDate
		,iif(s.Graduate=1,'True','False')as Graduate , s.GraduationDate , s.MaritalStatus , s.MilitaryStatus , 
		iif(s.RelatedFaculty=1,'Yes','No') as [Related Faculty]
		,s.University , A.City , A.Town
		from Student s  join StudentAddress as A
		on A.StudentID=s.StudentID
		where s.RelatedFaculty=@rf
		end try
		begin catch
		print 'Error, Invalid'
		end catch




	--	1034, 645