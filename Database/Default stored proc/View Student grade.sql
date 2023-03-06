USE [Examination System]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exam_all]    Script Date: 20-Feb-23 1:57:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_Exam_all] 
as
		begin try
			Select e.ExamID ,e.StudentID ,c.CourseName ,e.Duration ,e.NumberOfQuestions ,e.TotalScore,
				   e.GradeChar 
			from Exam e, Course c
			where  e.CourseID = c.CourseID
		end try
		begin catch
			Print 'Error, Something went wrong'
		end catch




GO
/****** Object:  StoredProcedure [dbo].[sp_Exam_View_by_courseid]    Script Date: 20-Feb-23 1:59:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_Exam_View_by_courseid] @name nvarchar(30)
	as
		begin try
			Select e.ExamID ,e.StudentID ,c.CourseName ,e.Duration ,e.NumberOfQuestions ,e.TotalScore,
				   e.GradeChar 
			from Exam e, Course c
			where c.CourseName = @name and e.CourseID = c.CourseID
		end try
		begin catch
			Print 'Error, Course name does not exist'
		end catch




GO
/****** Object:  StoredProcedure [dbo].[sp_Exam_View_by_examid]    Script Date: 20-Feb-23 1:59:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_Exam_View_by_examid] @ID int
	as
		begin try
			Select e.ExamID ,e.StudentID ,c.CourseName ,e.Duration ,e.NumberOfQuestions ,e.TotalScore,
				   e.GradeChar 
			from Exam e, Course c
			where @ID= e.ExamID and e.CourseID = c.CourseID
		end try
		begin catch
			Print 'Error, Exam ID does not exist'
		end catch


GO
/****** Object:  StoredProcedure [dbo].[sp_Exam_View_by_grade]    Script Date: 20-Feb-23 2:01:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_Exam_View_by_grade] @Grade Char
	as
		begin try
			Select e.ExamID ,e.StudentID ,c.CourseName ,e.Duration ,e.NumberOfQuestions ,e.TotalScore,
				   e.GradeChar 
			from Exam e, Course c
			where e.GradeChar = @Grade and e.CourseID = c.CourseID
		end try
		begin catch
			Print 'Error, Something went wrong'
		end catch


GO
/****** Object:  StoredProcedure [dbo].[sp_Exam_View_by_score]    Script Date: 20-Feb-23 2:01:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_Exam_View_by_score] @score int
	as
		begin try
			Select e.ExamID ,e.StudentID ,c.CourseName ,e.Duration ,e.NumberOfQuestions ,e.TotalScore,
				   e.GradeChar 
			from Exam e, Course c
			where @score= e.TotalScore and e.CourseID = c.CourseID
		end try
		begin catch
			Print 'Error, Something went wrong'
		end catch


GO
/****** Object:  StoredProcedure [dbo].[sp_Exam_View_by_studentid]    Script Date: 20-Feb-23 2:02:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_Exam_View_by_studentid] @ID int
	as
		begin try
			Select e.ExamID ,e.StudentID ,c.CourseName ,e.Duration ,e.NumberOfQuestions ,e.TotalScore,
				   e.GradeChar 
			from Exam e, Course c
			where  e.StudentID = @ID and e.CourseID = c.CourseID
		end try
		begin catch
			Print 'Error, Something went wrong'
		end catch


GO
create proc sp_select_course_name_for_view_student_grade
as
select CourseName
from Course c , Exam e
where c.CourseID = e.CourseID

GO
