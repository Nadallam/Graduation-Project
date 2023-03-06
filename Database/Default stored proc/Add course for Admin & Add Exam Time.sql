Create proc Sp_add_course 
@course_name nvarchar(30) , @duration int , @course_type bit , @req bit , @track_name nvarchar(30)
as
insert into Course (CourseName , Duration , CourseType , Required)
values (@course_name , @duration , @course_type , @req)

insert into TrackCourse (TrackID , CourseID)
values (
(select TrackID from Track where TrackName = @track_name),
(select CourseID from Course where CourseName = @course_name)
)

GO

create Proc Sp_update_Exam_time 
@Course_name nvarchar(30) , @Exam_Time date
as
Update Course
set Exam_Time = @Exam_Time
where CourseName = @Course_name

