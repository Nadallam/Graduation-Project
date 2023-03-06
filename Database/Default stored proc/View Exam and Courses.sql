Create proc sp_Question_View @ExamID int
	as
		begin try
			Select q.QuestionID ,c.CourseName, q.Question ,q.ModelAnswerChar , qa.AnswerChar , qa.AnswerChoise
			from Question q, QuestionAnswer qa , Course c , Exam e
			where q.QuestionID=qa.QuestionID and e.CourseID = c.CourseID and q.CourseID = c.CourseID and E.ExamID = @ExamID
		end try
		begin catch
			Print 'Error, Question ID does not exist'
		end catch


go

create proc [dbo].[sp_Course_all_info]
as
begin try
		select c.CourseID ID, c.CourseName [Course Name], CONCAT(c.Duration , ' Months')as Duration
		, iif(c.CourseType = 1 ,'Technical Course','Soft Skills') [Course Type] , iif(c.Required = 1 , 'TRUE','FALSE') as [Required], t.TrackName as [Track Name],
		t.Branch as [Branch]
		from course c ,Track t, TrackCourse tc
		where  c.CourseID = tc.CourseID and t.TrackID = tc.TrackID 

end	try
begin catch
			Print 'Error, Course ID does not exist'
   end catch

go
create proc [dbo].[sp_view_Course_by_course_name] @name nvarchar(30)
as
begin try
		select c.CourseID ID, c.CourseName [Course Name], CONCAT(c.Duration , ' Months')as Duration
		, iif(c.CourseType = 1 ,'Technical Course','Soft Skills') [Course Type] , iif(c.Required = 1 , 'TRUE','FALSE') as [Required], t.TrackName as [Track Name],
		t.Branch as [Branch]
		from course c ,Track t, TrackCourse tc
		where  c.CourseID = tc.CourseID and t.TrackID = tc.TrackID and CourseName = @name

end	try
begin catch
			Print 'Error, Course ID does not exist'
   end catch

   go
Create proc [dbo].[sp_view_Course_by_course_id] @id int
 as
   begin try
      select c.CourseID ID, c.CourseName [Course Name], CONCAT(c.Duration , ' Months')as Duration
		, iif(c.CourseType = 1 ,'Technical Course','Soft Skills') [Course Type] , iif(c.Required = 1 , 'TRUE','FALSE') as [Required], t.TrackName as [Track Name],
		t.Branch as [Branch]
		from course c ,Track t, TrackCourse tc
		where  c.CourseID = tc.CourseID and t.TrackID = tc.TrackID and c.CourseID=@id
   end try
   begin catch
			Print 'Error, Course ID does not exist'
   end catch


go
create proc [dbo].[sp_view_course_by_track_name] @name nvarchar(30)
as
begin try  
		select c.CourseID ID, c.CourseName [Course Name], CONCAT(c.Duration , ' Months')as Duration
		, iif(c.CourseType = 1 ,'Technical Course','Soft Skills') [Course Type] , iif(c.Required = 1 , 'TRUE','FALSE') as [Required], t.TrackName as [Track Name],
		t.Branch as [Branch]
		from course c ,Track t, TrackCourse tc
		where  c.CourseID = tc.CourseID and t.TrackID = tc.TrackID and t.TrackName = @name
end try
begin catch
			Print 'Error, Course ID does not exist'
   end catch




create proc return_exam_time_1 @coursename nvarchar(30)
as
select cast(Exam_Time as nvarchar(20)) from Course
where CourseName = @coursename