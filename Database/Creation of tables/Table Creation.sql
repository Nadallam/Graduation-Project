
create table Course (					--######################################################
		CourseID			int primary key identity(1,1),	--Added Identity,
		CourseName			nvarchar(30) unique not null,	--Added Unique
		Duration			int not null,					--Will only be 9 months or less
		CourseType			bit not null,
		[Required]			bit not null,

			CONSTRAINT CHK_Course_CourseName				Check (LEN(CourseName) <= 100),			--Enforce same rule in C#
			CONSTRAINT CHK_Course_Duration					Check (Duration <= 9),					--Months
			CONSTRAINT CHK_Course_CourseType				Check (CourseType IN (1,0)),			--1 = Technical, 0 = Soft Skills
			CONSTRAINT CHK_Course_Required					Check ([Required] IN (1,0))				--1 = Required,  0 = Not Required
)


/*
Nada: Why courses in months not weeks
Hend: Why tracks 9 months only and shouldnt admin be able to add their duration of their course?
*/

create table Track (					--######################################################
		TrackID				int Primary Key identity(1,1),
		TrackName			nvarchar(30) not null,
		Branch				nvarchar(30) not null,					
		NumberOfStudents	int not null,					-- Update it in C# in the same row after a student is created with the trackID in his record

			CONSTRAINT CHK_Track_Branch						Check (Branch in ('Cairo', 'Alexandria', 'Menia')),		--Should be radio button options in C#
			CONSTRAINT CHK_Track_TrackName					Check (LEN(TrackName) <= 100),						--Enforce same rule in C#
)

create table Instructor (				--######################################################
		InstructorID		int Primary Key identity(1,1),
		InstructorFirstName	nvarchar(30) not null,
		InstructorLastName	nvarchar(30) not null,
		InstructorStartDate	date not null,					--Added
		InstructorEndDate	date,							--Added
		SupervisorID		int,
		Username			nvarchar(20) unique not null,
		[Password]			nvarchar(20) not null,

		--	CONSTRAINT CHK_Instructor_InstructorStartDate	Check (InstructorStartDate  <= CAST(GETDATE() as date)),	Removed should change where it cant be before 2016
			CONSTRAINT CHK_Instructor_InstructorEndDate		Check (InstructorEndDate	<= CAST(GETDATE() as date)),
			CONSTRAINT CHK_Instructor_Username				Check (LEN(Username)	BETWEEN 6 AND 20),
			CONSTRAINT CHK_Instructor_Password				Check (LEN([Password])	BETWEEN 6 AND 20),
			--CONSTRAINT FK_Supervisor_Instructor				Foreign Key (SupervisorID) References Instructor(InstructorID)	--Check again 
)


create table Supervisor (
		SupervisorID		int primary key,
	--	InstructorID		int not null,
		StartDate			date not null, 
		EndDate				date,

			CONSTRAINT CHK_StartDate						Check (StartDate   <= CAST(GETDATE() as date) AND StartDate >= CONVERT(DATE, '2010-01-01')), --if error occured try (DATETIME)
			CONSTRAINT CHK_EndDate							Check (EndDate	   <= CAST(GETDATE() as date) AND EndDate >= StartDate),
			CONSTRAINT FK_Instructor_Supervisor				Foreign Key (SupervisorID) References Instructor(InstructorID)
)

create table TrackCourse (				--######################################################
		TrackID				int not null,
		CourseID			int not null,

			CONSTRAINT PK_TrackCourse						Primary Key (TrackID, CourseID), 
			CONSTRAINT FK_Track_TrackCourse					Foreign Key (TrackID) References Track(TrackID),
			CONSTRAINT FK_Course_TrackCourse				Foreign Key (CourseID) References Course(CourseID)
)

create table InstructorCourse (
		InstructorID		int not null,
		CourseID			int not null,

			CONSTRAINT PK_InstructorCourse					Primary Key (InstructorID, CourseID),
			CONSTRAINT FK_Course_InstructorCourse			Foreign Key (CourseID) References Course(CourseID),
			CONSTRAINT FK_Instructor_InstructorCourse		Foreign Key (InstructorID) References Instructor(InstructorID)
)


