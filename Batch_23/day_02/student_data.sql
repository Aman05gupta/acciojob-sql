
select current_database();

create schema day_02;

create database acciojob;

select current_database();

create schema day_02;

show search_path;

set search_path to day_02;

----------------------------------------------------

-- Create AccioJob Students data table

---------Student Table-------------
create table Students(
	student_id serial primary key,
	name varchar(50),
	gender varchar(10),
	age int,
	city varchar(50)
);



--------Courses Table-------------
create table Courses(
	Course_id serial primary key,
	Course_name varchar(100),
	Duration_months int
);


--------Enrollments Table----------
create table Enrollments(
	Enrollment_id serial primary key,
	student_id int references Students(student_id),
	Courese_id int references Courses(Course_id),
	Enrollment_date date
);

--------Marks Table---------------
create Table Marks(
	mark_id serial primary key, 
	student_id int references Students(student_id),
	subject varchar(50),
	scores int
);


-- Insert dataset  

-------Students data-----------
insert into Students (name, gender, age, city) values
('Rama', 'Male', 24, 'Delhi'),
('Naman', 'Male', 22, 'Dehradun'),
('Riya', 'Female',23, 'Chandigarh');


-------Courses data-------------
insert into Courses (Course_name, Duration_months) values
('Data Science', 12),
('Machine Learning', 6),
('Data Analyst', 10);


-------Enrollment data-----------
insert into Enrollments (student_id, Courese_id, Enrollment_date) values
(1, 1,'2026-01-10'),
(2, 2,'2026-01-15'),
(3, 3,'2026-01-18');


--------Marks data---------------
insert into Marks (student_id, subject, scores) values
(1, 'Python', 85),
(1, 'SQL', 90),
(2, 'Python', 88),
(3, 'Machine Learning', 92);


--------Queries--------------

select * from students;

select * from Courses;

select * from Enrollments;

select * from Marks;