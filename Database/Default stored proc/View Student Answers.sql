create proc [dbo].[view_answer] @id int 
as
		begin try
			Select *
			from StudnetAnswer
			where  StudentID=@id
		end try
		begin catch
			Print 'Error, Something went wrong'
		end catch


Go
create proc [dbo].[view_answer_exam_id] @id int 
as
		begin try
			Select *
			from StudnetAnswer
			where  ExamID=@id
		end try
		begin catch
			Print 'Error, Something went wrong'
		end catch

Go
alter proc [dbo].[view_answer_exam_student_id] @sid int , @eid int
as
		begin try
			Select s.FirstName + ''+s.LastName as 'FullName' ,*
			from StudnetAnswer a, Student s
			where  ExamID=@eid and a.StudentID = @sid and s.StudentID=@sid
		end try
		begin catch
			Print 'Error, Something went wrong'
		end catch