create table Question (					--######################################################
		QuestionID			int primary key identity(1,1),
		CourseID			int not null ,
		Question			nvarchar(max) not null,			--Added
		ModelAnswerChar		char(1) not null,

			CONSTRAINT FK_Course_Question					Foreign Key (CourseID) References Course(CourseID),
			CONSTRAINT CHK_Question_ModelAnswerChar			Check (ModelAnswerChar in ('A','B','C')),
)

create table QuestionAnswer (			--######################################################
		QuestionID			int not null,
		AnswerChar			char(1) not null,
		AnswerChoise		nvarchar(max) not null,

			CONSTRAINT CHK_QuestionAnswer_AnswerChar		Check (AnswerChar in ('A','B','C')),
			CONSTRAINT PK_QuestionAnswer					Primary key (QuestionID , AnswerChar),
			CONSTRAINT FK_Question_QuestionAnswer			Foreign Key (QuestionID) References Question(QuestionID)
)

create table [Admin] (					--######################################################
		Username			varchar(20) Primary Key,
		[Password]			varchar(20) not null,
        FirstName			nvarchar(20) NOT NULL,
        LastName			nvarchar(20) NOT NULL,

			CONSTRAINT CHK_Admin_Username					Check (LEN(Username) BETWEEN 6 AND 20),
			CONSTRAINT CHK_Admin_Password					Check (LEN([Password])BETWEEN 6 AND 20),
)

CREATE TABLE Student(					--######################################################
        StudentID			int Primary Key identity(1,1),
        TrackID				int not null,
        FirstName			nvarchar(20) not null,
        LastName			nvarchar(20) not null,
		DateOfBirth			date not null,
		Age					as (year(getdate())-year(DateOfBirth)),
        Gender				bit not null,
        EnrollmentDate		date not null,					--Manually increment by a year untill 2019 goes down then up again 1/1/2017 ==> 30/09/2017 ....... 1/1/2023 --
		Graduate			bit not null,					--Together with EntrollmentDate
		GraduationDate		date,							--Together ++ Course Duration
		MilitaryStatus		char(9),						--ONLY collect them while registering and will not update with time
		MaritalStatus		char(9) not null,				--ONLY collect them while registering and will not update with time
		RelatedFaculty		bit not null,
		University			varchar(50) not null,
		Username			nvarchar(20) unique not null,
		[Password]			nvarchar(20) not null,

			CONSTRAINT CHK_Student_DateOfBirth				Check (DateOfBirth  <= CAST(GETDATE() as date)),-- AND DateOfBirth >= DATEDIFF(YEAR, 30, SYSDATETIME()) ),	--If error occured delete after (AND)
			CONSTRAINT CHK_Student_Gender					Check (Gender in (1,0)),																				-- 1 for Female 0 for Male 
			CONSTRAINT CHK_Student_EnrollmentDate			Check (EnrollmentDate  <= CAST(GETDATE() as date)),			
			CONSTRAINT CHK_Student_Graduate					Check (Graduate IN (1,0)),																				-- 1 for Graduate 0 for Ungraduate
			--CONSTRAINT CHK_Student_GraduationDate			Check (GraduationDate  <= CAST(GETDATE() as date)),			
			CONSTRAINT CHK_Student_MilitaryStatus			Check (MilitaryStatus in ('Completed', 'Postponed', 'Exempted')),										-- Should be radio button options in C#			ONLY APPEAR IN C# IF GENDER IS 1 or MALE
			CONSTRAINT CHK_Student_MaritalStatus			Check (MaritalStatus in ('Married', 'Unmarried', 'Divorced', 'Widowed')),								-- Should be radio button options in C#								
			CONSTRAINT CHK_Student_RelatedFaculty			Check (RelatedFaculty in (1,0)),	
			CONSTRAINT CHK_Student_University				Check (University in ('Cairo University', 'Ain Shams University', 'Helwan University', 'Alexandria University', 'Menia University', 'Mansora University')),
			--CONSTRAINT CHK_Student_Username					Check (LEN(Username) BETWEEN 6 AND 20),
			--CONSTRAINT CHK_Student_Password					Check (LEN([Password]) BETWEEN 6 AND 20),			
			CONSTRAINT FK_Track_Student						Foreign Key (TrackID) References Track(TrackID)
        );



