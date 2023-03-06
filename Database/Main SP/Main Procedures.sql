
 ----------Main Procedures---------------
 /*selecting random raws from questions and storing them in exam_Question table 

 */


 -------------------Exam Generation-------------------------------

 create proc Exam_Generation  @courseID int, @numQuestion int =10
 as
	begin 
	insert into Examinfo (CourseID,Date)values(@courseID,GETDATE())
	declare @exam_id int = (select max( ExamID)  from Examinfo )

 --retrieving all related question fro specific course then store 10 randomly of them in a table
		  declare @table table (Q_ID int)
	
						insert into @table
						select * from
						(select  top(10)  q.QuestionID
						from Question q, Course c
						where q.CourseID = @courseID
						group by q.QuestionID
						order by NEWID()) x
		
	-----storing the selected 10 question in exam question table
	
					 insert into ExamQuestion (ExamID,QuestionID)
					 select @exam_id,  * from @table 
					 
					 select 'done';
   
end

--------------------------------------------------------------------------------
-------------------------------Exam Answer---------------------------------------

 create proc Exam_Answers2 @ExID int , @stID int ,@answer char(1), @QID int
 as
 begin

   ----calc the score for each question
		   declare @score int
			  if (@answer=(Select ModelAnswerChar from Question where QuestionID=@QID))
				set @score =10
			  else 
			   set @score =0

   ---storing each answer
	 insert into StudnetAnswer
	 values(@stID,@ExID,@QID,@answer,@score)
	 select 'done'
end
----------------------------------------------------------------------------------------
 --------------Exam Correction-----------------------------------

  create proc Exam_Correction2 @ExID int , @stID int ,@Duration int 
  as 
	begin
	---calc total score and grade
	declare @totalScore int
		set @totalScore=(select sum(Score) 
						from StudnetAnswer
						where StudentID = @stID and ExamID=@ExID)
		
		declare @totalGrade char(5)
		            IF @totalScore <= 40
							SET @totalGrade = 'F'
					else IF @totalScore >=50 and @totalScore <= 60
							SET @totalGrade = 'C'
                    else if @totalScore >=70 and @totalScore <=80
					  SET @totalGrade = 'B' 
					  else 
					  SET @totalGrade = 'A'
         Declare @numOfQuestion tinyint
		 set @numOfQuestion =(select count(QuestionID) from StudnetAnswer where  StudentID = @stID and ExamID=@ExID)
	
	---- storing the final grade for the exam 				  
	   declare @CourseID int
		set @CourseID=(select courseID  
						from Examinfo  
						where ExamID = @ExID)
        insert into Exam values(@ExID,@stID, @CourseID,@Duration,@numOfQuestion,@totalScore,@totalGrade)
		select 'your answers have been submitted.'
end

 --------------------------------------------------------
 ---------Retrieve all the Questions for specific Exam-----------------

 create proc Sp_ExamQuestion2 @examid int
 as 
 begin

	   select q.Question from Question q inner join ExamQuestion e on e.ExamID=@examid and e.QuestionID=q.QuestionID

 end


 
  --------------------------------------------------------
 ---------Retrieve all the answer choice for specific Question (used in loop in C#)-----------------
 
 
 create proc Sp_QuestionAnswers @eid int
 as 
 begin

	   select AnswerChoise from QuestionAnswer where QuestionID=@eid
 end


 ---------------------------------------------------------------------

 ---------retreive all the question id for specific exam to be uesd in loop in C# to retreive their answers---------------------

create proc Sp_ExamQuestionID @examid int
 as 
 begin

	   select q.QuestionID from Question q inner join ExamQuestion e on e.ExamID=@examid and e.QuestionID=q.QuestionID

 end


 ----------------------------------------------------------------------------------

 --------------Retreive the courses that the student didnot take their exams----------
 
 
create proc Schedule_Exam @sid int
as
begin
	select c.CourseName from Course c inner join TrackCourse t 
					on  c.CourseID = t.CourseID 
					inner join Student s 
					on s.TrackID=t.TrackID and s.StudentID=@sid
					except
	select c.CourseName from Course c inner join Exam on c.CourseID=Exam.CourseID and StudentID=@sid
