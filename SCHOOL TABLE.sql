CREATE TABLE TEACHER (
    TEACHER_ID INT PRIMARY KEY IDENTITY(1,1),
    NAME VARCHAR (100) NOT NULL,
    EMAIL VARCHAR (100) NOT NULL,
    CONTACT VARCHAR (100) NOT NULL,
    HIRE_DATE DATE DEFAULT GETDATE (),  
);

create table student (
    student_id int primary key identity(1,1),
    name varchar (100) NOT NULL,
    date_of_birth date NOT null,
);

create table subject(
    subject_id int primary key identity(1,1),
    name varchar (100)  NOT NULL,
    PARTICIPANTS int NOT NULL CHECK (PARTICIPANTS >=0),
    teacher_id int,

    constraint fk_subject_teacher
    foreign key (teacher_id)
    references teacher(teacher_id)
    on delete SET NULL
    on update cascade 
);

create table parent (
    parent_id int primary key NOT NULL identity (1,1),
    name varchar (100) NOT NULL,
    contact VARCHAR (100) NOT NULL,
);

create table subjectstudent (
    subject_id int NOT NULL,
    student_id int NOT NULL,

    primary key (subject_id, student_id),

    constraint fk_subjectstudent_subject
    foreign key (subject_id)
    references subject (subject_id)
    on delete cascade 
    on update cascade,

    constraint fk_subjectstudent_student
    foreign key (student_id)
    references student(student_id)
    on delete cascade 
    on update cascade
)
 create table parentstudent (
    parent_id int not null,
    student_id int not null,
    relationship varchar (50),
    primary key(parent_id, student_id ),

    constraint fk_parentstudent_parent 
    foreign key (parent_id)
    references parent(parent_id)
    on delete cascade
    on update cascade,

    constraint fk_parentstudent_student 
    foreign key (student_id)
    references student(student_id)
    on delete cascade
    on update cascade
 )

 



