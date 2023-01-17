show databases;
USE MCA_22;
create table student (
	Roll_no int(2) primary KEY,
    Name varchar(20) not null,
    Address varchar(50) ,
    City varchar(30),
	marks_sub1 float(5,2) check(marks_sub1 >=0 and marks_sub1 <= 100),
    marks_sub2 float(5,2) check(marks_sub2 >=0 and marks_sub2 <= 100),
    marks_sub3 float(5,2) check(marks_sub3 >=0 and marks_sub3 <= 100),
    Total float(5,2) check(total >= 0 and total <= 300)
    );
    
    desc student;
    insert into student values
    (1,"sourav" , "AAA" ,"New Delhi",100,100,100,null ),
    (2,"sarhtak" , "AAA" ,"New Delhi",70.5,70,70,null ),
    (3,"bhavesh" , "DEF" ,"New Delhi",90.5,95,95,null ),
    (4,"sachin" , "BBB" ,"New Delhi",92,91,94.5,null ),
    (5,"kunal" , "KKK" ,"Bihar",91,91,93.5,null ),
    (6,"piyush" , "AGH" ,"Haryana",80,90,100,null ),
    (7,"aman" , "EEW" ,"UP",33,30,31,null ),
    (8,"rohan" , "YGU" ,"UP",87,55,68,null ),
    (9,"mayank" , "INA" ,"Bihar",78,56,76,null ),
    (10,"deepu" , "BSA" ,"New Delhi",89,87,95,null );
 
    select * from student;
    
    #2
    update student set total = marks_sub1+marks_sub2+marks_sub3;
	
    #3
    select name from student where total = (select max(total) from student);
    
    #4
    select * from student where total > (select total from student where name = "deepu"); 
    
    #5
    select name , total/3 as precentage from student;
    
    #6
    select 	name from student where marks_sub1 = (select max(marks_sub1) from student) and marks_sub2 > 50 and marks_sub3 > 50;
    
    #7
    update student set total = total + 4 where  marks_sub1 < 40 or marks_sub2 < 40 or marks_sub3 < 40 ;
    
    #8
    delete from student where marks_sub1 < 40 and marks_sub2 < 40 and marks_sub3 < 40;
    
    #9
    select AVG(total) ,city from student where not city = "Haryana" group by city ;
    
    #10
	SELECT S1.Name FROM Student as S1 WHERE
		Roll_no < 5 AND EXISTS(SELECT NULL FROM Student as S2 WHERE S2.roll_no >= 5 AND S2.Total < S1.Total);
        
	#11
    CREATE INDEX student_roll_no_name_address_city_total 
	ON Student (Roll_no, Name, Address, City, Total);
    
    DROP INDEX student_roll_no_name_address_city_total ON student;
    
    CREATE INDEX student_index 
	ON Student (Roll_no, Name, Address, City, Total);
    
    
    #12
    CREATE VIEW Student_View AS
    SELECT Roll_no, upper(name) as name, Marks_Sub1, Marks_Sub2, Marks_Sub3,(Total / 3) as Percentage FROM Student;
	
    SELECT * FROM Student_View;
    
    drop view student_view;
    
    