create table StudentAddress				--######################################################
(
		StudentID			int not null,
	--	Country				nvarchar(20) Default 'Egypt',					--Only Egyptians can apply
		City				nvarchar (20) not null,
		Town				nvarchar (50) not null,

		--	CONSTRAINT DF_StudentAddress					Check		(Country ='Egypt'),
			CONSTRAINT PK_StudentAddress					Primary Key (StudentID, City),
			CONSTRAINT FK_Student_StudentAddress			Foreign Key (StudentID) References Student(StudentID)
  )

create table Job											--Not all get a job, statiistics about each type title should reflect reality
(
		JobID				int not null,
		StudentID			int not null,
		JobType				varchar(50) ,
		JobTitle			varchar(50) ,
		`Position			varchar(50) Default 'N/A',		--If freelance
		Salary				int not null,

		    CONSTRAINT CHK_Job_Position						Check (Position in ('Trainee', 'Intern', 'Junior', 'Senior', 'Manager' , 'C-Level' ,'Freelancer')),	--Should be radio button options in C#	
			CONSTRAINT CHK_Job_JobType						Check (JobType in ('Full Time', 'Part Tine', 'Contract', 'Remote', 'Freelance')),		--Should be radio button options in C#	
			CONSTRAINT PK_Job								Primary Key (JobID, StudentID),
			CONSTRAINT FK_Student_Job						Foreign Key (StudentID) References Student(StudentID)
)

alter table Job 
add CONSTRAINT CHK_Job_Position	Check (Position in ('Trainee', 'Intern', 'Junior', 'Senior', 'Manager' , 'C-Level' ,'Freelancer'))	--Should be radio button options in C#	

Create Table Exam (											
		ExamID				int ,				--Generated from Procedure
		StudentID			int not null,
		CourseID			int not null,
		Duration			int not null,					--Duration here in minutes. and make C# Round to closest minute then send it here
		NumberOfQuestions	tinyint Default 10,				--Added Default
		TotalScore			tinyint not null,				--Changed from Score to TotalScore
		GradeChar			char(1) not null,				--Where is A from 90-100, B from 70-80 C from 50-60 F from 0-40
		    
			
			CONSTRAINT PK_Exam					            Primary Key (StudentID,ExamID) ,
			CONSTRAINT CHK_Exam_Duration					Check (Duration in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30)),
			CONSTRAINT CHK_Exam_NumberOfQuestions			Check (NumberOfQuestions = 10),
			CONSTRAINT CHK_Exam_Score						Check (TotalScore in (0,10,20,30,40,50,60,70,80,90,100)),	
			CONSTRAINT CHK_Exam_GradeChar					Check (GradeChar in ('A','B','C','F')),		
			CONSTRAINT FK_Student_Exam						Foreign Key (StudentID) References Student(StudentID),
			CONSTRAINT FK_Course_Exam						Foreign Key (CourseID) References Course(CourseID),
			CONSTRAINT FK_Exam						        Foreign Key (ExamID) References Examinfo(ExamID),
)

create table StudnetAnswer (
		StudentID			int not null,
		ExamID				int not null,
		QuestionID			int not null,
		AnswerChar			char(1) not null,
		Score				tinyint not null,

			CONSTRAINT CHK_StudentAnswer_Score				Check (Score in (10,0)),
			CONSTRAINT PK_StudentAnswers					Primary Key (ExamID, StudentID, QuestionID),
			CONSTRAINT FK_Student_StudnetAnswer				Foreign Key (StudentID) References Student(StudentID),
			CONSTRAINT FK_Question_StudnetAnswer			Foreign Key (QuestionID) References Question(QuestionID),
			CONSTRAINT FK_Exam_StudnetAnswer				Foreign Key (ExamID) References Examinfo(ExamID),
)



 create table Examinfo(
 ExamID int identity primary key,
 CourseID int,
 [Date] date)
 
Create Table ExamQuestion (
		ExamID				int not null,
		QuestionID			int not null,

			CONSTRAINT PK_ExamQuestion						Primary Key (ExamID, QuestionID),
			CONSTRAINT FK_Question_ExamQuestion				Foreign Key (QuestionID) References Question(QuestionID),
			CONSTRAINT FK_Exam_ExamQuestion					Foreign Key (ExamID) References Examinfo(ExamID),
)
