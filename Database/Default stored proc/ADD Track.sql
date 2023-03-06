CREATE proc [dbo].[insert_into_track_and_courses]
@t_name nvarchar(30), @t_branch nvarchar(30), @nofstudent int,
@c_name nvarchar(30), @duration int, @Coursetype nvarchar(30),
@required nvarchar(3)
as
begin
insert into Track (TrackName, Branch, NumberOfStudents)
values (@t_name, @t_branch, @nofstudent)

insert into Course(CourseName, Duration, CourseType, Required)
values (@c_name, @duration,
iif(@Coursetype='Tecnichal' , 1 , 0),
iif(@required='Yes' , 1 , 0))

insert into TrackCourse (TrackID , CourseID)
values (
(select TrackID from Track where TrackName = @t_name),
(select CourseID from Course where CourseName = @c_name)
)
end

GO
create Proc [dbo].[insert_into_course]
@c_name nvarchar(30), @duration int, @Coursetype nvarchar(30),
@required nvarchar(3)
as
begin
insert into Course(CourseName, Duration, CourseType, Required)
values (@c_name, @duration,
iif(@Coursetype='Tecnichal' , 1 , 0),
iif(@required='Yes' , 1 , 0))
end

go

CREATE proc [dbo].[insert_into_track]
@t_name nvarchar(30), @t_branch nvarchar(30), @nofstudent int
as
begin
insert into Track (TrackName, Branch, NumberOfStudents)
values (@t_name, @t_branch, @nofstudent)

end

go

CREATE proc [dbo].[insert_into_trackCourse]
@t_name nvarchar(30), @c_name nvarchar(30)
as
begin
insert into TrackCourse (TrackID , CourseID)
values (
(select TrackID from Track where TrackName = @t_name),
(select CourseID from Course where CourseName = @c_name)
)

end


create proc sp_select_tarckCourse @tid int
as
begin
select c.CourseName from Course c , TrackCourse tc where tc.TrackID=@tid and tc.CourseID=c.CourseID

end


create proc sp_select_Coursebytrack @coursename nvarchar(50)
as
begin
select  t.TrackName from Course c ,Track t, TrackCourse tc 
where tc.TrackID=t.TrackID and tc.CourseID=c.CourseID and c.CourseName=@coursename

end

create proc [dbo].[sp_select_Coursebytrack2] @coursename nvarchar(50)
as
begin
select  t.TrackName as 'Track Name' , t.Branch as ' Track Branch' from Course c ,Track t, TrackCourse tc 
where tc.TrackID=t.TrackID and tc.CourseID=c.CourseID and c.CourseName=@coursename

end


create proc [dbo].[select_Coursebytrack] @coursename nvarchar(50)
as
begin
select  t.TrackName as 'Track Name' , t.Branch as ' Track Branch' from Course c ,Track t, TrackCourse tc 
where tc.TrackID=t.TrackID and tc.CourseID=c.CourseID and c.CourseName=@coursename
end
select_Coursebytrack 'SQL Database'