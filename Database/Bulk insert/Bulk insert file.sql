use master
USE [master];
GO
BACKUP DATABASE [Examination System]
TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\ExamSystem2.bak' 
WITH NOFORMAT, NOINIT,
NAME = N'ExamSystem2-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10;
GO
-------Bulk insert for instructor--------------
create table Stageinstructore(					--######################################################
		InstructorID		int ,
		FirstName	nvarchar(30) not null,
		LastName	nvarchar(30) not null,
		SupervisorID		int,
		InstructorStartDate	date not null,					--Added
		InstructorResignDate	date,							--Added
		Username			nvarchar(20) unique not null,
		[Password]			nvarchar(20) not null,

)

BULK INSERT Stageinstructore
from 'E:\iti 4 months\Final project\Data\Instructor.csv'
with (
format='CSV',
FIRSTROW = 1,
FIELDTERMINATOR=',',
ROWTERMINATOR='0x0a'
);

insert into Instructor(InstructorFirstName,InstructorLastName,SupervisorID,InstructorStartDate,InstructorEndDate,Username,Password)
select FirstName,LastName,SupervisorID,InstructorStartDate,InstructorResignDate,Username,Password from Stageinstructore

-----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-----bulk insert for track--------------------------
create table stageTrack(trackid int,trackname nvarchar(30),branch nvarchar(30) )

BULK INSERT stageTrack
from 'E:\iti 4 months\Final project\Data\Track.csv'
with (
format='CSV',
FIRSTROW = 1,
FIELDTERMINATOR=',',
ROWTERMINATOR='0x0a'
);


insert into Track (TrackName,Branch)
select trackname,branch from stageTrack

update Track 
set NumberOfStudents =(
select count(StudentID) from Student inner join Track on Student.TrackID=Track.TrackID)
select * from Track
------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-----bulk insert for Course--------------------------

create table stagecourse(courseid int,coursname nvarchar(30),Duration int, type bit,requird bit )

BULK INSERT stagecourse
from 'E:\iti 4 months\Final project\Data\Course.csv'
with (
format='CSV',
FIRSTROW = 1,
FIELDTERMINATOR=',',
ROWTERMINATOR='0x0a'
);

insert into Course(CourseName,Duration,CourseType,Required)
select courseid,Duration,type,requird from stagecourse


------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-----bulk insert for TrackCourse--------------------------
BULK INSERT TrackCourse
from 'E:\iti 4 months\Final project\Data\TrackCourse.csv'
with (
format='CSV',
FIRSTROW = 1,
FIELDTERMINATOR=',',
ROWTERMINATOR='0x0a'
);


------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-----bulk insert for InstructorCourse--------------------------
BULK INSERT InstructorCourse
from 'E:\iti 4 months\Final project\Data\InstructorCourse.csv'
with (
format='CSV',
FIRSTROW = 1,
FIELDTERMINATOR=',',
ROWTERMINATOR='0x0a'
);



------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-----bulk insert for student--------------------------

create table StageStudent(
	  StudentID			int ,
        TrackID				int ,
        FirstName			nvarchar(20),
        LastName			nvarchar(20),
		DateOfBirth			date not null,
	MilitaryStatus		char(9),
        Gender				bit ,
        EnrollmentDate		date,	
		GraduationDate		date,--Manually increment by a year untill 2019 goes down then up again 1/1/2017 ==> 30/09/2017 ....... 1/1/2023 --
		Graduate			bit ,					--Together with EntrollmentDate
								
		MaritalStatus		char(9) ,				--ONLY collect them while registering and will not update with time
		RelatedFaculty		bit ,
		University			varchar(50) ,
		Username			nvarchar(20)  ,
		[Password]nvarchar(20) unique
	 
	 )

BULK INSERT StageStudent
from 'E:\iti 4 months\Final project\Data\Student.csv'
with (
format ='CSV',
FIELDTERMINATOR=',',
ROWTERMINATOR='0x0a'
--datafiletype = 'char'
);


 insert into Student(TrackID,FirstName,LastName,DateOfBirth,MilitaryStatus,Gender,EnrollmentDate,GraduationDate,Graduate,MaritalStatus,RelatedFaculty,University,Username,Password)
select TrackID,FirstName,LastName,DateOfBirth,MilitaryStatus,Gender,EnrollmentDate,GraduationDate,Graduate,MaritalStatus,RelatedFaculty,University,Username,Password from S
select * from Student

------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-----bulk insert for Job--------------------------




create table job2(
        JobID				int not null,
		StudentID			int not null,
		JobType				varchar(50) ,
		JobTitle			varchar(50) ,
		Position			varchar(50) ,		--If freelance
		Salary	int,
		 
		)	
BULK INSERT job2
from 'E:\iti 4 months\Final project\Data\Job.txt'
with (
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '\n'
);
insert into Job
select * from Job

------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-----bulk insert for Exam--------------------------
create table StageExam(ExamID int,StudentID int,CourseID int ,Duration int,TotalScore tinyint,GradeChar char(1))

BULK INSERT StageExam
from 'E:\iti 4 months\Final project\Data\Exam.csv'
with (
format ='CSV',
FIELDTERMINATOR=',',
ROWTERMINATOR='0x0a'
--datafiletype = 'char'
);

insert into Exam(ExamID,StudentID,CourseID,Duration,TotalScore,GradeChar)
select ExamID,StudentID,CourseID,Duration,TotalScore,GradeChar from StageExam
select * from Exam


------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-----bulk insert for Student answer--------------------------

drop table StageStudentAnswer
create table StageStudentAnswer(
        StudentID			int ,
		ExamID				int ,
		QuestionID			int ,
		AnswerChar			char(1) ,
		Score tinyint , j int
		)

BULK INSERT StageStudentAnswer
from 'E:\iti 4 months\Final project\Data\StudentAnswer.csv'
with (
firstrow=2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
datafiletype = 'char'
);

select * from StageStudentAnswer
select * from StudnetAnswer


insert into StudnetAnswer(StudentID,ExamID,QuestionID,AnswerChar,Score)
select StudentID,ExamID,QuestionID,AnswerChar,Score from StageStudentAnswer
