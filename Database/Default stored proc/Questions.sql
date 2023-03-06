CREATE proc [dbo].[sp_insert_new_question_and_choises]
 @coursename nvarchar(30), @question nvarchar(max),@modelanswer char(1)
 , @ChoiseA nvarchar(max) , @ChoiseB nvarchar(max), @Choisec nvarchar(max)
as
begin try
insert into Question (CourseID , Question , ModelAnswerChar)
values ((select CourseID from Course where CourseName = @coursename),
		 @question , @modelanswer)

 insert into QuestionAnswer (QuestionID , AnswerChar , AnswerChoise)
 values (
 (select max(QuestionID) from Question),'A' , @ChoiseA
 )
 insert into QuestionAnswer (QuestionID , AnswerChar , AnswerChoise)
 values (
 (select max(QuestionID) from Question),'B', @ChoiseB
 )
 insert into QuestionAnswer (QuestionID , AnswerChar , AnswerChoise)
 values (
 (select max(QuestionID) from Question),'C', @ChoiseC
 )
end try
begin catch
print 'Error'
end catch

Go
create proc [dbo].[sp_select_course_name]
as
select CourseName
from Course
GO