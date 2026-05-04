-- get the teachers hired in the last 2 days and in the last year
select * 
from teacher
where HIRE_DATE >= DATEADD(DAY, -2, GETDATE()) AND HIRE_DATE >= DATEADD(YEAR, -1, '2026-03-29');

--Show all subjects and their teachers
select 
s.name as subject_name,
t.name as teacher_name 
from subject s
join teacher t
on s.teacher_id =t.teacher_id ;
-- here  remember the use of joins when it comes to data that is in different tables but connected by a common key

select 
 s.name as student_name,
 p.name as parent_name
  from 
  student s
  join parentstudent ps
  on  s.student_id = ps.student_id
  join parent p
  on ps.student_id =p.parent_id;
